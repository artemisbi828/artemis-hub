#status/todo -- what does force do again? I've looked it up before

```powershell
Remove-Item .env

# delete everything in temp folder and force it 
Remove-Item -Path .\temp -Recurse -Force
```