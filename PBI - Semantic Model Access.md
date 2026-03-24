1. Grant `Viewer` access to workspace 
2. Grant `Build` access to semantic model

|Permission|What it allows|
|---|---|
|**Read**|Consume existing reports only|
|**Build**|Create new reports, Analyze in Excel, XMLA|
|**Reshare**|Grant access to others|
|**Write**|Modify the model|
|**Owner**|Full control|

To get the following go to `Report` → `Add User` → `Permissions: None` >> Read
- not `Semantic Model` → Build
![[Pasted image 20260318160233.png|250]]


App
	Audience >> 
Workspace
	`Report` → `Add User` → `Permissions: None` >> Read
	`Semantic Model` → `Add User` → `Permissions: None` → {Share, Build} >> Build
	`Semantic Model` → `Add User` → `Permissions: None` 