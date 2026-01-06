/**
 * SCAN_RANGEА1_GET_METADATA
 * 
 * Scans data starting from cell A1 on the active sheet, creates a table, and generates metadata profile.
 * 
 * INPUTS:
 * - Active worksheet with data starting at A1
 * 
 * OUTPUTS:
 * - "MetaData Profile" sheet with:
 *   • MatrixCount table (row/column counts)
 *   • MetadataProfile table (column name, data type, key status, group info)
 *   • CodeTypes table (frequency distribution for columns ending in "group" or "code")
 * 
 * FEATURES:
 * - Analyzes all rows to infer data types (bit, money, datetime, date, int, string)
 * - Identifies primary key candidates (unique values)
 * - Extracts distinct values and frequencies for group/code columns
 */
async function main(workbook: ExcelScript.Workbook) {

	// === 1. Create Source Table ===
	const activeSheet = workbook.getActiveWorksheet();
	
	// Delete ALL tables on the active sheet to prevent overlap errors
	const allTables = activeSheet.getTables();
	for (const table of allTables) {
		table.delete();
		console.log(`Deleted existing table: ${table.getName()}`);
	}
	
	const dataRange = activeSheet.getRange("A1").getSurroundingRegion();
	const tableSrc = activeSheet.addTable(dataRange, true);
	tableSrc.setName("TableSrc");
	console.log("Created 'TableSrc'");

	// === 2. Create Summary Worksheet ===
	let summarySheet = workbook.getWorksheet("Table Summary");
	if (summarySheet) {
		summarySheet.delete();
	}
	summarySheet = workbook.addWorksheet("MetaData Profile");
	summarySheet.activate();
	console.log("Created 'MetaData Profile' sheet");

	// === 3. Create MatrixCount Table ===
	const srcRowCount = tableSrc.getRangeBetweenHeaderAndTotal()?.getRowCount() || 0;
	const srcColCount = tableSrc.getHeaderRowRange().getColumnCount();

	const matrixHeaders: string[] = ["CountType", "Qty"];
	const matrixBody: (string | number)[][] = [
		["Row Count", srcRowCount],
		["Column Count", srcColCount]
	];
	const matrixData: (string | number)[][] = [matrixHeaders, ...matrixBody];

	const matrixRange = summarySheet.getRange("A1:B3");
	matrixRange.setValues(matrixData);
	const matrixTable = summarySheet.addTable(matrixRange, true);
	matrixTable.setName("MatrixCount");
	console.log("Created 'MatrixCount' table");

	// === 4. & 5. Create MetadataProfile & CodeTypes Tables ===

	const headerNames: string[] = tableSrc.getHeaderRowRange().getValues()[0] as string[];
	const bodyRange = tableSrc.getRangeBetweenHeaderAndTotal();
	const dataValues: (string | number | boolean)[][] = srcRowCount > 0 ? bodyRange.getValues() : [];
	const dataFormats: string[][] = srcRowCount > 0 ? bodyRange.getNumberFormats() : [];

	// --- MetadataProfile Table ---
	const metadataHeaders: string[] = ["Column Name", "Data Type", "Is Key?", "Group Count", "Group List Sample (Top 5)"];
	const metadataTableData: (string | number)[][] = [metadataHeaders];

	// --- NEW: Initialize CodeTypes Table Data ---
	const codeTypesTableData: (string | number)[][] = [
		["ColumnName", "Distinct Value", "Count"]
	];

	// Loop through each COLUMN
	for (let i = 0; i < srcColCount; i++) {
		const colName: string = headerNames[i];
		const columnData: (string | number | boolean)[] = dataValues.map((row) => row[i]);
		const columnFormats: string[] = dataFormats.map((row) => row[i]);

		let dataType: string = "string";
		let isKey: string = "No";
		let groupCount: string | number = "";
		let groupList: string = "";

		if (srcRowCount === 0) {
			dataType = "string";
			isKey = "Yes";
		} else {
			// 1. Data Type Analysis
			const uniqueValues = [...new Set(columnData.map((v) => v?.toString().toUpperCase()))];
			const uniqueFormats = [...new Set(columnFormats)];

			if (uniqueValues.length <= 2 && (uniqueValues.includes("TRUE") || uniqueValues.includes("FALSE") || uniqueValues.includes("0") || uniqueValues.includes("1"))) {
				dataType = "bit";
			}
			else if (uniqueFormats.every((f) => f.includes("$"))) {
				dataType = "money";
			} else if (uniqueFormats.every((f) => (f.includes("m") || f.includes("d")) && (f.includes("h") || f.includes("s")))) {
				dataType = "datetime";
			} else if (uniqueFormats.every((f) => f.includes("m") || f.includes("d") || f.includes("y"))) {
				dataType = "date";
			}
			else if (columnData.every((v) => typeof v === 'number' && Number.isInteger(v))) {
				dataType = "int";
			} else {
				dataType = "string";
			}

			// 2. Is Key? Analysis (No Duplicates)
			const distinctSet = new Set(columnData);
			if (distinctSet.size === columnData.length) {
				isKey = "Yes";
			}

			// 3. Group Analysis
			const lowerColName: string = colName.toLowerCase();
			const hasDuplicates: boolean = distinctSet.size < columnData.length;

			if ((lowerColName.endsWith("group") || lowerColName.endsWith("code")) && hasDuplicates) {
				// --- Logic for MetadataProfile Table ---
				const distinctGroups: string[] = [...distinctSet]
					.filter((v) => v !== null && v !== undefined && v !== "")
					.map((v) => v.toString());

				groupCount = distinctGroups.length;
				groupList = distinctGroups
					.sort()
					.slice(0, 5) // Get Top 5
					.join(", ");

				// --- NEW: Logic for CodeTypes Table ---
				const frequencyMap = new Map<string, number>();
				for (const val of columnData) {
					// Skip blanks
					if (val === null || val === undefined || val === "") {
						continue;
					}
					const valString = val.toString();
					frequencyMap.set(valString, (frequencyMap.get(valString) || 0) + 1);
				}

				// Add map entries to the table data
				frequencyMap.forEach((count, distinctValue) => {
					codeTypesTableData.push([colName, distinctValue, count]);
				});
			}
		}

		// Push the data row to the MetadataProfile array
		metadataTableData.push([colName, dataType, isKey, groupCount, groupList]);
	}

	// --- Write the MetadataProfile Table ---
	const metadataStartCell = summarySheet.getRange("A5");
	if (metadataTableData.length > 1) { // > 1 because it includes header
		const numRows = metadataTableData.length;
		const numCols = metadataTableData[0].length;
		const tableRange = metadataStartCell.getResizedRange(numRows - 1, numCols - 1);
		tableRange.setValues(metadataTableData);

		// --- CHANGED: Renamed table ---
		let oldMetaTable = workbook.getTable("MetadataProfile");
		if (oldMetaTable) {
			oldMetaTable.delete();
		}
		const metadataTable = summarySheet.addTable(tableRange, true);
		metadataTable.setName("MetadataProfile"); // CHANGED
		console.log("Created 'MetadataProfile' table"); // CHANGED
	} else {
		console.log("No metadata to write.");
	}

	// --- NEW: Write the CodeTypes Table ---
	if (codeTypesTableData.length > 1) { // > 1 because it includes header
		// Start 2 rows down from the metadata table
		const codeTypesStartCell = metadataStartCell.getOffsetRange(metadataTableData.length + 2, 0);

		const numRows = codeTypesTableData.length;
		const numCols = codeTypesTableData[0].length; // which is 3

		const codeTypesRange = codeTypesStartCell.getResizedRange(numRows - 1, numCols - 1);
		codeTypesRange.setValues(codeTypesTableData);

		// Delete old "CodeTypes" table if it exists
		let oldCodeTypesTable = workbook.getTable("CodeTypes");
		if (oldCodeTypesTable) {
			oldCodeTypesTable.delete();
		}

		// Create the new table
		const codeTypesTable = summarySheet.addTable(codeTypesRange, true);
		codeTypesTable.setName("CodeTypes");
		console.log("Created 'CodeTypes' table");
	} else {
		console.log("No 'group' or 'code' columns found for 'CodeTypes' table.");
	}

	// Auto-fit all columns on the sheet at the very end
	summarySheet.getUsedRange().getFormat().autofitColumns();
}