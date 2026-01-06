/**
 * SCAN_ALLTABLES_GET_METADATA
 * 
 * Scans ALL tables in the workbook, infers data types using first/last 200 rows, validates data consistency, and generates metadata report.
 * 
 * INPUTS:
 * - One or more Excel tables in the workbook
 * 
 * OUTPUTS:
 * - "Metadata" sheet with:
 *   • TableSummary table (table name, row count, column count)
 *   • ColumnDetails table (table name, column name, data type, key status, % null)
 * 
 * FEATURES:
 * - Smart sampling: Uses first 200 + last 200 rows for type inference
 * - Data type detection: bit, int, numeric, date, string (based on >50% majority)
 * - DATA VALIDATION: Checks ALL rows for consistency, throws error if dirty data detected
 * - Error reporting: Lists affected columns and row numbers
 * - Null percentage calculation per column
 * 
 * VALIDATION:
 * Script will STOP and display warning if inconsistent data types found.
 * Example: "Column 'AgeInYears' has 5 non-int values. Rows: 102, 103, 104."
 */

async function main(workbook: ExcelScript.Workbook) {
	console.log("=== Starting Table Metadata Scanner ===");

	// === 1. Get All Tables in the Workbook ===
	const allTables = workbook.getTables();
	
	if (allTables.length === 0) {
		console.log("No tables found in workbook");
		return;
	}

	console.log(`Found ${allTables.length} table(s) to analyze`);

	// === 2. Create or Clear Metadata Sheet ===
	let metadataSheet = workbook.getWorksheet("Metadata");
	if (metadataSheet) {
		metadataSheet.delete();
		console.log("Deleted existing 'Metadata' sheet");
	}
	metadataSheet = workbook.addWorksheet("Metadata");
	metadataSheet.activate();
	console.log("Created 'Metadata' sheet");

	// === 3. Initialize Output Arrays ===
	const summaryData: (string | number)[][] = [
		["TableName", "CountType", "Qty"]
	];

	const detailData: (string | number)[][] = [
		["TableName", "Column Name", "Data Type", "Is Key?", "% Null"]
	];

	// Track validation errors
	const validationErrors: string[] = [];

	// === 4. Loop Through Each Table ===
	for (const table of allTables) {
		const tableName = table.getName();
		console.log(`\nAnalyzing table: ${tableName}`);

		// Get table dimensions
		const headerRange = table.getHeaderRowRange();
		const bodyRange = table.getRangeBetweenHeaderAndTotal();
		
		if (!bodyRange) {
			console.log(`Table ${tableName} has no data rows, skipping...`);
			continue;
		}

		const rowCount = bodyRange.getRowCount();
		const colCount = headerRange.getColumnCount();
		const headerNames: string[] = headerRange.getValues()[0] as string[];

		// Get all data for analysis
		const allDataValues: (string | number | boolean)[][] = bodyRange.getValues();

		// === Identify and Filter Empty Rows ===
		const filteredDataValues: (string | number | boolean)[][] = [];
		const emptyRowIndices: number[] = [];
		
		for (let i = 0; i < allDataValues.length; i++) {
			const row = allDataValues[i];
			const isEmptyRow = row.every(cell => cell === null || cell === undefined || cell === "");
			if (isEmptyRow) {
				emptyRowIndices.push(i);
			} else {
				filteredDataValues.push(row);
			}
		}

		if (emptyRowIndices.length > 0) {
			console.log(`  Found ${emptyRowIndices.length} empty rows (will be excluded from analysis)`);
		}

		const actualRowCount = filteredDataValues.length;

		// Add summary rows for this table
		summaryData.push([tableName, "Row Count", actualRowCount]);
		summaryData.push([tableName, "Column Count", colCount]);

		// === 5. Analyze Each Column ===
		for (let colIdx = 0; colIdx < colCount; colIdx++) {
			const columnName = headerNames[colIdx];
			console.log(`  Analyzing column: ${columnName}`);

			// Extract column data (from filtered data)
			const columnData: (string | number | boolean)[] = filteredDataValues.map(row => row[colIdx]);

			// Determine sample rows for data type inference
			const sampleIndices = getSampleIndices(actualRowCount);
			const sampleData = sampleIndices.map(idx => columnData[idx]);

			// === Data Type Inference ===
			const typeInference = inferDataType(sampleData, sampleIndices, columnName, tableName);
			
			// === Validate Consistency Across All Rows ===
			const validationResult = validateDataTypeConsistency(
				columnData, 
				typeInference.dataType, 
				columnName, 
				tableName
			);

			if (!validationResult.isValid) {
				validationErrors.push(validationResult.errorMessage);
			}

			// === Key Detection (No Duplicates) ===
			const distinctSet = new Set(columnData.filter(v => v !== null && v !== undefined && v !== ""));
			const nonNullCount = columnData.filter(v => v !== null && v !== undefined && v !== "").length;
			const isKey = distinctSet.size === nonNullCount && nonNullCount === actualRowCount ? "Yes" : "No";

			// === Null Percentage Calculation ===
			const nullCount = columnData.filter(v => v === null || v === undefined || v === "").length;
			const nullPercentage = actualRowCount > 0 ? ((nullCount / actualRowCount) * 100).toFixed(1) + "%" : "0%";

			// Add detail row
			detailData.push([
				tableName,
				columnName,
				typeInference.dataType,
				isKey,
				nullPercentage
			]);
		}
	}

	// === 6. Check for Validation Errors ===
	if (validationErrors.length > 0) {
		const errorCount = validationErrors.length;
		const errorSummary = `WARNING: ${errorCount} column${errorCount > 1 ? 's have' : ' has'} inconsistent datatypes\n` + 
			validationErrors.join("\n");
		
		console.log("\n" + errorSummary);
		throw new Error(errorSummary);
	}

	// === 7. Write Summary Table ===
	if (summaryData.length > 1) {
		const summaryRange = metadataSheet.getRange("A1").getResizedRange(
			summaryData.length - 1, 
			summaryData[0].length - 1
		);
		summaryRange.setValues(summaryData);
		const summaryTable = metadataSheet.addTable(summaryRange, true);
		summaryTable.setName("TableSummary");
		console.log("\nCreated 'TableSummary' table");
	}

	// === 8. Write Detail Table ===
	if (detailData.length > 1) {
		const detailStartRow = summaryData.length + 2; // Leave a blank row
		const detailRange = metadataSheet.getRange(`A${detailStartRow}`).getResizedRange(
			detailData.length - 1,
			detailData[0].length - 1
		);
		detailRange.setValues(detailData);
		const detailTable = metadataSheet.addTable(detailRange, true);
		detailTable.setName("ColumnDetails");
		console.log("Created 'ColumnDetails' table");
	}

	// === 9. Format Sheet ===
	metadataSheet.getUsedRange().getFormat().autofitColumns();
	console.log("\n=== Table Metadata Scanner Complete ===");
}

