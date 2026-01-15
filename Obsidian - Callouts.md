In Obsidian, these are called **Callouts**. They are based on the Microsoft Documentation syntax and are incredibly useful for visually organizing your notes.

Here is a complete list of the default supported callout types. You can use any of these by replacing the `TYPE` in `> [!TYPE]`.

### 1. Information & Status

|**Type**|**Icon Description**|**Usage**|
|---|---|---|
|`[!info]`|Blue "i" circle|General information or context.|
|`[!note]`|Blue pencil|Standard notes (default style).|
|`[!abstract]`|Blue list icon|Summaries, TL;DRs, or introductions. (Aliases: `summary`, `tldr`)|
|`[!todo]`|Blue checkmark|Tasks, checklists, or "to-do" items.|

### 2. Positive & Success

| **Type**     | **Icon Description** | **Usage**                                                           |
| ------------ | -------------------- | ------------------------------------------------------------------- |
| `[!tip]`     | Green lightbulb      | Helpful hints, shortcuts, or advice. (Aliases: `hint`, `important`) |
| `[!success]` | Green checkmark      | Completed goals, positive results. (Aliases: `check`, `done`)       |

### 3. Warnings & Errors

|**Type**|**Icon Description**|**Usage**|
|---|---|---|
|`[!warning]`|Orange triangle|Potential issues or "proceed with caution." (Alias: `caution`)|
|`[!attention]`|Orange exclamation|Important notices that shouldn't be missed.|
|`[!failure]`|Red "X"|Errors, things that didn't work. (Aliases: `fail`, `missing`)|
|`[!danger]`|Red lightning bolt|Critical warnings or high-risk info. (Alias: `error`)|
|`[!bug]`|Red bug icon|Known issues or code bugs.|

### 4. Thinking & Personal

|**Type**|**Icon Description**|**Usage**|
|---|---|---|
|`[!example]`|Purple list|Examples or code samples.|
|`[!quote]`|Grey quote marks|Citations or blocks of text from others. (Alias: `cite`)|
|`[!question]`|Yellow question mark|Doubts, inquiries, or "Help Wanted." (Alias: `help`)|

---

### Callout Modifiers (The "+" and "-")

As you noted with `[!code]+`, you can control whether the callout is expanded or collapsed when the page loads:

- **`> [!tip]+`**: Expanded by default (shows the content).
    
- **`> [!tip]-`**: Collapsed by default (you must click to reveal content).
    
- **No symbol**: Stays permanently open (cannot be collapsed).
    

### Pro-Tips for Callouts

- Custom Titles: You can change the title by adding text after the type:
    
    > [!tip] This is my custom title
    
- **Nesting:** You can put callouts inside other callouts by adding an extra `>`:
    
    Markdown
    
    ```
    > [!info] Parent
    > > [!tip] Child Callout
    ```
    
- **Custom Icons:** If you use the **Lucide** icon set (built into Obsidian), some themes allow you to change icons, but the list above covers everything that works "out of the box" without plugins.
    

Would you like me to show you how to create a **custom CSS snippet** so you can make your own callout types (like `[!sublime]` with an orange icon)?