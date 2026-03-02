[[PRJ]] -- Projects
[[Concepts]] -- Background, Learning (No Action; Quickstart)
[[Tools]] -- Concepts | + {Action, Quickstart}
[[Types]] -- Something in drop down? Something that drills down? 
[[SQL]]

# Knowledge Type

Knowledge
├─ Domains (eg: Analytics Engineeringg, Healthcare)
├─ Entities (eg: Product X, Customer 360)
├─ Vendors (Microsoft, Wherescape)
├─ People
├─ Projects (MOC)
├─ Tools (eg: SQL)
├─ Concepts 
│   ├─ Slowly Changing Dimensions
│   │     - definition
│   │     - domain
│   │     - related_concepts
│   │     - has_type
│   ├─ (concept B)
│   │     - definition
│   │     - example
│   │     - related_methods
│   │     - domain
│   └─ ...
│
├─ Types (eg: Metric Type (Leading, Lagging), SCD Type (1,2,6))
├─ Metrics (Customer Churn Rate, Net Promoter Score)
├─ Methods: A/B Testing
├─ Dictionary (Dataview-generated, not a class)
└─ Abbreviations, Aliases (Dataview-generated, not a class)
``




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



AI 
- infer and fill empty domains
