2026-02-24 03:25 PM

1. create / insert tables
2. drop views → AZP: _obsolete_
3. copy and paste AZP.Playground --> AZD.EDW
4. create Fresh Service ticket for Doug: promote views AZD --> AZP
5. PBI: change references from `Playground` → `EDW`
6. target merge 

```bash
git checkout PROD004
git fetch
git status

git checkout origin/UAT003 -- C:\Users\jonas-adam.pascua\Source\Repos\Pulse\SMEX.Report; 
git checkout origin/UAT003 -- C:\Users\jonas-adam.pascua\Source\Repos\Pulse\SMEX.SemanticModel; 
git checkout origin/UAT003 -- C:\Users\jonas-adam.pascua\Source\Repos\Pulse\SMEX.pbip

# open the file locally to test
```

7. Debug any TMDL lineage tags -- maybe deleted something and replace


---
#status/deferred/quick-paste-merge-later 
You’re on the right track using `git checkout <branch> -- <path>` for a “take theirs” operation — **but the key problem is that it does *not* remove files that exist in PROD004 but *don’t* exist in UAT003**. Those “leftover” files are exactly how you end up with duplicate TMDL objects / lineage collisions.

To make it a **true full overwrite**, you need two things:

1.  **Replace** the folder contents with UAT003 versions
2.  **Delete** anything in PROD004 that is not in UAT003 for those paths

Below are a few solid patterns (pick the one that fits your workflow). I’ll include both **PowerShell (Windows-friendly)** and **pure Git** options.

***

## ✅ Best Practice: Use `git restore --source` + clean untracked files

This approach is modern and explicit (Git 2.23+). It *replaces tracked files* from UAT003, and then you clean untracked leftovers.

> **Important:** Make sure those folders are tracked by git. If some generated artifacts are untracked, they won’t be overwritten unless you clean.

### PowerShell script (safe + repeatable)

```powershell
# 1) Ensure you're on PROD004
git checkout PROD004
git fetch origin

# 2) Hard overwrite the three targets with UAT003 versions
git restore --source origin/UAT003 --staged --worktree `
  SMEX.Report `
  SMEX.SemanticModel `
  SMEX.pbip

# 3) Remove files that are now untracked (leftovers)
# Preview first:
git clean -nd SMEX.Report SMEX.SemanticModel

# If preview looks right, actually delete:
git clean -fd SMEX.Report SMEX.SemanticModel

# 4) Verify
git status
```

### Why this prevents the lineage-tag issue

*   `git restore` ensures the **tracked state** exactly matches UAT003
*   `git clean` removes **leftover files** that would otherwise remain and cause duplicates

***

## ✅ Most Deterministic: Delete the folders, then check out from UAT003

This is the closest to “full overwrite” in human terms: remove local folders first.

### PowerShell version

```powershell
git checkout PROD004
git fetch origin

# Delete the folders completely (local working tree)
Remove-Item -Recurse -Force .\SMEX.Report
Remove-Item -Recurse -Force .\SMEX.SemanticModel

# Now bring them back exactly as in UAT003
git checkout origin/UAT003 -- SMEX.Report SMEX.SemanticModel SMEX.pbip

git status
```

> ✅ This guarantees no leftover files remain in those folders.

**Caveat:** If the deleted folders contain untracked items you *wanted*, they’ll be removed too. (Usually that’s good.)

***

## ✅ Pure Git “Take theirs” + remove leftovers (no filesystem delete)

If you don’t want to delete via PowerShell:

```bash
git checkout PROD004
git fetch origin

# Replace tracked files
git checkout origin/UAT003 -- SMEX.Report SMEX.SemanticModel SMEX.pbip

# Remove untracked leftovers inside those folders
git clean -nd SMEX.Report SMEX.SemanticModel
git clean -fd SMEX.Report SMEX.SemanticModel

git status
```

***

## ⚠️ If you also want to remove tracked files that exist only in PROD004

This is the subtle part:  
If PROD004 has *tracked* files that UAT003 deleted, checking out UAT003 won’t delete them automatically unless your index/worktree is reset to match.

The safest way (still scoped) is:

### “Reset these paths to UAT003”

```bash
git checkout PROD004
git fetch origin

# Reset index + worktree for those paths to match UAT003
git reset --hard origin/UAT003 -- SMEX.Report SMEX.SemanticModel SMEX.pbip

# Clean untracked leftovers in those folders
git clean -fd SMEX.Report SMEX.SemanticModel

git status
```

> Note: `git reset --hard <commit> -- <paths>` is supported in modern Git; if your Git complains, use the `git restore` method above.

***

## ✅ Your original commands — the corrected version

Also, you don’t want Windows absolute paths in `git checkout -- <path>`.  
Git expects **repo-relative paths** and forward slashes work best.

So instead of:

```bash
git checkout origin/UAT003 -- C:\Users\...\SMEX.Report
```

Use:

```bash
git checkout origin/UAT003 -- SMEX.Report
git checkout origin/UAT003 -- SMEX.SemanticModel
git checkout origin/UAT003 -- SMEX.pbip
git clean -fd SMEX.Report SMEX.SemanticModel
```

***

## Recommended “One-liner” workflow you can reuse

### PowerShell function style

```powershell
git checkout PROD004
git fetch origin
git restore --source origin/UAT003 --staged --worktree SMEX.Report SMEX.SemanticModel SMEX.pbip
git clean -fd SMEX.Report SMEX.SemanticModel
git status
```

This is the cleanest “full overwrite” sequence.

***

## Extra guardrails to avoid repeating this

### 1) Always preview deletes before `git clean`

```bash
git clean -nd SMEX.SemanticModel
```

### 2) After overwrite, run a quick lineage duplicate scan (optional)

If you want, I can give you a quick PowerShell script to scan `.tmdl` for duplicate `lineageTag:` GUIDs and fail the operation before commit.

***

## Quick question (so I tailor it correctly)

When you say “full overwrite”, do you mean:

1.  **Only your local working tree**, then you commit (most common), **or**
2.  You want PROD004 to literally become identical to UAT003 for those paths (including deletions of tracked files) every time?

Either way the snippets above work — but I’ll recommend the best “standard” version once I know which you want.
