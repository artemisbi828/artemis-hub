```


# CSS
A detailed technical explanation...
```


---
#quick-paste-merge-later 
## 🧐 What is YAML Frontmatter?

YAML Frontmatter is a specific block of structured data placed at the very top (the "front matter") of a Markdown file. It's used to store **metadata**—data about the data—that describes the content of the note.

- **YAML:** Stands for **Y**et **A**nother **M**arkup **L**anguage (or YAML Ain't Markup Language). It's a human-friendly data serialization standard, perfect for configuration files and, in this case, note properties.
    
- **Frontmatter:** Refers to its position at the start of the file.
    

### 🔑 The Key Structure

The entire YAML Frontmatter block must be enclosed by a pair of three dashes (`---`).

YAML

```
---
# Everything between these three dashes
# is the YAML Frontmatter data block.
key: value
another_key: another value
list_key:
  - item one
  - item two
---
```

---

## 🧱 The Rules of YAML Frontmatter

To ensure your applications (like Obsidian and Dataview) can read your properties correctly, you must follow these rules:

|**Rule**|**Description**|**Example**|
|---|---|---|
|**Must be at the top.**|The `---` block must be the first thing in the file. No spaces or blank lines before it.|**Correct:** `---`|
|**Use Key: Value Pairs.**|Data is defined using a **key** (the property name) followed by a colon and a **value**.|`domain: Web Development`|
|**Use Simple Lists.**|Lists are created by indenting and prefixing items with a dash (`-`).|`tags: - lexicon - term`|
|**Quotes are Optional.**|Generally, you don't need quotes for simple text or numbers. Use quotes (single or double) if your value contains a colon, special characters, or starts with a number.|`abbreviation: "R. A. P. I. D."`|

---

## 💡 Why It's Powerful for Obsidian

YAML Frontmatter transforms your static text notes into **data records** that can be queried, filtered, and displayed like a database.

### 1. **Structured Search**

Instead of relying on a full-text search for the word "web," you can perform a precise search for notes where the specific property `domain` is exactly equal to "Web Development." This is what allows for the SQL-like querying you loved.

### 2. **Context and Categorization**

It lets you add rich context to your notes without cluttering the main body.

- **`tags`:** Used for global categorization (`#project/apollo`, `#source/book`).
    
- **`aliases`:** Other names the note might be known by, making it easier to link to.
    
- **Custom Properties:** Any property you define (`status`, `priority`, `author`, `definition`) can be used by Obsidian Bases/Dataview.
    

### 3. **The Dictionary Example Revisited**

Using the dictionary example, imagine a note named `CSS.md`:

YAML

```
---
tags: [lexicon]
abbreviation: CSS
definition: Cascading Style Sheets.
domain: Web Development
created_date: 2025-11-20
---

# CSS
A detailed technical explanation...
```

Obsidian now doesn't just see a text file; it sees a record with these fields:

- **Term:** `CSS` (from the filename)
    
- **Tags:** `lexicon`
    
- **Abbreviation:** `CSS`
    
- **Definition:** `Cascading Style Sheets.`
    
- **Domain:** `Web Development`
    
- **Created Date:** `2025-11-20`
    

This structure is what enables a query like: "Show me a table of the **Term**, **Definition**, and **Created Date** for every note with the tag `#lexicon` that is in the **Web Development** domain."

Would you like to try writing a simple YAML Frontmatter block for a new term, like "API"?