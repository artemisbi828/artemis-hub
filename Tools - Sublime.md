[[Tools - Key Bindings]]

# Learnings
2026-02-05 10:38 AM -- Load Terminus;  MUST SAVE AS UTF8 encoding (Error received `Unable to parse value: Unexpected newline at Packages/User/Context.sublime-menu:15:19`); TsqlCreateTableCommand → tsql_create_table

# Setup + Commands
- `Ctrl + Shift + P` -- install Package Control
- `Ctrl + Shift + P` -- Remove Package --> 
- `Ctrl + ``  
- `Ctrl + ``  --> Terminus



2026-01-09 03:17 PM

```
FormatToSqlValuesCommand → format_to_sql_values   # drop command, convert to pascal case
```



# Change KeyBindings
Preferences → Key Bindings → Default (Windows).sublime-keymap

```json
// changes so it's like VS Code vs ctrl+shift+(up/down)
[
	{ "keys": ["ctrl+o"], "command": "show_overlay", "args": {"overlay": "goto", "show_files": true} },
	{ "keys": ["ctrl+p"], "command": "show_overlay", "args": {"overlay": "command_palette"} },
	{ "keys": ["ctrl+shift+i"], "command": "select_lines", "args": {"forward": false} },
	{ "keys": ["ctrl+shift+m"], "command": "select_lines", "args": {"forward": true} },
	{ "keys": ["f10"], "command": "permute_lines", "args": {"operation": "unique"} }
]
```

Preferences → Package Settings → Logbook → Settings

# Sublime XLS to MD Script
### 1. Create the Plugin Script
1. Open Sublime Text.
2. Go to **Tools > Developer > New Plugin...**
3. Delete the existing code and paste this:

## Script PY
Save as `excel_to_markdown.py`

```python

import sublime
import sublime_plugin
import re

class ExcelToMarkdownCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        print("[ExcelToMarkdown] Command triggered") # Diagnostic log
        
        for region in self.view.sel():
            if region.empty():
                region = sublime.Region(0, self.view.size())
            
            content = self.view.substr(region).strip()
            if not content:
                continue

            # DETECTION LOGIC
            # If the content contains | and a separator line |---| it's likely Markdown
            is_markdown = bool(re.search(r'\|.*\|', content)) and bool(re.search(r'\|[:\s-]*\|', content))

            if is_markdown:
                print("[ExcelToMarkdown] Detected Markdown -> Converting to Tabs")
                result = self.markdown_to_tabs(content)
            else:
                print("[ExcelToMarkdown] Detected Tabs/Excel -> Converting to Markdown")
                result = self.tabs_to_markdown(content)

            self.view.replace(edit, region, result)

    def tabs_to_markdown(self, content):
        lines = content.split('\n')
        md_rows = []
        for i, line in enumerate(lines):
            columns = [col.strip() for col in line.split('\t')]
            md_rows.append("| " + " | ".join(columns) + " |")
            if i == 0: # Add the separator after headers
                md_rows.append("|" + "|".join(['---' for _ in columns]) + "|")
        return "\n".join(md_rows)

    def markdown_to_tabs(self, content):
        lines = content.split('\n')
        tab_rows = []
        for line in lines:
            # Skip the separator line |---|---
            if re.match(r'^[|\s:-]+$', line):
                continue
            # Remove outer pipes and split by inner pipes
            clean_line = line.strip().strip('|')
            columns = [col.strip() for col in clean_line.split('|')]
            tab_rows.append("\t".join(columns))
        return "\n".join(tab_rows)
            
```

## Script to Call 
Save `Context.sublilme-menu` in `C:\Users\jonas-adam.pascua\AppData\Roaming\Sublime Text\Packages\User` 
```shell
-- need to save as UTF-8 to make sure no hidden chars

[
    { "caption": "-", "id": "separator" },
    {
        "caption": "Convert Excel to Markdown",
        "command": "excel_to_markdown"
    }
]
```

### Notes
**Verify the Command Naming Convention**
Sublime uses a specific logic to map Python classes to command names.

- **The Rule:** A class named `ExcelToMarkdownCommand` is converted by Sublime to `excel_to_markdown` (Snake Case).    
- **Diagnostic:** Open your `excel_to_markdown.py` and ensure the class name is exactly `ExcelToMarkdownCommand`. If you named the class `ExcelToMdCommand`, the command in your menu file must be changed to `"command": "excel_to_md"`.

