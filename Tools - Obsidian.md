---
knowledge_type: Tools
---
# Paste-Picture
- **Standard:** `![[image.png]]`
- **Resized (Width in pixels):** `![[image.png|300]]`

> [!Tip]
> Alt + Shift + R.Click → multi-cursor

[[Tools - Key Bindings]]

| /\bData Output\b/ | Search "Data Output" → Word-Boundary (vs code -1) |
| ----------------- | ------------------------------------------------- |

| **Split Window** | _Custom_       | _Custom_      | Map this in settings! I recommend `Ctrl + \`. essential for viewing 2 notes at once. |
| ---------------- | -------------- | ------------- | ------------------------------------------------------------------------------------ |
| **Checklist**    | `Ctrl + Enter` | `Cmd + Enter` | Cycles a bullet point `-` into a checkbox `- [ ]`.                                   |

[[Obsidian - YAML vs MOC vs Tags]]
[[Obsidian - Tags vs YAML Tags]]
[[Obsidian - Tags + YAML Reserved Properties]]
[[Tools - Obsidian - Clipboard Paste Image]]
[[Obsidian - Working w Templates]]
[[Obsidian - Styling]]
[[Obsidian - Searching]]

# Learning
[[Obsidian - BlockIDs and Unmarked Blocks]]
# Currently Mastering Callouts + Dataview
[[Obsidian - Dataview]]
[[Obsidian - Callouts]]
### Code Folding
```
> [!code]+
> ```python
> print("This code is foldable!")
> ```
```


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

https://www.youtube.com/watch?v=d8fXEhWy_rY (From Sergio) #status/open-loop/new

---
# Why Single Brackets

## 1. The "Half-Finished" Link

The most common reason is that the user **intended** to make a link but hasn't finished it yet.

- **Markdown Links:** A full URL link looks like `[Text](https://example.com)`. If you see just the brackets, someone might be "stubbing out" a link they plan to add a URL to later.
    
- **Footnotes:** Footnotes use a similar syntax, like `[^1]`. A stray bracket often implies a footnote in progress.
    

## 2. Technical and Logical Notation

Since Obsidian is popular among developers, scientists, and researchers, brackets are often used for their **original semantic meaning** rather than for formatting:

- **Mathematics/Sets:** In math, `[a, b]` denotes a closed interval.
    
- **Linguistics/Transcription:** Brackets are used to indicate phonetic transcription or to clarify a quote (e.g., "He [the witness] saw the car").
    
- **RegEx/Programming:** Brackets define character sets in code snippets.
    

## 3. Visual Organization (Pseudo-Tagging)

Some users use single brackets purely as a **visual stylistic choice** to make certain words pop without turning them into "backlinks."

- **Avoid Link Clutter:** If you turn every instance of "Project Alpha" into a `[[Project Alpha]]` link, your graph view might become a chaotic "hairball."
    
- **Visual Framing:** Using `[URGENT]` or `[IDEA]` at the start of a line creates a clear visual anchor that stands out from regular prose without adding the overhead of a functional link or a tag.
    

---

### Comparison: Single vs. Double Brackets

|**Feature**|**Single Brackets [ ]**|**Double Brackets [[ ]]**|
|---|---|---|
|**Function**|None (Static Text)|Creates a Page Link|
|**Graph View**|Invisible|Creates a Node/Connection|
|**Formatting**|Plain Text|Usually Colored/Underlined|
|**Purpose**|Clarity or Syntax|Interconnectivity|

> **Pro Tip:** If you want functional brackets that don't link to a page, you might be looking for **Checkboxes**. In Obsidian, typing `- [ ]` creates a functional, clickable task toggle.

Would you like me to show you how to use CSS snippets to make those single-bracketed words look like colorful "pills" or buttons in your notes?


---
#status/deferred/quick-paste-merge-later 

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



# Bases
If you are using the **Core "Bases" Plugin** (v1.9+):

- **Concept:** A "Base" is a live view of a folder's notes, displayed as a Table, List, or Kanban board. It relies on **Properties** (YAML Frontmatter) at the top of your notes.
- **How it works:**
    
    1. **Define Properties:** Add metadata to your notes (e.g., `status: active`, `due_date: 2025-04-01`, `tags: [sql, postgres]`).
    2. **Create a Base:** Create a new Base file. Point it to a folder or a tag.
    3. **Columns:** You add columns to the table corresponding to your Properties.
    4. **Editing:** Editing a cell in the Base updates the actual text/YAML in the source `.md` file.