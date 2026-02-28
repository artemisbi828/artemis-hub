[[LNX - systemd]]
[[LNX - Exit Terminal - Ctrl-C]]

```linux
hostname                                         # verify where I am

ls -l                                            list long (vs all)
ls -la                                           see all

cd ~                                             "see" directory
mkdir -p ~/client-bridge/.streamlit              # create folder
mv ~/secrets.toml ~/client-bridge/.streamlit/    # move file
source venv/bin/activate                         # init venv

cat                                              # 🐱 (display + concat files together to vw)
head -n 20 README.txt
tail -n 20 README.txt
	
```



```

ctrl + u == like `esc` in ps, clears line
ctrl + l == clear output history
ctrl + e == end of line
ctrl + a == beg of line
pasting == right-click or shift+insert
(from nano) ctrl + x == exit, y == yes

```


```
cat file1.txt file2.txt file3.txt > combined.txt
```

| **Command** | **Purpose / Function**                                                              | **Best Use Case**                                                                                                                                    |
| ----------- | ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`cat`**   | **Concatenates** and dumps the entire file content **all at once** to the terminal. | Quick view of **small files** (like config files or your small app.py). Its output remains visible in your terminal history for copying and pasting. |
| **`less`**  | A **pager** that displays file content **one screen at a time**.                    | Viewing **large files** (like log files). It allows you to scroll backward and forward, and search for text within the file.                         |

- **`head`**: See the beginning (the head) of the file.
- **`tail`**: See the end (the tail) of the file.
- **`less`**: View the file in manageable **pages**, allowing you to move _less_ than the whole file at once. It is an improvement on the older `more` command (which was more limited in navigation).

The `-l` option for the `ls` command stands for **long format**.

It tells the `ls` command to display a detailed, comprehensive listing of each file and directory, rather than just showing their names.

---

## 🧐 What `ls -l` Shows (Long Format)

The long format provides a lot of crucial information at a glance, organized into columns:

1. **File Type & Permissions:** Shows whether it's a file (`-`), directory (`d`), or link (`l`), followed by the read (`r`), write (`w`), and execute (`x`) permissions for the owner, group, and others.
2. **Number of Links:** The number of hard links to the file.
3. **Owner:** The user who owns the file.
4. **Group:** The group that owns the file.
5. **Size:** The file size in bytes.
6. **Last Modified Date & Time:** When the file was last changed.
7. **Name:** The name of the file or directory.
    

---

## 💻 Other Common `ls` Options

The `ls` command is one of the most frequently used tools in Linux, and it has many options (also called **switches** or **flags**) to change how it displays the list:

|**Option**|**Command**|**Purpose**|
|---|---|---|
|**`-a`**|`ls -a`|**All**. Lists all files, including **hidden files** (those starting with a dot, like `.gitignore` or `.streamlit`).|
|**`-h`**|`ls -h`|**Human-readable**. Used with `-l`, it displays file sizes in easy-to-read units (e.g., K for kilobytes, M for megabytes) instead of just bytes.|
|**`-t`**|`ls -t`|**Time**. Sorts the list by the last modification time, showing the most recently changed files first.|
|**`-R`**|`ls -R`|**Recursive**. Lists the contents of all subdirectories within the directory.|
|**`-S`**|`ls -S`|**Size**. Sorts the list by file size, with the largest files appearing first.|

You can often combine options, for example: `ls -lha` will give you the **l**ong format, with **h**uman-readable sizes, including **a**ll hidden files.

```ls

# Check if venv exists and has packages installed
ls -la ~/client-bridge/venv/bin/python3 && echo "✅ venv exists" || echo "❌ venv missing"

# Check if packages are installed (only works if venv exists)
source ~/client-bridge/venv/bin/activate 2>/dev/null && pip list | grep -E "streamlit|beautifulsoup4|pandas" && echo "✅ Packages installed" || echo "❌ Packages missing or venv not activated"

```
---
The command **`source`** is a built-in shell command in Linux, primarily used to **read and execute commands from a file in the current shell environment**.

The key phrase here is **"in the current shell environment."** This is what makes it fundamentally different from just running a script normally.

## 🔑 What `source` Does (and Why It's Necessary)

When you run a script normally (e.g., `./myscript.sh`), the shell creates a brand-new, separate environment (a sub-shell) to execute it. When the script finishes, the sub-shell is destroyed, and any changes it made to variables or settings are lost.

The `source` command bypasses this:

- **It executes the script directly in your active, current shell.**
- **Any changes made by the script—like setting new environment variables, defining functions, or modifying your command path—become permanent in your current terminal session**.
    

### Most Common Use Case: Virtual Environments

The reason you used `source venv/bin/activate` in your deployment guide is the single most common and critical use of this command:

1. The file `venv/bin/activate` is a simple shell script.
2. It contains commands that primarily **modify your shell's environment variables**, specifically the **`PATH`** variable, so that when you type `python` or `pip` or `streamlit`, the shell looks inside the `venv/bin` folder first.
3. If you ran this script _without_ `source` (i.e., `./venv/bin/activate`), the `PATH` would only be changed in the temporary sub-shell, and as soon as the script finished, your terminal would go back to using the global Python.
4. By using **`source`**, the changes to the `PATH` are made to your current terminal session, allowing you to use the isolated virtual environment's tools.
    

## Alternate Syntax

You may also see the `source` command written using a single period (`.`):

Bash

```
# These two commands are identical in function:
source venv/bin/activate
. venv/bin/activate
```