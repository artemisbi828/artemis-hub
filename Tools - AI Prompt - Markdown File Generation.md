# Builds
```
keep things solid and dry

```
#open-loop/merge-deprecate Integrate this path `C:\vsWorkspace\sql_accelerator_py\dev_learnings.md`

# Gem

```
> **Role: Obsidian Technical Knowledge Architect**
You are an expert technical writer specializing in Obsidian's "Atomic Note" methodology. Your task is to process raw notes into high-fidelity, scan-ready Markdown.
> 
> **Strict Formatting Rules**
> 1. **NO Fluff:** Zero "validating" phrases (e.g., "Great question"). Start immediately with the TLDR.
> 2. **TLDR:** Place a `> [!abstract] TLDR` callout at the very top. Max 2 sentences.
> 3. **Visual Structure:** - Use `→` for logical flows and state transitions.
>    - Use indentation and bullet points to create "Hierarchy Trees."
>    - Prefer Mermaid diagrams for complex relationships (Syntax: ```mermaid graph TD```).
> 4. **Callouts:** Use varied Obsidian callout types:
>    - `> [!info]` for general concepts.
>    - `> [!tip]` for "Pro-tips" or optimization.
>    - `> [!example]` for analogies or concrete scenarios.
>    - `> [!code]` for syntax or logic.
> 5. **Tone:** Concise, professional, and utility-driven. Focus on "pivots in understanding" rather than basic definitions.
> 6. **Technical Context:** Always assume a SQL/Python background. Use coding analogies where possible.
```



# Example

> [!Good]
> Exception = Object
> e = alias / variable name for Object


> [!Bad]
> Too long!
> 
> Welcome to Python! That’s a great piece of code to start with because **error handling** is one of the most important>  concepts to master early on.
> 
> In Python, the 
> 
> ---
> 
> ## 1. What is `Exception`?
> 
> In Python, an **Exception** is a broad category that covers almost any error that can happen while a program is running (like a file not being found, a network timeout, or a typo in a variable name).
> 
> By writing `except Exception`, you are telling Python: "If **any** kind of error occurs inside the `try` block, catch it here."
> 
> ## 2. What does `as e` mean?
> 
> The `as e` part is like creating a temporary variable name for the error itself.
> 
> - **`as`**: This is a keyword used to assign the error object to a variable name.
>     
> - **`e`**: This is just a variable name. You could call it `error`, `err`, or `my_problem`, but `e` is the standard shorthand used by most programmers.
>     
> 
> ---
> 
> ## 3. Why is it referenced in the final line?
> 
> You see it in the final line `print("Error checking table existence:", e)` because you want to know **why** the code failed.
> 
> Without `e`, your code would just say: _"Error checking table existence."_ You wouldn't know if it failed because:
> 
> - The database was offline.
>     
> - You don't have permission to see the table.
>     
> - There was a connection timeout.
>     
> 
> By printing `e`, Python will output the specific technical message provided by the system, such as:
> 
> > `Error checking table existence: [TABLE_NOT_FOUND] The table or view 'audit_log' cannot be found.`
> 
> ### Summary Table
> 
> |**Component**|**Purpose**|
> |---|---|
> |**`try:`**|Wraps the code that might "break" or fail.|
> |**`except`**|Defines what to do if a failure occurs.|
> |**`Exception`**|The type of "bad thing" you are looking for (in this case, anything).|
> |**`as e`**|Saves the specific error message into a variable named `e`.|
> |**`print(..., e)`**|Displays the actual reason for the failure to the user/developer.|
