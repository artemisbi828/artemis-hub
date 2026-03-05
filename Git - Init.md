Initialize a folder 

```shell
cd C:\vsWorkspace\jpascua313
git init
git config user.name "jpascua313"
git config user.email "jpascua@gmail.com"
git remote add origin https://github.com/jpascua313/intro  
```

```shell
# initialize current folder as git
git init                                                                   
git checkout main # (optional) -- switch to main

# bind current folder to remote
git remote -v  ## what is remote?
git remote add origin https://github.com/artemisBI/shared-utils     
```

## Setup Git; Pull Remote

```shell
# go to path
cd path/to/your/repo

# optional to remove local changes (untracked)
git clean -fd

# force merge
git pull origin main
git fetch -p #prune deleted remote branches (keeps local list clean)
```
