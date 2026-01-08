Continue to experiment with embedded dataviews; 

knowledge_type
	[[domains]] -- Umbrella business area → Business Area / Department
	people -- 
	vendor -- 
	[[entities]] -- Tables
	concepts -- Columns
	- types -- Dropdown Values in Column, Flag
	- metric -- (Measure) Currency, Count
	methods -- Frameworks, Logic
	output\reports
	output\dashboards

04 - Database Objects
- Tables -- parents are Entities, every table has a parent Entity
	- Entity Note describes semanticly
	- DAO describes 
- Procs -- parents are (M) tables and children are listed
- Columns are metadata INSIDE Note.Tables

Play with this but focus on 

Dictionary
- folder for quick-org
- Atomic & Simple -- Term, Alias | Abbreviation, Definition
- If combo definition → CONCEPT
- If explanation + links out → CONCEPT

[[Concepts]] -- Background, Learning (No Action; Quickstart)
[[Tools]] -- Concepts | + {Action, Quickstart}
[[Types]] -- Something in drop down? Something that drills down? 
[[SQL]]

AI 
- infer and fill empty domains

# Billable Hours.md

---

concept_category: metric

domain: financial

calculated_from: [TimeEntry, Employee, Engagement]

---


Retrain 

| Natural                        | Refined                                   |
| ------------------------------ | ----------------------------------------- |
| Key == SourcesystemId, patGUID | Composite Key: `SourcesystemId + PatGUID` |
