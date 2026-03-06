[[PRJ]] -- Projects
[[Concepts]] -- Background, Learning (No Action; Quickstart)
[[Tools]] -- Concepts | + {Action, Quickstart}
[[Types]] -- Something in drop down? Something that drills down? 
[[SQL]]


# Daily Tags
Related to SD-WORK\Master
#status/open-loop/new -- new request that needs to be on my radar
#status/open-loop/in-progress-p1 -- high anxiety, important or deadline
#status/open-loop/in-progress-p2 -- relaxed
#status/open-loop/delegated-or-assigned -- someone else has the ball
#status/deferred/quick-paste-merge-later -- read later when I have free time
#status/deferred/schedule-later -- 

#status/pending/requester
#status/pending/vendor
#status/pending/someone-approval
#status/pending/future-date

#status/closed-loop/completed
#status/closed-loop/cancelled
#status/closed-loop/rejected
#status/closed-loop/no-response

#status/closed-loop/learned -- learned something
#status/closed-loop/installed-global -- installed something global
#status/closed-loop/installed-venv -- installed venv

#status/closed-loop/social-call
#pending/delete-if-mastered
## Other Verbs
completed
added
removed
answered
repushed
routed
met-with
noted
recorded
budgeted
planned
would-adjust
would-refactor
would-validate-earlier
would-standardize
would-elevate



---


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
