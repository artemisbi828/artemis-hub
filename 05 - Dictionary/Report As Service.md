---
definition: delivering a report’s output on a schedule, without the user opening Power BI.
aliases:
  - RAS
---
In our environment, that has meant **Power BI Subscriptions** (and sometimes **Paginated Reports**) that:

- Render a report at a point in time
- Execute the underlying dataset / stored procedures
- Email the results to recipients on a cadence

This is visible directly in our internal traffic from **Microsoft Power BI subscription emails** tied to named reports.