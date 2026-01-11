2026-01-10 07:48PM -- #status/savepoint 
1. Create data sanitization TSQLs
	1. anything %, if something spikes 2x incrementally by MONTH -- show it and denom
	2. joins between views -- show orphans
	3. LY → build it 
2. Extract a vw_F_Contracts from SD w correct case start numbers and non-case start numbers; No need for ledger types; 
3. Create data-dictionary solution [[PRJ - PBI Data Dictionary]]
4. Create Power UI -- [[PRJ - PBI JSON Blocks]]
5. [[PRJ - PBI Profile Picture Thumbnails]]
6. New Pages
	1. Top Performers
	2. Scheduling Optimizations
Create information 


[[PBI]]
[[DAXM]]

| OfficeKey   OfficeCode  OfficeName  OfficeNameCode              |
| --------------------------------------------------------------- |
| 14  12001   Killeen - Central   Harker Heights - Morgan (12001) |

# Features
- What are we tracking? 
	- YoY + General KPI Trends w Drilldowns → [Executive Insights]
	- MWD Tracking {Portfolio or LocationGrain} to see key metrics → [Trending Performance]
		- Holiday Name (Panel 1)
		- #status/todo → widen x-axis band (eg dailly) to add more data 
		- Especially → Production Related Metrics
		- MWD → SlicerTypeSort
	- Operations / Drill-down focus for comparison → Ctrl+Select to Multi-Select → [Performance Drill-Down]
	- Scheduling + Conversion
	- Exception Reporting
- Confidence
	- As Of Date -- Data Freshness + Green Checkbox
	- Information Box
- Normalization Buttons → Enterprise Executives
	- Drill Downs
	- [[PBI - Same Store Sales (SSS)|SSS]] --- D_Offices
	- [[PBI - Work Day Equivalent|WDE]] -- D_Dates 
- Fast Loads
	- Dashboards vs Reports -- spotlight, focus, fresh
		- Fact Tables are Aggregates
		- Dimensions
		- Everything up stream, using TSQL-views
	- YOY as merged copy of table
	- Copy of F_Table; Rename DateKey → {DateKeyLY, DateKeyRaw} → Add DateKey-Bridge (+1YR) → inner join (pbi-merge) to DateKey



---
#quick-paste-merge-later 

> "I bridge the gap between raw database architecture and executive decision-making. By building normalization frameworks—like **WDE Capacity Scoring** and **Dynamic Same-Store Flags**—I transform high-volume enterprise data into high-integrity insights that survive the 'common sense' test in the boardroom."


### **How to display this on your site:**

I recommend a small "Data Strategy" section with icons for each.

- **WDE Normalization Icon:** A calendar with a scale/balance.
- **Same-Store Icon:** Two identical store-fronts with a "Match" checkmark.
    

### **Suggested "Next Step" for your site:**

Include a call to action like:

> "Most dashboards report what happened; mine report why it happened. Would you like to see how I handle multi-regional holiday logic in global SQL environments?"