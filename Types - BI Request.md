New 


# Ticket

| Type     | RequestType                    | Description                                 | Example                                                   | Comment                                                                                                         | SortOrder |
| -------- | ------------------------------ | ------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------- |
| Newbuild | New Report or Dashboard        | Need a new way to see existing data         | Create an XLS or dashboard for patient admissions         | New queries, dashboards, business rules engine                                                                  | 1         |
| Newbuild | Enhancement Request            | Modify existing dashboards or pipelines     | Add IsPhoenix Flag to dashboards                          |                                                                                                                 | 2         |
| Ticket   | Data Issue or Correction       | Something looks wrong or needs fixing       | NPE numbers look too high yesterday                       | Investigate data bug, change historical data (pipeline fixes, schedule adjustments, UTC shifts)                 | 3         |
| Ticket   | Logic or Documentation Support | Need documentation or lineage for reporting | Show lineage and definitions for Starts from Start Needed | Logic & semantic modeling; documentation tasks (lineage mapping, audit trail creation, schema versioning)       | 4         |
| Newbuild | New Data Source or Pipeline    | Bring in new data we don't have yet         | Add Equifax API or Align Data                             | Source integration, schema design, ingestion jobs                                                               | 5         |
| Newbuild | Update Rules or Definitions    | Change how data is calculated or defined    | Redefine 'active customer' metric                         | Map semantic logic, change logic, or mapping (reverse-engineering, redefining mappings, semantic model updates) | 6         |
| Ticket   | Access or Permissions          | Help me get into a report or dataset        | Give FPA team access to labor costs data                  | Manage or grant user access, security, workspace permissions, row-level-security                                | 7         |
| Ticket   | Performance or Speed Issue     | Dashboard or query is slow                  | Revenue dashboard takes 5 minutes to load                 | Optimization tasks (query tuning, refactoring, caching strategies); create diagnostic tools; conform            | 8         |
| Ticket   | Help Using BI Tools            | Walkthroughs, training, or guidance         | Show me how to filter in Power BI                         | Onboarding or self-service enablement                                                                           | 9         |
| Newbuild | Alerts or Automation           | Set up proactive notifications              | Alert me if production swings more than 30%               | Setup monitoring or scheduled reports                                                                           | 10        |
| Newbuild | Advanced Analysis              | Forecasting, ML, or deeper analytics        | Predict patient volume for next quarter                   | Forecasting, ML integration, statistical or predictive modeling, or exploratory analysis                        | 11        |

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