1. use aliases + [[🧱 YAML Formatter]] more
2. use `code` feature
3. crm → `06 - Contacts`
4. use outline view and track-back, track-forward

link parent to child → (M) parents
link child to parent → (1) parent
have both links? → M:M

| Ctrl + D        | Delete                                             |
| --------------- | -------------------------------------------------- |
| Alt + LeftClick | Multi-Select (cant' Ctrl+Alt+Up b/c of Autohotkey) |
| Ctrl + H        | Find and replace, \n\n+ --> \n                     |
| Ctrl + ?; + B   | Comment Line; Bold                                 |
Ctrl + drag-drop into doc: create a link instantly

| **Feature**            | **Syntax**                   | **Explanation**                                                                      |
| ---------------------- | ---------------------------- | ------------------------------------------------------------------------------------ |
| **Basic Link**         | `[[Note Name]]`              | Links to `Note Name.md`. Auto-complete triggers when you type `[[`.                  |
| **Aliased Link**       | `[[Note Name\|Custom Text]]` | Links to `Note Name` but displays "Custom Text".                                     |
| **Header Link**        | `[[Note Name#Header]]`       | Links directly to a specific H1-H6 header in that note.                              |
| **Block Link**         | `[[Note Name^blockid]]`      | Links to a specific paragraph. Type `^` at the end of a paragraph to generate an ID. |
| **Embed (Transclude)** | `![[Note Name]]`             | **Renders** the linked note (or image) inside the current note.                      |



https://www.youtube.com/watch?v=d8fXEhWy_rY (From Sergio) #todo