// === Helper Functions ===

/**
 * Get sample indices: first 200 rows and last 200 rows (or all if fewer)
 */
function getSampleIndices(totalRows: number): number[] {
	const indices: number[] = [];
	
	if (totalRows <= 400) {
		// Use all rows if 400 or fewer
		for (let i = 0; i < totalRows; i++) {
			indices.push(i);
		}
	} else {
		// First 200 rows
		for (let i = 0; i < 200; i++) {
			indices.push(i);
		}
		// Last 200 rows
		for (let i = totalRows - 200; i < totalRows; i++) {
			indices.push(i);
		}
	}
	
	return indices;
}

/**
 * Infer data type from sample data - determines the EXPECTED type based on majority
 */
function inferDataType(
	sampleData: (string | number | boolean)[], 
	sampleIndices: number[],
	columnName: string,
	tableName: string
): { dataType: string } {
	
	// Filter out null/empty values for analysis
	const nonNullData = sampleData.filter(v => v !== null && v !== undefined && v !== "");
	
	if (nonNullData.length === 0) {
		return { dataType: "string" };
	}

	// Check for bit/boolean type
	const uniqueValues = new Set(nonNullData.map(v => v.toString().toUpperCase()));
	if (uniqueValues.size <= 2) {
		const values = Array.from(uniqueValues);
		const isBit = values.every(v => 
			v === "TRUE" || v === "FALSE" || 
			v === "1" || v === "0" || 
			v === "YES" || v === "NO"
		);
		if (isBit) {
			return { dataType: "bit" };
		}
	}

	// Count how many values match each type
	let intCount = 0;
	let numericCount = 0;
	let dateCount = 0;
	let stringCount = 0;

	for (const value of nonNullData) {
		if (typeof value === "boolean") {
			continue; // Skip booleans in type detection
		}

		let matchedType = false;

		// Check if it's a date FIRST (Excel stores dates as numbers, so check before number parsing)
		if (typeof value === "number") {
			// Check if it's an Excel date serial number (typically between 1 and 50000+ for modern dates)
			if (value > 1 && value < 2958465) { // Excel date range (1900-01-01 to 9999-12-31)
				dateCount++;
				matchedType = true;
			} else if (Number.isInteger(value)) {
				intCount++;
				numericCount++;
				matchedType = true;
			} else {
				numericCount++;
				matchedType = true;
			}
		} else {
			// It's a string, check if it can be parsed
			const strValue = value.toString().trim();
			
			// Try to parse as date first (dates are more specific)
			if (isDateString(strValue)) {
				dateCount++;
				matchedType = true;
			}
			// Try to parse as number
			else {
				const numValue = Number(strValue);
				if (!isNaN(numValue) && strValue !== "") {
					if (Number.isInteger(numValue)) {
						intCount++;
						numericCount++;
					} else {
						numericCount++;
					}
					matchedType = true;
				}
			}
		}

		// If no specific type matched, it's a string
		if (!matchedType) {
			stringCount++;
		}
	}

	// Determine data type based on MAJORITY (>50% threshold)
	const totalCount = nonNullData.length;
	const threshold = totalCount * 0.5;

	if (dateCount > threshold) {
		return { dataType: "date" };
	} else if (intCount > threshold) {
		return { dataType: "int" };
	} else if (numericCount > threshold) {
		return { dataType: "numeric" };
	} else {
		return { dataType: "string" };
	}
}

