## File Layer
Check that filters are set to ideal Default Open 
Refresh locally else SVC.REFRESH fails

File Check Default Save
- All Filters → Reset
- Expand + CHK-ALL Colors
## Service Layer
Workspace: ensure all business users are in ADGroup --> `POWER BI QA`
Audience Group: AD Group
## Dataset Layer
[[Row Level Security]]
5. Datasource Gateways | VNET
6. Different Dataset: Security → 
```
Department.All.Clinical
Department.All.Support
```




GIT-UAT003
	commit changes using format
	sync up to git-remote
PulseUAT.Workspace
	source control --> Update All
	update app --> update app
	refresh semantic model
PulseUAT.App
	open new tab --> validate


# UAT → PROD: STEP 1
1. swap references to AZD
2. initiate FS ticket for Doug to promote
3. swap references to AZP.Playground --> AZP.EDW
4. test on UAT
5. Use [[GIT - Targeted Sync and Overwrite]] to load specific PROD004

# UAT → PROD: STEP 2
1. swap references to AZD
2. RLS Settings
```
Department.All.Clinical
Department.All.Support
```
3. Semantic Model → Settings → 
4. Schedule Daily API Call 
5. Update App → 2) Content
	1. Rename w spaces if necessary
6. Audience: 
	1. Executive
	2. Regional Manager \ Doctor \ Practice Director \ Treatment Coordinator \ Clinic Team
	3. Support
	4. RCM
	5. Finance & Accounting
	6. 
 
Dataset Layer
- Security


Go Live Date? Midday. Small set.
- Soft Release + Test
Full Announcement


```
= Sql.Database("az-p-sqlmi-fg-01.secondary.69bd49c6ce6d.database.windows.net", "EDW")`
```
Make sure dataset is refreshed otherwise will see weird things
Remove files from UAT