{{date:YYYY-MM-DD}}

# Joins
[[Lake.sd.WorkAssignments]] via 'EmployeeCode = EmployeeCode'


# Templater Plugin
---
entity_name: <% tp.file.title.split('.').pop() %>
table_name: <% tp.file.title.split('.').pop() %>
qualified_name: <% tp.file.title %>
database: <% tp.file.title.split('.')[0] %>

schema: <% tp.file.title.split('.')[1] %>
---

# <% tp.file.title.split('.').pop() %>
## Templater Syntax Cheat Sheet

|Template Code|Output for "Lake.sd.Offices"|
|---|---|
|`<% tp.file.title %>`|Lake.sd.Offices|
|`<% tp.file.title.split('.').pop() %>`|Offices|
|`<% tp.file.title.split('.')[0] %>`|Lake|
|`<% tp.file.title.split('.')[1] %>`|sd|
|`<% tp.date.now("YYYY-MM-DD") %>`|2026-01-06|