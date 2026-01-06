## Keybinding 

| /\bData Output\b/        | Search "Data Output" → Word-Boundary               |
| ------------------------ | -------------------------------------------------- |
| Search Filename          | file:"Dashboard -"                                 |
| Ctrl + Del               | Delete Tab                                         |
| `Alt + Shift {Up, Down}` | Add Cursor {Up, Down}                              |
| Ctrl + Shift + [         | Toggle -- Cold Folding                             |
| Alt + LeftClick          | Multi-Select (cant' Ctrl+Alt+Up b/c of Autohotkey) |
| Alt {3, 4}               | Navigate Back & Forward                            |
| Ctrl + D                 | Delete                                             |
| Ctrl + H                 | Find and replace, \n\n+ --> \n                     |
| Ctrl + ?; + B            | Comment Line; Bold                                 |
| Ctrl + Shift {Up, Down}  | Row Up, Row Down                                   |
| `Alt+Up, Alt+Down`       | Line up; Line Down                                 |

---
1. emphasize Dictionary and use DataView + YAML formatter more
	- use a template to create DICT items
2. use a template w YAML for Contacts
3. use TQNs more
	- `> [!TIP]`
	- `[[Ref|CustomName`

- [log :: 2025-12-26 04:15PM] -- digest this [2025-12-26 0416PM]


link parent to child → (M) parents
link child to parent → (1) parent
have both links? → M:M


Ctrl + drag-drop into doc: create a link instantly

| **Feature**            | **Syntax**                   | **Explanation**                                                                                                                                                                   |
| ---------------------- | ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Basic Link**         | `[[Note Name]]`              | Links to `Note Name.md`. Auto-complete triggers when you type `[[`.                                                                                                               |
| **Aliased Link**       | `[[Note Name\|Custom Text]]` | Links to `Note Name` but displays "Custom Text".                                                                                                                                  |
| **Header Link**        | `[[Note Name#Header]]`       | Links directly to a specific H1-H6 header in that note.                                                                                                                           |
| **Block Link**         | `[[Note Name^blockid]]`      | Links to a specific paragraph. Type `^test1` at the end of a paragraph to generate an ID (nospace). Invoke by start typing `[[YourNoteName#` then `^` and auto-suggest will occur |
| **Embed (Transclude)** | `![[Note Name]]`             | **Renders** the linked note (or image) inside the current note.                                                                                                                   |
|                        | `[[note]]`                   | Internal link to a note                                                                                                                                                           |
|                        | `[text]`                     | Plain text in brackets                                                                                                                                                            |
|                        | `[text](url)`                | External link                                                                                                                                                                     |
|                        | `![[note]]`                  | Embed a note                                                                                                                                                                      |
|                        | `![](image.png)`             | Embed an image                                                                                                                                                                    |
|                        |                              |                                                                                                                                                                                   |

https://www.youtube.com/watch?v=d8fXEhWy_rY (From Sergio) #status/todo 




---
#quick-paste-merge-later 

**Modular/Atomic** note-taking structure, "Gold Standard" for Obsidian power users.

However, moving files and updating links every time a note grows can become a chore. Here is a breakdown of why your approach is solid, along with some modern "tweaks" to make it more robust.

---

## 1. The "Single Source of Truth" Strategy

Your idea of starting with one note and splitting it later is good, but you can optimize it by using **Headings and Transclusions (Embeds)** instead of just hyperlinks.

### Phase A: The Combined Note (The Beginning)

Keep everything in one note titled `Extract String`. Use H2 headings for each language.

Markdown

````
# Extract String
## SQL
```sql
SELECT SUBSTRING(col, 1, 5)...
````

## PySpark

Python

```
df.withColumn('new', substring('col', 1, 5))
```

````

### Phase B: The TOC Note (The Growth)
When the PySpark section gets complex (e.g., you add Regex, `split_part`, and edge cases), move that content to a new note: `Extract String (PySpark)`.

**The "Robust" Tweak:** Instead of just a link, use an **Embed** ($!$) in your main `Extract String` note.
```markdown
# Extract String
Check below for specific implementations:

- [[Extract String (SQL)]]
- ![[Extract String (PySpark)#Regex Implementation]] 
- [[Extract String (Python)]]
````

This allows you to see the code _inside_ the main note without it cluttering the file, keeping the "Table of Contents" functional rather than just a list of links.

---

## 2. Leverage Properties (YAML) for Global Searching

As a developer, you want to be able to query your notes like a database. Add **Properties** to the top of every syntax-specific note.

YAML

```
---
language: pyspark
category: string-manipulation
type: syntax-ref
---
```

**Why do this?** If you use the **Dataview** plugin, you can create a "Dashboard" note that automatically lists every single `string-manipulation` note you've ever written, regardless of where they are stored in your folders.

---

## 3. Alternative: The "Side-by-Side" Table

If your snippets are short, a **Table** in the master note is often more "robust" for quick comparisons than separate files.

|**Language**|**Task**|**Snippet**|
|---|---|---|
|**SQL**|Extract|`SUBSTR(col, 1, 3)`|
|**PySpark**|Extract|`f.substring('col', 1, 3)`|
|**Python**|Extract|`text[0:3]`|

---

## 4. Is this "Optimal"?

Your proposed method is optimal because it follows the **"Don't Over-Engineer Early"** rule.

- **Pros:** You don't waste time creating 5 empty files for every new concept. You only split when the friction of scrolling becomes greater than the friction of linking.
    
- **Cons:** Over time, you might end up with "Extract String (SQL)" and "Merge Dataframes (SQL)".
    

### Better Naming Convention Suggestion:

Instead of `Extract String (SQL)`, many developers prefer:

- `SQL - Extract String`
    
- `PySpark - Extract String`
    

This keeps all your SQL notes grouped together alphabetically in your file tree, while your "Master" note (the TOC) remains the functional entry point.

---

## My Recommendation for Your Workflow

1. **Start Single:** Keep one note per "Action" (e.g., `Pivot Data`).
    
2. **Use Callouts:** Use Obsidian Callouts (`> [!info]`) to visually separate languages within that note.
    
3. **Split via "Note Refactor":** Use the **Note Refactor** community plugin. It allows you to highlight a section of text and instantly turn it into a new linked note.
    
4. **The "Map of Content" (MOC):** Your `Extract String` note is essentially an MOC. Keep these in a dedicated folder so you always know where your "Entry Points" are.
    

**Would you like me to show you a Dataview query that could automatically build these Tables of Contents for you based on tags or properties?**