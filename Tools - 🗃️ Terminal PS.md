---
syntax: powershell
aliases:
  - PS
---
# Basic Commands
[[PS - Trigger PS Script]]
[[PS - Get Help]]
[[PS - Clear Host]]
[[PS - Clear Variables, Set Variables]]

# Basic Tools
[[PS - Get PnP for Sharepoint]]
# Basic Scripts
[[PS - Get Files and SubFiles]]
[[PS - Delete Item]]
[[PS - Delete all files that string_pattern]]
[[PS - Move all files into subdir that start_with]]
[[PS - Get filenames in dir → output.txt]]
[[PS - Get File Counts]]
[[PS - Copy Item for Backup]]
[[PS - Get Content - First 10 Lines]]
[[PS - Edit and Overwrite - Research]]


```
# 2 lines in 1
cd c:\vsWorkspace\jpascua313\site ; npm start

`                 # new line
;                 # separates as if new line
#                 # comment
<# #>             # multi-line comment
@()               # array
```


# Versions
- Blue is 5 (Native); Black is 7 (Current)
- Terminal > Tab > Settings > Default Open

# Output and Read
```shell
python sql_normalizer.py --input input.txt --output 20251231-1620-QRY2.md 2>&1 | Out-Null ; 
Select-String -Path 20251231-1620-QRY2.md -Pattern "^\| 9a " | Select-Object -First 5
```

```powershell






# copy / move / rename / delete
Copy-Item -Path .\src -Destination 'C:\dest' -Recurse -Force
Copy-Item -Path .\filename.py -Destination .\filename.py.bak  # create backup
Move-Item -Path .\file.txt -Destination 'C:\archive' -Force
Rename-Item -Path .\old.txt -NewName 'new.txt'


# Preview destructive actions
Remove-Item -Path .\temp -Recurse -WhatIf
Rename-Item -Path .\old.txt -NewName 'new.txt' -WhatIf

# use of backtick for readability
Move-Item `
    -Path C:\vsWorkspace\projects_sd\clean_sql_joins.py `
    -Destination C:\vsWorkspace\shared-utils\utils\clean_sql_joins.py

# bool for exists
Test-Path C:\vsWorkspace\shared-utils\utils\clean_sql_joins.py 

Get-Alias cat #define Get-Content

```

## Arrays

```powershell
$Source = 'C:\in'; $Archive = 'C:\archive'; $Error = 'C:\error'
$folders = @($Source, $Archive, $Error)
Write-Output "Count: $($folders.Count)"
Write-Output $folders        # prints each item

```
## Renames
```powershell
# Get all files in the current directory, exclude folders, rename w prefix
$files = Get-ChildItem -File
$prefix = "JONAS_"

foreach ($file in $files) {
    $newName = $prefix + $file.Name
    Rename-Item -Path $file.FullName -NewName $newName
}

Remove-Item *_1.sql    # delete items with "_1.sql" suffix
```


```powershell

# see modules from pip, select only those that have pandas in it
pip freeze | Select-String "pandas"



# backtick is new line


```


## Install

```powershell
# install
winget search Microsoft.Powershell
winget install --id Microsoft.Powershell --source winget
```

### Backtick vs `>>`
- backtick = next line
- `>>` ps auto line continuation prompt (NOT something I type)

```powershell

Get-ChildItem `
	-Path C:\ `
	-Recurse
```

### Powershell Versions

```
Windows Powershell (native) 5.1.x
Powershell 7 (Core) → 7.x.x
```


---


----

# Get Processes, Kill Processes

| command                                              | comment                                                                           |
| ---------------------------------------------------- | --------------------------------------------------------------------------------- |
| tasklist \| findstr /I "lg"<br>                      | list running processes                                                            |
| taskill /F /PID 31516 /PID 31436                     | delete multiple processes                                                         |
| wmic process where "processid='6248'" call terminate | elevated permissions using Windows Management Instrumentation Command-line (WMIC) |
| tasklist /?                                          | get help for tasklist                                                             |


# Create / ensure folder exists

```powershell

New-Item -Path 'C:\a\b\c' -ItemType Directory -Force

# safe pattern: create if missing

if (-not (Test-Path $d)) { New-Item -Path $d -ItemType Directory | Out-Null }

$sub = Join-Path $PWD 'SlideSMS'; if (-not (Test-Path $sub)) { New-Item $sub -ItemType Directory | Out-Null; "Created $sub" } else { "Already exists: $sub" }

```


# VENV
```shell

# to exit
deactivate
```


