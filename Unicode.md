---
aliases:
  - non-ASCII characters
---
#status/deferred/quick-paste-merge-later 

That message in **SSMS 22 (SQL Server Management Studio 2022)** is an **encoding warning**, not an error. Here’s what it means and what you should do in practical terms.

---

## What the message means

> **“Some Unicode characters in this file could not be saved in the current codepage.”**

- Your script file contains **Unicode characters** (non‑ASCII characters).
- The file is currently set to save using a **non‑Unicode encoding** (typically an ANSI code page like Western European / Windows‑1252).
- That encoding **cannot represent all characters in the file**.

### Examples of characters that trigger this

- Smart quotes (`“ ” ‘ ’`)
- En/em dashes (`– —`)
- Non‑English letters (`ñ`, `é`, `ø`)
- Currency symbols (`€`, `£`)
- Emojis or special symbols
- Some copied text from Word, PowerPoint, or websites

If you save the file without changing encoding, **those characters may be lost, replaced, or corrupted** (often showing up as `?`).

---

## What each option does

### ✅ **Apply to all documents**

- Remembers **your choice** for future files in this SSMS session.
- Useful if you expect to keep working with Unicode text.

---

### ✅ **Save With Other Encoding** ✅ _Recommended_

- Allows you to resave the file using a **Unicode‑safe encoding**.
- Typically you should choose:
    - **UTF‑8**
    - **UTF‑8 with BOM** (still safest for older tooling)

✅ This preserves **all characters exactly as shown**.

---

### ❌ **Cancel**

- Does **not save** the file.
- Use only if you want to review or remove Unicode characters manually.

---

## Why this matters in SQL Server work

Even though **SQL Server itself fully supports Unicode**, your **.sql script file** might not unless it’s saved correctly.

### Common problem scenarios

- Scripts with `NVARCHAR` literals: N'José'
- Comments copied from documentation or Confluence
- Dynamic SQL containing special characters
- JSON text blocks

If saved in a non‑Unicode encoding:

- Unicode characters can be corrupted
- Scripts may behave differently when shared with others
- Source control diffs become messy

---

## Best practice (what you should do)

✅ **Always save SQL scripts as UTF‑8**

### In this popup:

1. Click **Save With Other Encoding**
2. Choose **UTF‑8**
3. (Optional) Check **Apply to all documents**

---

## How to prevent this in SSMS 22 permanently

### Set UTF‑8 as default

1. Go to\ **Tools → Options**
2. Navigate to\ **Environment → Documents**
3. Set:
    - ✅ _Save documents as Unicode when data cannot be saved in codepage_
4. (Optional but recommended)
    - Enable **Detect UTF‑8 encoding without signature**

This prevents the popup in most cases.

---

## TL;DR

- You’re seeing this because your script contains **Unicode characters**
- The current file encoding **can’t safely store them**
- ✅ **Choose “Save With Other Encoding” → UTF‑8**
- This protects your data and avoids subtle bugs

If you want, tell me:

- If this is happening in **stored procedures**, **ad‑hoc scripts**, or **source‑controlled files**
- Whether you work with **JSON, APIs, or copied documentation**

I can tailor encoding best practices specifically for your SQL workflow.