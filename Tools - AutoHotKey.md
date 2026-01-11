### 1. Single-Line Comments

To comment out a single line or add a note to the end of a line of code, use the **semicolon** (`;`).1

AutoHotkey

```
; This is a full-line comment
Run "notepad.exe"  ; This is an end-of-line comment
```

- **Rule:** There must be at least **one space** (or tab) before the semicolon if it follows a command.2
    

---

### 2. Multi-Line (Block) Comments

If you want to comment out a large section of code, use `/*` to start the block and `*/` to end it.3

AutoHotkey

```
/*
This is a multi-line comment.
Everything inside these symbols
will be ignored by the script.
*/
```

- **Rule:** The `/*` and `*/` must appear at the **very start** of the line. They cannot have any code or spaces before them.
    

---

### Pro-Tip for Sublime Text Users

If you are editing your `.ahk` files in Sublime Text, you can use the standard shortcut:

- **`Ctrl + /`**
    

Sublime will automatically detect the file type and insert the correct semicolons for you.

Would you like me to show you how to add a "Toggle Comment" hotkey to your AutoHotkey script so you can comment out lines in other apps with a shortcut?


In AutoHotkey (AHK), key commands are called **Hotkeys**. They follow a specific syntax: `ModifierSymbolKey::Action`.

Here is a reference of the most common symbols and the "Send" commands used to automate tasks.

### 1. The Modifier Symbols

These symbols represent the keys you hold down to trigger a shortcut.

|**Symbol**|**Keyboard Key**|**Example**|
|---|---|---|
|**`^`**|**Ctrl**|`^s::` (Ctrl + S)|
|**`!`**|**Alt**|`!f4::` (Alt + F4)|
|**`+`**|**Shift**|`+Enter::` (Shift + Enter)|
|**`#`**|**Windows Key**|`#e::` (Win + E)|
|**`<`** / **`>`**|**Left or Right**|`<^` (Left Ctrl only)|
|**`~`**|**Native Function**|`~LButton::` (Click, but don't block it)|

---

### 2. Common "Send" Commands

These are the most used actions inside a hotkey.

|**Command / Key**|**What it does**|
|---|---|
|**`Send("text")`**|Types out the string "text".|
|**`{Enter}`**|Presses the Enter key.|
|**`{Tab}`**|Presses the Tab key.|
|**`{Esc}`**|Presses the Escape key.|
|**`{BS}`**|Presses Backspace.|
|**`{Space}`**|Presses the Spacebar.|
|**`{Up}` / `{Down}`**|Arrow keys.|
|**`{LButton}`**|Left Mouse Click.|
|**`{RButton}`**|Right Mouse Click.|

---

### 3. Practical Examples

Here is how you combine them into a functional script (v2 syntax):

|**Goal**|**AHK Code**|
|---|---|
|**Open Google in Chrome**|`^!g::Run "https://www.google.com"` (Ctrl+Alt+G)|
|**Type your email**|`::@email::myname@gmail.com` (Type "@email" + Space)|
|**Minimize Window**|`!m::WinMinimize "A"` (Alt+M minimizes Active window)|
|**Empty Trash**|`^#Delete::FileRecycleEmpty` (Ctrl+Win+Delete)|
|**Always on Top**|`^Space::WinSetAlwaysOnTop -1, "A"` (Toggle top-most)|

---

### 4. Special "State" Commands

These are used to control how the script behaves:

- **`Reload`**: Restarts the script (great for when you're editing it).
    
- **`Pause`**: Temporarily stops the script from working.
    
- **`ExitApp`**: Closes the script entirely.
    
- **`Return`**: (v1 only) Tells the script the hotkey action is finished.
    

> [!NOTE]
> 
> Key Case Matters: In AHK v2, keys inside the Send() command are usually wrapped in curly braces and quotes, like Send("{Enter}").

Would you like me to write a **"Master Reload"** hotkey for you? It's a single line that lets you refresh your script instantly every time you make a change.