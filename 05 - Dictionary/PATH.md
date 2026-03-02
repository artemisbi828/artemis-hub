---
knowledge_type:
aliases:
definition: speed dial to programs for commands (eg code or python)
---


You are correct that the Google Cloud CLI installer often defaults to installing the files in a location like:

`C:\Users\jpasc\AppData\Local\Google\Cloud SDK\...`

**PowerShell**
You can verify that the installer successfully added the path by running a simple command in PowerShell:

```powershell
$env:Path -split ';' | Select-String 'gcloud'
```

- **Expected Output:** This command searches your environment paths. It should return a line showing the full directory path to the GCloud SDK's `bin` folder (e.g., `C:\Users\jpasc\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin`).
    

**Conclusion:** Even though the files are in a "hidden" AppData folder, the installation process correctly linked that location to your command line environment, allowing you to execute `gcloud` commands from anywhere in your PowerShell session. You do not need to move the installation.

# Why You Were Still Able to Run `gcloud init`

You were able to run `gcloud init` successfully because the **installer took a critical step for you**:

1. **It Modified the PATH:** When you installed the GCloud CLI, you ensured the option to **"Configure the environment"** was checked. This step automatically adds the necessary path to the executables (usually the `bin` subdirectory inside the SDK folder) to your Windows user's `PATH` environment variable.
2. **User vs. System PATH:** Windows has two primary PATH variables:
    
    - **System PATH:** Applies to all users.
    - User PATH: Applies only to your user (jpasc).

        The installer typically modifies your User PATH to include the AppData location.

#open-loop/quick-paste-merge-later 
## 🛑 Why Local Relative Paths Work (And Why They're Risky)

When you reference files between two local repositories, Git is not involved at all—this is purely a **file system operation**.

1.  **Local Access Works:**
    If you have your repositories structured like this on both machines:

    ```
    C:\vsWorkspace\
    ├── slidesms_v1\
    │   └── my_script.py
    └── shared-utils\
        └── parsers.py
    ```

    A file inside `slidesms_v1` can reference `parsers.py` using a relative path that goes *up* and *over*:

    ```python
    # Inside slidesms_v1/my_script.py
    import sys
    import os

    # A relative path to get from slidesms_v1 to shared-utils
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'shared-utils')))

    # Now you can import modules from shared-utils
    from shared-utils import parsers
    ```

2.  **Sync Behavior is Identical:**
    When you `git push` from your work computer and `git pull` on your personal laptop, the **contents** of `slidesms_v1` (including the relative import logic) will be identical. As long as your personal laptop has the `slidesms_v1` and `shared-utils` folders arranged in the exact same relative structure (`C:\vsWorkspace\slidesms_v1` and `C:\vsWorkspace\shared-utils`), the code will behave the same.

3.  **The Risk:**
    This system fails immediately if:

      * Another developer clones the repositories in a different folder structure.
      * You decide to move one repository to a different parent folder (`C:\Projects` vs. `C:\vsWorkspace`).
      * A CI/CD tool (like GitHub Actions) tries to build `slidesms_v1` and doesn't know to clone `shared-utils` next to it.
      * You only clone one repository and forget to clone the other.

----
## 🤝 Recommended Solution: Python Packages (Best Practice)

The proper way to handle shared code like "parsers and utils" is to package `shared-utils` as a **local or private Python package** that `slidesms_v1` can install as a dependency.

### 1\. Package `shared-utils`

Make your `shared-utils` repository installable by adding a basic `pyproject.toml` or `setup.py` file.

### 2\. Install as an Editable Dependency

On both your work and personal computers, within the `slidesms_v1` directory, you install `shared-utils` pointing to your local path:

```bash
cd C:\vsWorkspace\slidesms_v1
# This installs shared-utils as a dependency
# The '-e' flag means "editable," so changes to shared-utils are live immediately
pip install -e ..\shared-utils
```

### 3\. Standard Imports

Now, your code inside `slidesms_v1` can use **standard, non-relative imports**:

```python
# Inside slidesms_v1/my_script.py
# This is clean, safe, and works regardless of your folder structure
from shared_utils.parsers import some_function
```

### 4\. Version Control (Optional but Recommended)

For more mature projects, you would typically use a tool like **Git Submodules** or publish `shared-utils` to a private package index (like GitHub Packages or a private PyPI) to manage specific versions, ensuring `slidesms_v1` always uses a stable, tested version of your utilities. Since you are just starting, the `pip install -e` method is the simplest way to get the benefits of standard imports while keeping the repositories separate.

You're asking great questions that get right to the heart of how modern Python projects manage dependencies\!

Here is a breakdown of `pip`, the meaning of the `-e` flag (editable mode), and an explanation of `toml`.

That's a great request! Using a centralized directory structure like `/artemis-hub` and turning your shared code into an installable Python package is the best way to manage shared utilities.

Here is the updated hierarchy that incorporates your proposed directory structure and the Python packaging solution, followed by the specific steps you would take to link the projects.

---

## 🏗️ Proposed Project Hierarchy with Python Packaging

This structure treats the `shared-utils` repository content (now called `libs/utils`) as an installable package within a larger hub folder.

```
/artemis-hub 
│  (This is a parent folder where you clone all related repos)
│
├── /shared-utils (Your artemisBI/shared-utils repository content)
│   ├── pyproject.toml  <-- File defining 'utils' as a Python package
│   ├── /utils          <-- The actual Python package directory
│   │   ├── __init__.py 
│   │   ├── contact_cleaner.py 
│   │   ├── name_cleaner.py
│   │   └── email_cleaner.py
│   └── requirements.txt
│
├── /slidesms_v1 (Your artemisBI/slidesms_v1 repository content)
│   ├── main_app.py
│   └── requirements.txt
│
└── /obsidian (Your artemisBI/obsidian repository content)
    └── ... 
``` 

---

## 🔗 Implementation: Linking the Projects

To make this work reliably on both your work and personal computers, you need to use the **editable install** method within your Python virtual environment for each consuming project.

### 1. Prepare the `shared-utils` Package

You must first place a `pyproject.toml` file inside the root of the `/shared-utils` folder to define it as a package named `artemis-utils` (or something similar).

### 2. Install the Editable Link

For the `slidesms_v1` project to access the cleaning utilities, you install the `shared-utils` package using the `-e` (editable) flag, referencing its relative path within the `/artemis-hub` parent folder.

Run these commands from the **terminal, while inside the `/slidesms_v1` folder**:

PowerShell

```
# 1. Navigate to the consumer project
cd C:\vsWorkspace\artemis-hub\slidesms_v1

# 2. Install the shared-utils package as an editable dependency
# The '..' moves up to /artemis-hub, then down into /shared-utils
pip install -e ..\shared-utils
```

### 3. Usage within `slidesms_v1`

Once linked, your code in `slidesms_v1` can use standard, non-relative imports that work on any machine that performs the `pip install -e` step:

Python

```
# Inside C:\vsWorkspace\artemis-hub\slidesms_v1\main_app.py

# This is clean and path-independent!
from utils.contact_cleaner import clean_phone_number 

# ...
phone = clean_phone_number(data)
```

**Note on Syncing:** When you pull changes to `shared-utils` on your personal laptop, those changes are immediately available in `slidesms_v1` because the dependency is just a dynamic link to the local folder. You don't need to reinstall anything.


