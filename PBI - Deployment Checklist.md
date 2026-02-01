Use [[GIT - Targeted Sync]] to load specific PROD004
Check that filters are set to ideal Default Open 
Swap references from Playground to EDW --> 
```
= Sql.Database("az-p-sqlmi-fg-01.secondary.69bd49c6ce6d.database.windows.net", "EDW")`
```
Make sure dataset is refreshed otherwise will see weird things
Remove files from UAT

# Different Dataset
Security → 
```
Department.All.Clinical
Department.All.Support
```