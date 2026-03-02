#open-loop/quick-paste-merge-later 
The modern robust approach to data dictionaries in Power BI has moved away from manual text boxes toward **Metadata-as-Code**. By treating your definitions as data (SQL or Markdown), you ensure that when a calculation changes in your code, it updates on the dashboard automatically.

Here are the best strategies for both SQL and Markdown approaches.

---

## Strategy 1: SQL Table (The "Single Source of Truth")

This is the most scalable method. You maintain a table in your warehouse (or an Excel file in SharePoint) that maps your technical measure names to business definitions.

### 1. The Setup

Create a table with three columns: `Object Name`, `Business Term`, and `Definition`.

| Object Name | Business Term | Definition |
| --- | --- | --- |
| `[Net Production TY]` | Net Production | Total gross production minus adjustments and write-offs for the current year. |

### 2. The Implementation (Hover Tooltip)

To make this "on-demand," use a **Report Page Tooltip**.

1. **Create a Tooltip Page:** Create a small, hidden page. Set the Page Size to "Tooltip."
2. **Add a Card/Table:** Place a card visual on this page that displays the `Definition` column.
3. **The Trigger:** On your main report, place an "Information" icon (or use the visual itself). Under **Properties > Tooltips**, select your new Tooltip Page.
4. **DAX Filter:** Use a simple DAX measure to filter the tooltip to the specific measure being hovered over using `SELECTEDVALUE(DataDictionary[Definition])`.

---

## Strategy 2: Markdown Files (The "Developer-First" Approach)

If you are already documenting your measures in **Obsidian** or **GitHub** using Markdown, you can ingest these files directly into Power BI.

### 1. The Setup

Organize your Markdown files with a consistent header, or keep one master `Dictionary.md` file.

### 2. The Power Query Bridge

You can use Power Query to "scrape" your own Markdown files.

```powerquery
let
    Source = Folder.Files("C:\YourVault\Documentation"),
    KeepMarkdown = Table.SelectRows(Source, each ([Extension] = ".md")),
    ImportText = Table.AddColumn(KeepMarkdown, "Content", each Text.FromBinary([Content])),
    // Use Splitter.SplitTextByDelimiter to extract terms between ## headers
    ExtractDefinitions = ... 
in
    ExtractDefinitions

```

### 3. The Implementation (Dynamic Documentation Page)

Use a **Markdown Viewer Visual** (like the "HTML Content" or "Markdown Viewer" custom visuals from AppSource).

* Users select a measure from a slicer.
* The Markdown content for that measure renders instantly on the screen with full formatting (bolding, lists, etc.).

---

## Strategy 3: Tabular Editor "Description" Property (The "Pro" Choice)

This is the most "integrated" way. Every measure in Power BI has a hidden **Description** property.

1. Open **Tabular Editor**.
2. Paste your business definition into the **Description** field of the measure.
3. **Automatic Tooltips:** In Power BI Desktop, if a user hovers over a measure in the "Fields" pane, they see that description.
4. **Dynamic Dictionary:** You can use a **DMV (Dynamic Management View)** to extract these descriptions into a table visual on an "Info" page.

**The DMV Query:**

```dax
EVALUATE 
SELECTCOLUMNS(
    INFO.MEASURES(),
    "Measure Name", [Name],
    "Business Logic", [Description]
)

```

---

## Comparison Table

| Feature | SQL Table | Markdown / Obsidian | Tabular Editor (DMV) |
| --- | --- | --- | --- |
| **Maintenance** | Easy for Business Users | Best for Developers | Best for Technical Docs |
| **Automation** | Fully Automated | Requires File Sync | Native to PBI Model |
| **Rich Text** | Limited (Plain Text) | Full Formatting | Plain Text |
| **On-Demand** | Tooltip Page | Help Overlay / Modal | Hover on Fields Pane |

---

## Modern Robust Recommendation: The "Help Overlay"

Instead of a tooltip, use a **Mobile-style Overlay**.

1. Create a "Help" button.
2. Use a **Bookmark** to trigger a semi-transparent shape that covers the screen.
3. Place a **Table Visual** on top of that shape, filtered to the measures shown on that specific page.
4. This gives the user a "Context-Aware" dictionary without them leaving the report.

---

### Obsidian Cheat Sheet: Dictionary DMV

Add this to your vault to quickly pull your descriptions out of your model and into a documentation table:

```dax
-- Run this in DAX Query View to see all your hard work
EVALUATE
FILTER(
    SELECTCOLUMNS(
        INFO.MEASURES(),
        "Measure", [Name],
        "Definition", [Description]
    ),
    NOT(ISBLANK([Definition]))
)

```

**Would you like me to write a Power Query script that can specifically parse an Obsidian Markdown file and turn it into a Key-Value table for your Power BI dictionary?**