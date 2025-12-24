
# Ticket

```json
{
  "ticket": [
    {
      "requestType": "Logic or Documentation Support",
      "description": "Need documentation or lineage for reporting",
      "example": "Show lineage and definitions for Starts from Start Needed",
      "comment": "Logic & semantic modeling; documentation tasks (lineage mapping, audit trail creation, schema versioning)",
      "sortOrder": 4
    },
    {
      "requestType": "Data Issue or Correction",
      "description": "Something looks wrong or needs fixing",
      "example": "NPE numbers look too high yesterday",
      "comment": "Investigate data bug, change historical data (pipeline fixes, schedule adjustments, UTC shifts)",
      "sortOrder": 3
    },
    {
      "requestType": "Access or Permissions",
      "description": "Help me get into a report or dataset",
      "example": "Give FPA team access to labor costs data",
      "comment": "Manage or grant user access, security, workspace permissions, row-level-security",
      "sortOrder": 7
    },
    {
      "requestType": "Performance or Speed Issue",
      "description": "Dashboard or query is slow",
      "example": "Revenue dashboard takes 5 minutes to load",
      "comment": "Optimization tasks (query tuning, refactoring, caching strategies); create diagnostic tools; conform",
      "sortOrder": 8
    },
    {
      "requestType": "Help Using BI Tools",
      "description": "Walkthroughs, training, or guidance",
      "example": "Show me how to filter in Power BI",
      "comment": "Onboarding or self-service enablement",
      "sortOrder": 9
    }
  ],
  "newBuild": [
    {
      "requestType": "New Report or Dashboard",
      "description": "Need a new way to see existing data",
      "example": "Create an XLS or dashboard for patient admissions",
      "comment": "New queries, dashboards, business rules engine",
      "sortOrder": 1,
      "subCategories": [
        "Basic Query or File",
        "Company Wide Dashboard"
      ]
    },
    {
      "requestType": "Advanced Analysis",
      "description": "Forecasting, ML, or deeper analytics",
      "example": "Predict patient volume for next quarter",
      "comment": "Forecasting, ML integration, statistical or predictive modeling, or exploratory analysis",
      "sortOrder": 11
    },
    {
      "requestType": "Enhancement Request",
      "description": "Modify existing dashboards or pipelines",
      "example": "Add IsPhoenix Flag to dashboards",
      "comment": "",
      "sortOrder": 2
    },
    {
      "requestType": "New Data Source or Pipeline",
      "description": "Bring in new data we don't have yet",
      "example": "Add Equifax API or Align Data",
      "comment": "Source integration, schema design, ingestion jobs",
      "sortOrder": 5
    },
    {
      "requestType": "Update Rules or Definitions",
      "description": "Change how data is calculated or defined",
      "example": "Redefine 'active customer' metric",
      "comment": "Map semantic logic, change logic, or mapping (reverse-engineering, redefining mappings, semantic model updates)",
      "sortOrder": 6
    },
    {
      "requestType": "Alerts or Automation",
      "description": "Set up proactive notifications",
      "example": "Alert me if production swings more than 30%",
      "comment": "Setup monitoring or scheduled reports",
      "sortOrder": 10
    }
  ]
}

```

| RequestType                 | Description                                 | Example                                                     | Comment                                                                                                   | SortOrder |
| --------------------------- | ------------------------------------------- | ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------- |
| Compliance or Audit Support | Need documentation or lineage for reporting | “Show lineage and definitions for Starts from Start Needed” | Logic & semantic modeling; documentation tasks (lineage mapping, audit trail creation, schema versioning) | 2         |
| Data Issue or Correction    | Something looks wrong or needs fixing       | “NPE numbers look too high yesterday”                       | Investigate data bug, change historical data (pipeline fixes, schedule adjustments, UTC shifts)           | 3         |
| Access or Permissions       | Help me get into a report or dataset        | “Give FPA team access to labor costs data”                  | Manage or grant user access, security, workspace permissions, row-level-security                          | 7         |
| Performance or Speed Issue  | Dashboard or query is slow                  | “Revenue dashboard takes 5 minutes to load”                 | Optimization tasks (query tuning, refactoring, caching strategies); create diagnostic tools; conform      | 8         |
| Help Using BI Tools         | Walkthroughs, training, or guidance         | “Show me how to filter in Power BI”                         | Onboarding or self-service enablement                                                                     | 9         |
|                             |                                             |                                                             |                                                                                                           |           |
# New Build

| RequestType                 | Description                              | Example                                             | Comment                                                                                                         | SortOrder |
| --------------------------- | ---------------------------------------- | --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------- |
| New Report or Dashboard     | Need a new way to see existing data      | “Create an XLS or dashboard for patient admissions” | New queries, dashboards, business rules engine                                                                  | 1         |
| Enhancement Request         | Modify existing dashboards or pipelines  | "Add IsPhoenix Flag to dashboards"                  |                                                                                                                 | 4         |
| New Data Source or Pipeline | Bring in new data we don’t have yet      | “Add Equifax API or Align Data”                     | Source integration, schema design, ingestion jobs                                                               | 5         |
| Update Rules or Definitions | Change how data is calculated or defined | “Redefine ‘active customer’ metric”                 | Map semantic logic, change logic, or mapping (reverse-engineering, redefining mappings, semantic model updates) | 6         |
| Alerts or Automation        | Set up proactive notifications           | “Alert me if production swings more than 30%”       | Setup monitoring or scheduled reports                                                                           | 10        |
| Advanced Analysis           | Forecasting, ML, or deeper analytics     | “Predict patient volume for next quarter”           | Forecasting, ML integration, statistical or predictive modeling, or exploratory analysis                        | 11        |
## Request SubType
New Report or Dashboard
- Basic query or file
- Company dashboard

Testing Thresholds

Validate Logic

- Dev builds change
- Dev runs regression suite
- SME reviews
- BI lead signs off
- Deploy to production


3. What tools are used?
- SQL diff scripts
- Excel exports
- Automated SQL tests (if you want to go advanced)

- Power BI compare reports