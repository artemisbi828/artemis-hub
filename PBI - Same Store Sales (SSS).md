---
aliases:
  - SSS
---
--> D_Office 
SSS = Offices that have a dashboardstartdate < CutOffDate (bomonth(selected(max(DateKey)))
[[PRJ - Resume Website PBI]] → SSS is hardcoded bc data is static


Normally
```
-- we want to filter in only those that have this flag
-- STATIC CUTOFFDATE → maxOdsDateKey = '2025-12-31' → bomonth → '2025-12-01' → less 1 year := '2024-12-01' 
-- DYNAMIC CUTOFFDATE → var: selected(maxDateKey), less 1 year, iff(DashboardStartDate < CutoffDate, SSS, null)
```


### **2. Dynamic Same-Store (Comparable) Logic**

**The Problem:** Rapidly scaling companies often have "immature" locations that inflate total growth but skew efficiency ratios and YoY performance metrics. **The Specialized Solution:** I implement automated "Same-Store" logic that dynamically evaluates every office’s maturity against the user’s selected date range. Using SQL-driven "Dashboard StartDates" and Calculation Groups, I create a global toggle that instantly filters reports to include only offices with a full year of comparable history. **Executive Value:** This protects decision-makers from "False Growth" signals. It ensures that strategic pivots are based on the performance of a stable, comparable portfolio rather than being masked by the high-variance data of new office launches.
