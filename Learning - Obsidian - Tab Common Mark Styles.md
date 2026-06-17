#learning 

> ⚠️ 2026-04-13 07:38 PM -- made b/c didn't know why formatting changes when tabbed

This is one of those _Obsidian‑specific markdown meets CommonMark reality_ things that feels quirky until you internalize the rules.

Below is a **mental model + rule‑of‑thumb cheat sheet**, focused on **why “two tabs” behaves differently than zero or one**, especially for code fences and blockquotes.

---

## The Core Principle (TL;DR)

> **Indentation changes the _context_ a block is parsed in.**  
> After a certain indentation threshold, Markdown stops treating the content as “top‑level markdown” and starts treating it as _literal content inside something else_.

That “something else” is usually:

- a list item
- a blockquote
- an indented code block
- or a _nested_ version of the above

Obsidian follows **CommonMark**, not “Markdown as people remember it”.

---

## Rule #1 — Tabs ≠ Visual spacing

Tabs/4‑spaces are **semantic**, not cosmetic.

|Indent amount|Meaning|
|---|---|
|0 spaces|Top‑level markdown|
|2 spaces|Often tolerated visually, but ambiguous|
|**4 spaces (≈ 1 tab)**|**Context shift** (inside list / code block)|
|**8 spaces (≈ 2 tabs)**|**Nested context** or _literal text_|

> ✅ **Rule of thumb**: If you indent **4+ spaces**, you are changing _how the parser thinks_, not how it looks.

---

## Code Fences (```)

### ✅ Works (top‑level)

```sql

select 1;

````

### ✅ Works inside a list (but requires indentation)
```md
- Item
    ```sql
    select 1;
    ```
````

Here:

- `- Item` creates a list context
- `4 spaces` aligns the code fence _inside_ the list

---

### ❌ Surprising behavior (2 tabs / 8 spaces)

        `sql</span></div><div class="scriptor-paragraph"><span attribution="{&quot;name&quot;:&quot;Copilot&quot;,&quot;oid&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;id&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;userInfo&quot;:{&quot;name&quot;:&quot;Copilot&quot;,&quot;oid&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;id&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;},&quot;timestamp&quot;:1776126900000,&quot;dataSource&quot;:0}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select 1;</span></div><div class="scriptor-paragraph"><span attribution="{&quot;name&quot;:&quot;Copilot&quot;,&quot;oid&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;id&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;userInfo&quot;:{&quot;name&quot;:&quot;Copilot&quot;,&quot;oid&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;,&quot;id&quot;:&quot;E64C3D4F-5E12-4514-AD9B-893A6FAFD00C&quot;},&quot;timestamp&quot;:1776126900000,&quot;dataSource&quot;:0}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`

What happens?

- Markdown interprets this as **an indented code block**
- The backticks are treated **literally**
- ❌ No syntax highlighting
- ❌ No fence behavior

**Why?**

> Because _indented code blocks outrank fenced code blocks_ once indentation is deep enough.

---

### ✅ Rule of thumb for code fences

- **Top‑level**: no indent
- **Inside a list**: indent exactly to the list’s content column (usually 4 spaces)
- **Never indent fenced blocks “just to align them”**

> If you see literal ``` rendered → **you over‑indented**

---

## Blockquotes (>)

### ✅ Normal

> This is a blockquote

### ✅ Nested blockquote

> > Second level

### ✅ Blockquote inside list

- Item

  > Quoted note

---

### ❌ Weird behavior with 2 tabs

        > quoted text

This often becomes:

- plain text
- or an indented code block
- or ignores `>` entirely

**Why?**

- The parser already committed to “this is literal / preformatted context”
- `>` no longer has semantic meaning

---

### ✅ Rule of thumb for blockquotes

- Use **`>` nesting**, _not indentation_
- Indentation only to **enter a list context**
- Once inside a quote, let `>` do the work

---

## Lists (Where most people get burned)

Markdown lists are indentation‑sensitive **and stateful**.

- Parent

    - Child

        - Grandchild

Each level:

- Requires consistent indentation
- Changes how following blocks are parsed

### Common pitfall

- Item

        Some text

That text is now:

- interpreted as an **indented code block**
- not a paragraph

---

## The “2 Tabs Problem” (Why it _feels_ special)

Two tabs (~8 spaces) is often where:

- ✅ You already entered a list or quote context
- ❌ Markdown now crosses into **indented‑code‑block territory**

So visually:

> “Looks aligned”

But semantically:

> “You told the parser to stop interpreting markdown”

---

## Obsidian‑Specific Gotcha

Obsidian:

- shows indentation guides
- auto‑indents on Enter
- makes it _look_ like deeper indentation is safe

But the renderer still follows CommonMark.

> **Obsidian is forgiving when writing, strict when rendering.**

---

## Practical Rules You Can Memorize

### ✅ Golden Rules

1. **Never indent a fenced code block unless required by a list**
2. **If backticks render literally → you’re too deep**
3. **Use `>` for quote depth, not indentation**
4. **Indent to ENTER a structure, not to beautify it**
5. **If something “randomly” breaks, count spaces**

---

## Debug Trick (Highly Effective)

When markdown breaks:

1. Move the cursor to column 1
2. Backspace indentation completely
3. Re‑add indentation _one level at a time_

Markdown errors are almost always **context leaks**, not syntax errors.

---

If you want, next we can:

- build a **1‑page Obsidian Markdown anti‑pattern guide**
- or map this to **your Obsidian templating + callouts usage**
- or explain why this matters for **copy/pasting into ADO / GitHub / Notion**

Just say which direction.