`
# Sublime JSON to XLS
```python
import sublime
import sublime_plugin
import json

class JsonToExcelTableCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for region in self.view.sel():
            if region.empty():
                region = sublime.Region(0, self.view.size())
            
            content = self.view.substr(region)
            
            try:
                # Parse the JSON
                data = json.loads(content)
                
                output_rows = []
                headers = []
                
                # Logic to handle the specific structure provided
                # It looks for keys (like "ticket") that contain lists of objects
                for category, items in data.items():
                    if isinstance(items, list):
                        for item in items:
                            # Build headers dynamically from the first item found
                            if not headers:
                                headers = ["Type"] + [k[0].upper() + k[1:] for k in item.keys()]
                                output_rows.append("\t".join(headers))
                            
                            # Build the row: Category (Ticket) + values
                            row = [category.capitalize()] + [str(v) for v in item.values()]
                            output_rows.append("\t".join(row))
                
                # Replace the text with the tab-delimited table
                self.view.replace(edit, region, "\n".join(output_rows))
                
            except Exception as e:
                sublime.error_message("JSON Parsing Error: " + str(e))
```



---
#quick-paste-merge-later 
In Sublime Text, the inconsistency you’re seeing between two tabs—even if they seem identical—usually comes down to a feature called **"Indentation Detection."**

When you open a tab or a file, Sublime looks at the content and makes a "guess" about how that specific tab should handle tabs and spaces. This creates a **View-Specific Setting** that overrides your global preferences.

Here is exactly why your two tabs are behaving differently:

### 1. The "First Paste" Rule (Indentation Detection)

Sublime has a setting called `detect_indentation` (True by default).

- **Tab A (The "Spaces" tab):** If you pasted something into this tab earlier that contained spaces, or if it was a file that already had spaces, Sublime likely "detected" that this tab should be in "Space Mode." Once it decides a tab is a "Space Tab," any future paste—even a "clean" one from Excel—will have its tabs automatically converted to spaces to match the tab's current "personality."
    
- **Tab B (The "Tabs" tab):** If this tab was empty or the first thing you pasted was tab-heavy, Sublime stayed in "Tab Mode," preserving the Excel format.
    

### 2. Check the Status Bar (The "Smoking Gun")

Look at the **bottom right corner** of your Sublime window for both tabs. You will likely see a difference:

- One tab will say **"Spaces: 4"** (or 2).
    
- The other tab will say **"Tab Size: 4"**.
    

If it says "Spaces," Sublime will intercept your clipboard and "translate" the tabs from Excel into spaces the moment they hit the page.

### 3. How to force consistency

If you want Sublime to stop "guessing" and just do what you tell it to do, you can change your settings:

1. Go to **Preferences** > **Settings**.
    
2. In the **User** (right-hand) pane, add these lines:
    
    JSON
    
    ```
    "translate_tabs_to_spaces": false,
    "detect_indentation": false
    ```
    
    - `translate_tabs_to_spaces: false` ensures that a Tab remains a literal Tab character.
        
    - `detect_indentation: false` stops Sublime from looking at the file content and switching modes on you automatically.
        

### Summary of what happened

- **Tab 1:** Something (a previous paste or a single space) convinced Sublime this was a "Spaces" file. It converted your Excel tabs to spaces to "help" you stay consistent.
    
- **Tab 2:** Sublime hadn't "locked in" a preference yet, or it correctly identified it as a "Tab" file, so it let the Excel data pass through untouched.
    

**Would you like me to show you the keyboard shortcut to quickly convert those spaces back into tabs if you’ve already pasted them?**


# Logs
2026-01-09 03:20 PM 
```
Write a Python Plugin Script for Sublime to take BEFORE → AFTER
1. wrap between tabs ''
2. add (), to each line
3. on the last line remove the last ","
4. Any word boundaries that are numeric, remove '' wrap


BEFORE
ContractKey	DateKey	patID	ptstatCode
953915	2025-11-12	MED017876	StartNeeded
959009	2025-11-20	MEE101487	StartNeeded
950851	2025-11-06	MWE063532	StartNeeded

AFTER
(953915, '2025-11-12', 'MED017876', 'StartNeeded'),
(959009, '2025-11-20', 'MEE101487', 'StartNeeded'),
(950851, '2025-11-06', 'MWE063532', 'StartNeeded')

```