[[Package Manager]] for [[Tools - Python|Python]]



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