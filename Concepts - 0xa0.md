#quick-paste-merge-later 

`0xa0` (often written as `\xa0` in string literals) represents the **Non-Breaking Space (NBSP)**.

```
0x09
0x0A
0x0B
0x0C
0x0D
0x20
0xA0
\n vs \r\n
U+2009
U+200B
U+200C
U+200D
U+2013
U+2014
U+2018 
U+2019 
U+201C 
U+201D
U+FEFF
```
It acts like a "glue" character. While it looks exactly like a standard space on your screen, computers treat it as a completely different character.

Here is the breakdown of why it exists and why it causes headaches.

---

### 1. The Tale of Two Spaces

To the human eye, these two sentences look identical. To a computer, they are completely different:

|**Character**|**Name**|**Hex Code**|**Decimal**|**HTML Entity**|
|---|---|---|---|---|
||**Standard Space**|`0x20`|32|(just a space)|
||**Non-Breaking Space**|**`0xA0`**|160|`&nbsp;`|

### 2. What is it actually for?

The intended purpose of `0xa0` is strictly formatting. It tells the word processor or browser: **"Do not break the line here."**

You use it when you want to keep two elements together on the same line for readability.

- **Units:** `10 kg` (You don't want "10" on one line and "kg" on the next).
    
- **Dates:** `May 5`
    
- **Titles:** `Mr. Smith`
    

### 3. Why is it "Invisible Trouble"?

The reason you are likely asking about this is that `0xa0` is a notorious "gremlin" in programming and data cleaning.

Where it comes from:

It usually appears when you copy and paste text from the web or Microsoft Word into a code editor or database.

The Problem:

If you paste code that contains 0xa0 instead of a normal space (0x20), most compilers and interpreters will crash or throw a syntax error because they do not recognize 0xa0 as whitespace.

- **In Python:** `x = 5` (with a normal space) works. `x = 5` (with `0xa0`) will throw a `SyntaxError: invalid character`.
    
- **In SQL:** Trying to match a string like `'John Smith'` will fail if the database contains `'John<0xa0>Smith'`.
    

### 4. How to remove it

If you are dealing with "ghost" bugs where strings aren't matching or code isn't running, you usually need to sanitize the string.

**In Python:**

Python

```
# Replace the hex character with a standard space
cleaned_text = my_text.replace('\xa0', ' ')

# Or using the normalize library to fix all unicode oddities
import unicodedata
cleaned_text = unicodedata.normalize("NFKD", my_text)
```

**In SQL (T-SQL/SQL Server):**

SQL

```
-- Replace char(160) with char(32)
UPDATE MyTable
SET MyColumn = REPLACE(MyColumn, CHAR(160), CHAR(32))
```

In Excel:

You can use the formula =SUBSTITUTE(A1, CHAR(160), " ") to clean the cell.

---

