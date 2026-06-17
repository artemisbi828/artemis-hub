---
aliases:
  - Python
---


[[Package Manager]] is [[Pip]] vs [[uv]]

```
"""
This is a multi-line block
"""
```

[[Tools - Comment Blocks]]
[[Python - Data Structures]]
[[Python - Try, If, Except]]
[[Python - VENV]]




#status/deferred/quick-paste-merge-later 
```
sqlpolyglot
sql-parse
```

That's a great question about a crucial part of managing Python projects!

The `-r` in the command `pip install -r requirements.txt` stands for **requirements file**.

It instructs `pip` to **read and install** all the packages listed line-by-line within the specified file, which is `requirements.txt` in this case.

---

## 💡 Finding Definitions (Help) for `pip` and Python

When you need to know what a flag like `-r` means, or to see the full list of options for a command, you use built-in help features.

### 1. Using `pip`'s Built-in Help

`pip` has a very comprehensive help system built right into the command line.

- **To get general help for `pip`:**

    Bash

```
pip --help
# OR
pip -h
```
    
- **To get specific help for the `install` command (which contains the definition for `-r`):**

    Bash

```
pip install --help
```

    This command will dump a long list of all available options for installing packages, including flags for requirements files, version control systems, and dependency resolution.
    

### 2. Using Python's Built-in Help

The `python` command itself doesn't have a single "help" file for all its flags like `pip` does, but you can find its main options easily:

- **To get help on the Python interpreter executable:**

    Bash

    ```
    python3 --help
    # OR
    python3 -h
    ```

    This will show you common options like running a module with `-m` or optimizing with `-O`.
    

### 3. Using Linux Manual Pages (`man`)

For nearly any command in Linux (including `pip` and `python3`, provided their manual pages are installed), you can use the `man` command (short for manual):

- **Command:**

    Bash

    ```
    man pip
    # OR
    man python3
    ```

    This opens the command's official, comprehensive documentation (the "man page") in a pager like `less`, allowing you to search and scroll through all the details.