[[Package Manager]] for [[Tools - Python|Python]]
Related to [[uv]]



Yes, you can relatively reference files and folders between separate repositories locally, and the behavior will be the same when you pull to your personal laptop, **but only if you ensure the relative paths are correct and that the necessary directories are present on both systems in the same relative structure.**

However, this approach is **highly discouraged** in software development because it creates a **hard dependency** between two distinct Git repositories.

Here is an expansion on why this works and why you should consider a better alternative.

-----

## 🐍 Understanding `pip` and Python Packaging

**`pip`** stands for **"Pip Installs Packages"** (or sometimes "Pip Installs Python"). It is the standard **package installer** used to install and manage software packages written in Python.

Think of it as the **App Store or Package Manager** for the Python ecosystem.

| Command | Purpose |
| :--- | :--- |
| `pip install numpy` | Downloads and installs the `numpy` library from PyPI (the central repository). |
| `pip install -e .` | Installs the code in the **current directory** as an editable package. |

-----

## 🛠️ The `-e` Flag (Editable Mode) Explained

The `-e` flag, which stands for **"editable"** (or development mode), tells `pip` to install a package not by copying all its files, but by creating a **link or pointer** to the source code's current location on your file system.

### Use-Case Scenario: Editable vs. Non-Editable

| Feature | `pip install ..\shared-utils` (Standard Install) | `pip install -e ..\shared-utils` (Editable Install) |
| :--- | :--- | :--- |
| **Action** | Files from `shared-utils` are **copied** into your Python environment's `site-packages` folder. | A **link/pointer** to the `shared-utils` folder is placed in `site-packages`. |
| **Code Changes** | If you edit a parser in `shared-utils`, your `slidesms_v1` project **WILL NOT** see the change until you run `pip install ..\shared-utils` again. | If you edit a parser in `shared-utils`, your `slidesms_v1` project **IMMEDIATELY** sees the change without reinstalling. |
| **Best For** | Stable, released packages that don't change often. | **Active development** where you are frequently fixing bugs or adding features to the dependency (your `shared-utils` repo). |

**Your scenario:**

> "if I edit a util.file for one project (better phone parser) I would want that immediately available in my slidesms project"

**Your instinct was correct\!** You *do* want the change to be immediately available. The standard `pip install` **would not** do that; it copies the old version. The command I provided, `pip install -e ..\shared-utils`, ensures that your `slidesms_v1` project is *using* the files directly from the `shared-utils` folder, giving you that immediate, live update behavior.

-----



### 🎯 The Difference: Static Clone vs. Dynamic Shortcut

|**Concept**|**pip install ..\shared-utils (Standard Install)**|**pip install -e ..\shared-utils (Editable Install)**|
|---|---|---|
|**Analogy**|**Static Clone** (A snapshot)|**Dynamic Shortcut** (A symbolic link/pointer)|
|**What It Does**|It **copies** all the files from your `shared-utils` directory and places them inside the `site-packages` directory of your current Python environment.|It **links** your Python environment directly to the original `shared-utils` directory where your source code lives.|
|**Code Changes**|If you change a file in `shared-utils`, the installed version in `site-packages` is now **outdated**. You **must run `pip install ...` again** to update the copied files.|If you change a file in `shared-utils`, your Python environment immediately executes the code from the **original, edited location**. No re-installation is necessary.|
|**Best Use**|When you are finished developing a package and are installing a stable version.|When you are **actively developing** both the main project (`slidesms_v1`) and the dependency (`shared-utils`) simultaneously, and need instant feedback.|

Using the `-e` flag means you can edit your "better phone parser" in the `shared-utils` repo, run your `slidesms_v1` script immediately, and see the new parsing logic without waiting to reinstall anything. It saves a lot of time during development!

## 🐍 1. Review Installed Python Packages (`pip`)

Python libraries are managed by `pip`. This command is the best way to check if you have something like **Pandas** installed. You will run this command in your PowerShell terminal.

### The Command

The simplest command to see everything installed in your **current Python environment** is `pip freeze`.

PowerShell

```
pip freeze
```

### Explanation of Output

This command outputs a list of every Python package and its exact version, typically formatted like this:

```
numpy==1.26.4
pandas==2.2.1
requests==2.31.0
setuptools==69.0.3
```

- **To check for a specific package (e.g., Pandas):**
    
    You can filter the output using `Select-String` (the PowerShell equivalent of `grep`):
    
    PowerShell
    
    ```
    pip freeze | Select-String "pandas"
    ```
    
    If it returns a line (like `pandas==2.2.1`), it's installed.
    

---

## 💻 2. Review Installed PowerShell Modules

If you've installed tools that extend PowerShell itself, you can check for them using the `Get-Module` command.

### The Command

To see all modules you've installed and that are currently available to use, run:

PowerShell

```
Get-Module -ListAvailable
```

### Explanation of Output

The output will show details like the module name, path, and version, for example:

```
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Script     2.0.0      Pester                              {Describe, Context, BeforeEach, Aft...
Script     1.0.0      PSScriptAnalyzer                    {Invoke-ScriptAnalyzer, Get-ScriptA...
```

---

## 🌐 3. Review Installed Global Tools

Some full-stack tools (like **Node.js packages** via npm, or certain **command-line utilities**) are installed globally or in common program locations. There isn't a single universal PS command for _everything_, but you can check common install locations and PATH variables.

### The Command for Node.js (if applicable)

If you've installed Node.js tools globally using `npm install -g`:

PowerShell

```
npm list -g --depth=0
```

This lists all top-level global npm packages you've installed.

---

## ➡️ Next Step: Summarize Your Environment

**Action:**

1. Run the **`pip freeze`** command.
2. Copy the full output.
3. Paste the output into our chat.

I can then help you identify the purpose of the key libraries in your ecosystem (e.g., Pandas for data analysis, Flask/Django for web backends, etc.) and provide a clear summary of your current environment!