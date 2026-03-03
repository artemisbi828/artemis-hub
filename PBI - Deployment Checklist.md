2026-02-24 03:25 PM

1. refresh locally else SVC.REFRESH fails
2. ensure all business users are in ADGroup --> `POWER BI QA`
3. File Check Default Save
	- All Filters → Reset
	- Expand + CHK-ALL Colors
4. [[Row Level Security]]
5. Datasource Gateways | VNET


GIT-UAT003
	commit changes using format
	sync up to git-remote
PulseUAT.Workspace
	source control --> Update All
	update app --> update app
	refresh semantic model
PulseUAT.App
	open new tab --> validate


# Older Notes
Use [[GIT - Targeted Sync and Overwrite]] to load specific PROD004


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
