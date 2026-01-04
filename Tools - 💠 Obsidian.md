1. use aliases + [[Tools - 🧱 YAML Formatter]] more --> (Ctrl + ;)
2. use `code` feature
3. crm → `06 - Contacts`
4. use outline view and track-back, track-forward
5. `> [!TIP]`
6. `[[Ref|Custom`
7. `Alt + 24, Alt + 25, Alt + 27` --> `↑ ↓ ←`


- [log :: 2025-12-26 04:15PM] -- digest this [2025-12-26 0416PM]


link parent to child → (M) parents
link child to parent → (1) parent
have both links? → M:M

## Keybinding 
- `Alt+Up, Alt+Down` -- line up; line down
- `Alt + Shift {Up, Down}` → Add Cursor {Up, Down}
- `Ctrl + Shift + [` -- Toggle {On, Off} Cold Folding
- Alt 3 / 4 -- Navigate back / forward
- Replace -- `Ctrl + T` (New Tab) → Insert Table


| Ctrl + D        | Delete                                             |
| --------------- | -------------------------------------------------- |
| Ctrl + H        | Find and replace, \n\n+ --> \n                     |
| Ctrl + ?; + B   | Comment Line; Bold                                 |
| Alt + LeftClick | Multi-Select (cant' Ctrl+Alt+Up b/c of Autohotkey) |

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
|                        | `[text](url)`                | Markdown external link                                                                                                                                                            |
|                        | `![[note]]`                  | Embed a note                                                                                                                                                                      |
|                        | `![](image.png)`             | Embed an image                                                                                                                                                                    |
|                        |                              |                                                                                                                                                                                   |

https://www.youtube.com/watch?v=d8fXEhWy_rY (From Sergio) #status/todo 

