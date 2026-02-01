
```bash
#1: ensure branch
  git checkout PROD004
  git fetch
  git status

#2: pull only files we want
  git checkout origin/UAT003 -- abs_path/to/folder
  git checkout origin/UAT003 -- abs_path/to/file.ext

#3: review the diffs, have those files stagged
#4: commit them
```

---
**“How can Git take a _local_ path and pull the _remote_ version of that file, even though the path I typed is local?”**

The short answer:  
**Because the path is never used to locate the file in the remote branch. It’s only used to locate the file _inside your working tree_. The branch reference determines which version of that file Git pulls.**

# 🔍 What Git actually does when you run:

```bash
git checkout origin/UAT004 -- RFR.Report
```

Git interprets this as:

1. **`origin/UAT004`** → “Look at this branch/tree-ish for the source version”
2. **`--`** → “Everything after this is a path in the working tree”
3. **`RFR.Report`** → “This is the path _in my repo_, not on my filesystem”

Git then:

- Looks inside the **tree object** for `origin/UAT004`
- Finds the file or folder `RFR.Report` _in that branch’s tree_
- Copies that version into your working directory
- Stages it for commit

At no point does Git care about your Windows absolute path.
Git is path‑agnostic to your OS. It only understands the **repo’s internal directory structure**.

---

# 🧩 Why Git “knows” the remote version

Because Git stores the entire file tree of every commit and branch inside the `.git` directory.

When you say:

```
git checkout origin/UAT004 -- RFR.Report
```

Git doesn’t go to the remote server.  
It simply:

- Looks at the **tree object** for `origin/UAT004` (which you fetched earlier)
- Finds the file inside that tree
- Writes it into your working directory

Git’s object database already contains the full snapshot of that branch.