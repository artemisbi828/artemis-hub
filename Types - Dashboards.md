standard bi dashboards using agg details
[[PBI|Tools]] 

---


# PBI Features

- executive-insights: trendlines and slices: yoy
- eom-tracker: end-of-month tracker (Heartbeat)
- performance-tracker: eg call work queue -- load calllist. assigns to teams by % and by priority. log on web app. $2K for basic. 
- calendar tracker. capacity vs scheduled. sms reminders. 
- rev-cycle; cost-management; attrition
- nightly dashboards from agg. load xls end of day. dashboards the next day. punch cards, sales, etc. no names. sms msg for leaders. bi-alarms. 
- leaderboards for motivation and friendly competition. 
	- scheduling
	- nurture (sales)
	- call-teams


what tracking pxq. p/q. t. q. 
   by y.m.d 
   by team, location, manager, emp. 
   
- What are we tracking? 
	- Trendlines -- YoY + General KPI Trends w Drilldowns → [Executive Insights]
	- MWD Tracking {Portfolio or LocationGrain} to see key metrics → [Trending Performance]
		- Holiday Name (Panel 1)
		- widen x-axis band (eg dailly) to add more data 
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
	- [[DAX - Same Store Sales (SSS)|SSS]] --- D_Offices
	- [[DAX - Work Day Equivalent (WDE)|WDE]] -- D_Dates 
- Fast Loads
	- Dashboards vs Reports -- spotlight, focus, fresh
		- Fact Tables are Aggregates
		- Dimensions
		- Everything up stream, using TSQL-views
	- YOY as merged copy of table
	- Copy of F_Table; Rename DateKey → {DateKeyLY, DateKeyRaw} → Add DateKey-Bridge (+1YR) → inner join (pbi-merge) to DateKey

---
apply json package -- alt design
-- production by txgroup? smile express vs txplans (slice by qtr?)
-- sales amount by top 5 production days (holidays?)

	---
	



privacy -- agg or anonymize. letters. w random numcode? computer to generate a new set monthly. 

#open-loop/quick-paste-merge-later 
```
- number of net new clients.
- number of marginal staff. vs fixed. fixed limit?
- latest period -- last month. last year?
- capacity limit point for staff. why? hard vs soft. 
- fill in rest w ai
```

# Facing Types
#open-loop/quick-paste-merge-later → merge with top and create a table
1. Leadership Facing  -- looking to future; trendlines + long term strategy
2. Operational Facing -- short term goals; KPIs (hindsight, foresight, action)

- curbing (-) -- decreased waste, less setup costs, less overhead, less errors (neg outputs)
- lifting (+) -- increased outputs, better quality
- accelerating (+) -- faster throughput

4. Customer Facing -- enhance the customer experience

- increased visibility and trust
- decreased cost (self-serving) reducing load on inbound call queue / triage

- add element
	- add mode (eg multi-select)
	- add filtering (by location on tablet)
	- add dictionary ("i" button)
- set default (bookmark)
- add button
- change visibility
- bug fix