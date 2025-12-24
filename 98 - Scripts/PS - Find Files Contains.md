

```powershell

Get-ChildItem -Recurse -File | Select-String -Pattern "tree" | Select-Object -Unique Path
```
