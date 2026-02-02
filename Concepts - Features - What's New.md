
### 🚀 Usage
```
cd sql-scraper-v2
python sql_normalizer.py --input input.txt
```

### 📁 Project Structure
Key directories and files.

```
sql-scraper-v2/
├── README.md                        # QuickStart guide & features
├── readme_agent_sql.md              # LLM agent standards for SQL analysis
├── sql_normalizer.py                # Main Python scanner (no external dependencies)
├── protected_keywords.json          # Reserved words config (MSSQL, Snowflake, PostgreSQL)
├── input.txt                        # Your sample query (with SourceDB added)
├── 20251231-1619-QRY1.md           # Initial test output
└── 20251231-1620-QRY2.md           # Improved output with all 9+ stages
```

### ✨ Key Features Delivered
Stages, Layers, Benefits, Costs

1. **Stage Extraction** - Captured all 9+ CTEs from your complex query:
    - GroupedTransactions, RankedProductionTransactions, RankedAddOns
    - RankedDownPaymentTransactions, VoidbyPatient, VoidedTransactions
    - VoidedTransactionsWithTreatmentType, EquifaxData, PaymentPlanData
    - ContractDetails, FinalOutput
2. **4-Part Column Lineage** - Full paths like:

    - `SNOWFLAKESVC.EDW_PROD.EDW.D_TRANSACTION_TYPE.CATEGORY_DESCRIPTION`
3. **Bridge Tables** - Documented transformations with types:
    
    - **1:1**: Direct copy (`Patient_ID`)
    - **TFM**: Transformations (`CASE WHEN`, `CONCAT()`, `TRY_TO_DATE()`)
    - **AGG**: Aggregations (`SUM()`, `ROW_NUMBER()`)
4. **CASE WHEN Parsing** - Concise notation:

	```
	DTT.CATEGORY_DESCRIPTION = 'Charge' → 'Production' | ELSE DTT.CATEGORY_DESCRIPTION
	```
    
5. **Refactored Query** - Bottom of markdown file, ready to copy-paste
6. **Sequential File Versioning** - Auto-increments: `QRY1.md`, `QRY2.md`, etc.
    
### Assumptions, Considerations, Logic, Mechanisms
Degree of Control
Degree of Severity

### 📊 Sample Output

The generated markdown includes:

- Query classification (SELECT/INSERT/UPSERT/etc.)
- Stage-by-stage breakdown with source tables & join types
- Output columns list per stage
- Bridge table mapping source → target with transformation logic
- Complete refactored SQL query

### 🔄 Next Steps for You

1. Review [20251231-1620-QRY2.md](vscode-file://vscode-app/c:/Users/jonas-adam.pascua/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-browser/workbench/workbench.html) - the full analysis
2. Provide feedback on:
    - Bridge table definition format (is the notation clear?)
    - Missing transformations or edge cases
    - Refactored query quality
3. Test with additional SQL files to refine the parser

# Examples

![[Pasted image 20260105093928.png|400]]

# Sample from Obsidian
![[Pasted image 20260105095249.png|500]]

```
SHINY NEW THINGS
New Footnotes view core plugin adds a new sidebar tab that helps you manage 
footnotes for the current file without losing your place in the note. 

BREAKING CHANGES 
We have officially removed support for the properties tag , alias , cssclass in 
favor of tags , aliases and cssclasses . In addition, the values of these properties 
must be a list. If the current value is a text property, it will no longer be recognized by 
Obsidian. 
In the "Format converter" core plugin, there is a new option to fix any incorrectly 
formatted aliases , tags , and cssclasses in your vault. It will also migrate your 
old alias , tag , and cssclass properties to the new format. 

IMPROVEMENTS 
Property editor is now available inside page preview and Canvas. 
Added button to open current page preview in a tab. 
In the "Export PDF" flow, the export button now receives initial keyboard focus. 
Settings that show file or folder suggestions now use fuzzy search for better matching. 
Whitespace is now correctly shown in Sync history and file recovery diffs. 
Text selection contrast has been increased in dark mode. 
Sync history view now includes a button to open affected files in File Recovery. 
The Sync history view now shows the file name before and after it was renamed. 
File Recovery now displays file extensions in titles and suggestions for non-Markdown 
files. 
If the current tab is pinned, the "Close current tab" command will unpin the tab 
instead of closing it. Repeat the command to close the tab. 
The "Move file to..." option remains available even when the Files plugin is disabled. 
The "Save file" command now only appears in the Command Palette when a file is 

NO LONGER BROKEN 
Page preview no longer hides or switches to edit mode when the fold icon is clicked. 
Fixed display of titles in page preview for RTL languages. 
Improved how results in the command palette are sorted. By default, results are now 
sorted alphabetically. And more recently used commands will rank higher in the 
search results. 
Editing a file no longer resets folded sections in the Outline view. 
Pressing Shift—Enter inside a text property no longer creates an empty input. 
• Cursor placement is now accurate when navigating table cells after searching. 
When using the "Obsidian frame" window frame style, the Window title will now 
properly update to show the currently open file in pop-out windows. 
List numbering remains consistent when editing inside callouts. 
PDF view no longer steals focus when opened in the background. 
Strict line breaks now render properly in the first paragraph of a callout. 
Outline view now highlights the correct line when the note includes footnotes. 
Graph view: If you have saved filters, you'll no longer see an initial flash of nodes when 
you open the graph view. The filters will be applied immediately. 
• Markdown tables containing partially complete HTML now render correctly. 
Tab history buttons, Web viewer histoly entries, bookmarked URLs, and ribbon items 
that open notes now respect modifier keys and honor the "Focus new tab" preference. 
The Tags view now updates correctly when clearing the search filter. 
Autocompleting a codeblock now properly accounts for indentation and if the cursor 
is inside a list item. 
Improved the rendering of codeblocks inside quoteblocks. 
Canvas cards now support callouts without generating internal errors. 
Canvas: Fixed bug where Canvas nodes would hide when trying to move 2 groups that 

DEVELOPERS 
CSS properties added to document.body are now mirrored across all pop-out 
windows. 
ButtonComponent now automatically shows a loading spinner if the onCIick event is 
async. 
You can now bypass the Web viewer and specify that a URL is opened in the user's 
default browser using window. open(url, 
_external') . 
idb has been updated to version 8.0.2. 
yaml has been updated to version 2.7.0. 
YAML aliasing has been disabled to prevent unintended references when assigning the 
same object to multiple keys. 
Assigning the same object to multiple keys via processFrontmatter will no longer 
create a YAML alias. 
A complete list of previous changes can be found on our changelog3. 
```