/**
 * Check if a string looks like a date
 */
function isDateString(value: string): boolean {
	if (!value || value.trim() === "") {
		return false;
	}

	// Try to parse as date
	const dateValue = new Date(value);
	if (isNaN(dateValue.getTime())) {
		return false;
	}

	// Check for common date patterns
	const datePatterns = [
		/^\d{1,2}\/\d{1,2}\/\d{2,4}$/,  // MM/DD/YYYY or M/D/YY
		/^\d{4}-\d{2}-\d{2}$/,           // YYYY-MM-DD
		/^\d{1,2}-\d{1,2}-\d{2,4}$/,     // MM-DD-YYYY
		/^\d{2,4}\/\d{1,2}\/\d{1,2}$/    // YYYY/MM/DD
	];

	return datePatterns.some(pattern => pattern.test(value.trim()));
}

/**
 * Validate data type consistency across all rows
 */
function validateDataTypeConsistency(
	columnData: (string | number | boolean)[],
	expectedType: string,
	columnName: string,
	tableName: string
): { isValid: boolean; errorMessage: string } {
	
	const inconsistentRows: number[] = [];
	
	for (let i = 0; i < columnData.length; i++) {
		const value = columnData[i];
		
		// Skip null/empty values
		if (value === null || value === undefined || value === "") {
			continue;
		}

		let isConsistent = true;

		switch (expectedType) {
			case "bit":
				const strVal = value.toString().toUpperCase();
				isConsistent = strVal === "TRUE" || strVal === "FALSE" || 
							   strVal === "1" || strVal === "0" || 
							   strVal === "YES" || strVal === "NO" ||
							   typeof value === "boolean";
				break;

			case "int":
				if (typeof value === "number") {
					isConsistent = Number.isInteger(value);
				} else {
					const numVal = Number(value.toString().trim());
					isConsistent = !isNaN(numVal) && Number.isInteger(numVal);
				}
				break;

			case "numeric":
				if (typeof value === "number") {
					isConsistent = true;
				} else {
					const numVal = Number(value.toString().trim());
					isConsistent = !isNaN(numVal);
				}
				break;

			case "date":
				if (typeof value === "string") {
					isConsistent = isDateString(value);
				} else if (typeof value === "number") {
					// Excel stores dates as numbers
					isConsistent = true;
				} else {
					isConsistent = false;
				}
				break;

			case "string":
				// Strings can accept anything
				isConsistent = true;
				break;
		}

		if (!isConsistent) {
			inconsistentRows.push(i + 1); // +1 for 1-based row numbering (excluding header)
		}
	}

	// Report errors only if there are inconsistencies
	if (inconsistentRows.length > 0) {
		const rowSample = inconsistentRows.slice(0, 10).join(", ");
		const additionalCount = inconsistentRows.length > 10 ? ` (and ${inconsistentRows.length - 10} more)` : "";
		const errorMsg = `Column '${columnName}' in table '${tableName}' has ${inconsistentRows.length} non-${expectedType} values. Rows: ${rowSample}${additionalCount}.`;
		
		return { isValid: false, errorMessage: errorMsg };
	}

	return { isValid: true, errorMessage: "" };
}