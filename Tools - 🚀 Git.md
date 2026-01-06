[[GIT - Check Config Globals]]
[[GIT - Init]]
[[GIT - Rename master → main]]

# Error Handling
[[GIT - Error Handling - Stuck in VS Termainl]]
[[GIT - Error Handling - Remote Not Found]]


Up to date but 1 branch ahead means ...
```
Your Local:     A -- B -- C -- D (your new commit)
GitHub Remote:  A -- B -- C
```

You need to stage commit (if haven't already) then 

```git
git push origin main
git push -u origin main               # if getting an error about upstream
```



# Basics

## Setup Git; Pull Remote

```shell
# go to path
cd path/to/your/repo



# optional to remove local changes
git clean -fd

# force merge
git pull origin main
git fetch -p #prune deleted remote branches (keeps local list clean)
```

## Sync Local to Remote
Renamed master to main
```bash
#rename from master → main
git branch -m master main

# Refresh your local list of remote branches
git fetch origin

# Link your local 'main' to the remote 'origin/main'
git branch -u origin/main main

git pull

# if you get this error from running git fetch origin
# git: 'credential-manager-core' is not a git command. See 'git --help'.
# run this
git config --global credential.helper manager
```

## Oops Commands
```shell

#discard all local changes (DANGER)
git reset --hard HEAD 

# messed up file and want to revert to last commit
git checkout -- filename.js

# undo last commit (but keep changes in file)
git reset --soft HEAD~l

```

```shell

git fetch origin
git reset --hard origin/deploy/vercel  #force sync to remote (cloned local); 
# alias → git reset --hard HEAD

git stash push -u -m "feat: add custom message"  ## -- u = untracked, m = msg

# save work temporarility to switch branches, get work back, drop it
git stash 
git stash pop
git stash drop


```
## Git UI Changes
1. setup as private
2. Settings >> Rename default branch >> main
3. Settings >> Danger Zone >> Disable Branch Protection


## Normal 

```git

git branch
git branch -a ## see all branches(local, local-current, remote) → white, green, red
git branch --show-current
git checkout -b feature/name-of-task    #switch branch

# see uncommitted
git status

# commit and stage 
git add .                                
git add filename.md
git commit -m "Add commit cmment name"

# fetch all branches and PRs from remote (soft)
git fetch origin  ## soft get
git merge

# fetch + merge all at once
git pull origin

# make sure local-main is same as remote-main
git checkout main
git pull origin main                     

# list all branches to find the pr we want
git branch -r
git checkout pr-branch-name
```

## Delete remote
```git
git push origin ## --> delete deploy/vercel
git branch -D deploy/vercel ## --> delete local
```

## Overwrite Remote
```shell

git push -u origin main --force
git push -u origin MYBRANCHNAME
git log ## history of commits

```

# Reviewing a PR
VS Code's built-in Source Control panel (Ctrl+Shift+G) to review changes visually.

```git
# fetch branch from origin
git fetch origin feature/ARed/initial-setup
git checkout feature/ARed/initial-setup

# See diffs; 
git log origin/main..HEAD
git diff origin/main

# Test the code
bash scripts/run_all.sh
```


# Navigating in Git Diff
Stuck in the terminal pager? 
```
# exit
Press: q
```

## Navigation While Viewing:

- `Space` or `Page Down` - Next page
- `b` or `Page Up` - Previous page
- `↓` or `Enter` - Next line
- `↑` - Previous line
- `g` - Go to beginning
- `G` - Go to end
- `/search-term` - Search forward
- `q` - **Quit/Exit**

## To See All Diffs at Once (No Pager):

```powershell

# Disable pager for one command
git --no-pager diff origin/main

# Or disable globally (not recommended)
git config --global core.pager cat

# Better: Use a nicer pager
git config --global core.pager "less -FRX"

```

## Pro Tip - View Diff in VS Code:

```powershell

# Much easier to review!
git difftool origin/main

```



# Supplementals
### Branch vs Fork
Branch -- for internal dev: clone within same repository, created by user w/ `write access` to repo
Fork -- for external dev: complete copy of entire repository, created by someone w/o `write access` to repo

### Main vs Head
Head -- alias usually points to main 
Main -- actual main w latest committed code


### View Log History

```bash

    git log --oneline --graph --all --decorate

```