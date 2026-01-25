Research Artemis-BI notes and synthesize MVP plan inputs
REVOPS
# Orthogonal / Facets
People can just use tags. Later formalized w integrity checks for hierarchal or orthogonal relationships. Cross cutting is to use (M) facets

Orthogonal Category -- Different dimensions, not parent-child subsets. 
- Orthoggonal is opposite of hierarchal.
- eg: exams is a groupingg dimension, consults is an attribute, NPE is a sub-attribute of Consults.

Attributes or facet -- separate slice used to classify an item
- NPE could be a combination of 2 facets -- Appointment Type Group (parent rollup) 

#quick-paste-merge-later 
I've learned 2 ways of creating log tables
  D2 Tables -- SCDType2 -- Slowly Changing Dimension. IsCurrent = endDate is not null (fast to index/partition)
  CDC stream -- append-only log table 


`includes stats talk`
intercalation. inserting interlayer
# Drill In
- cognitive dissonance
• implement both scripts with comprehensive functionality
• Uncontrolled Historical Data; Mutable
	• Mutable data; Dynamic History (static (locked) history); 
		○ Retroactively updatable; editable history
	• Non-finalized data; open-ended data; editable
	• soft-closed data (vs hard-closed)
• umbrella term
• sequential-file-versioning
	This is called "auto-incrementing filename collision resolution" or "sequential file versioning". Terms you can use:
	"Increment if exists"
	"Auto-versioning"
	"Collision-free naming"
	"Sequential suffix pattern"
• semantic logic (true meaning/essence of logic; non-technical)
• what is ML integration


Points of Error
Dispersion Error -- being consistent at being off is sometimes valuable, esp for big companies; per Jenni -- predictability of error is manageable, they can hire more to cover error, but unexpectedness 

• failing to correct known faults
• reduce cognitive log for users

• standard naming conventions
• Production Formulae | Equation
• I have a tangential understanding
• 
• solid and dry principles


single responsibility principle
singularity of purpose
traceability
data mitosis; de-lineator
retro disruptive

Bridge
Upsert
Upside. Downside. 

Quantum Leap

Retro-Disruptive. 
DataVisualizing
Sublimation. 

Deciding Judiciously Tie Break
Data Dictionary Assessment -- Free of imprecision

aplomb -- the CEO addressed the criss with great aplomb -- coolness and composure under strain; 
esoteric -- the professor's lecture was quite esoteric -- specialized niche knowledge
elan -- jonas told the story with such elan -- like panache
CMS -- Customer Management System
UI -- User Interface
Greenfield -- New Site (no demolition); usually needs new infrastructure (roads, sewers, powerlines).
Brownfield -- Reused site; remdiation (cleanup) of soil to remove chemicals or waste, unpredictable, expensive, time consuming.
Greyfield -- paved site (dead mall, empty parking lot) -- prime for modern mixed-use developments; 
Evergreen -- Mature Site

Jenni Doyle
• perfect is the enemy of good
• trust but verify
• measure twice cut once 

In finance, when you're expecting revenue in the next period, a few common terms might apply depending on the context:
	1. Accrued Revenue – Revenue that has been earned but not yet received in cash or recorded. This is often used in accrual accounting.
	2. Deferred Revenue – Revenue received in advance for goods or services to be delivered in the future. This is more about revenue already received but not yet earned.
	3. Forecasted Revenue – Projected or expected revenue based on models, historical data, or business plans.
	4. Revenue Pipeline – Often used in sales and business development to describe expected future revenue from deals in progress.
	5. Revenue Projections – Estimates of future revenue, typically used in budgeting or financial planning.
	6. Expected Revenue – A general term for anticipated income in a future period.

	
	
	
DESCRIPTORS & MECHANISMS
	Favorable; Unfavorable || Uptick; Downtick ---- Number show an uptick
		Levers -- Ascent, Descent, Lift 
	Shortage; Overage || Shortfall; Overfall || Inflated; Depressed. 
	Engaged | Disengaged
	Challenged | Recovered -- no longer challenged
	
	This was the entry point; This was the day of submission; 
	Here is the exit point
	Upstream | Downstream
	Trickle Down
	Later Stage

	Flatten the line. Flatten the curve. 


	Suppression List -- explicitly exclude -- rule is NEVER to these receivers
	Exception List -- rule is exclude, allow exception to pass -- receivers allowed to bypass rule
	Apply policy
	Enforce policy
	Validation queries, XCHK Queries

	Situational Clarity
	Indexing
	Scoping
	Defining Parameters
	Defining Thresholds
	Feasibility Studies
	Viability Checks

	Naming conventions
	Standards
	SOP -- Standard operating procedures
	SOR -- System of record


DATASPECIFIC

	Persist this to disk; it's expensive to recalc every time; runs slow
	SUMX -- SumProduct 
	Can't sum an average. Have to split into separate components (numerator / denominator) then divide
		Especially segmented averages
	
	How do we use them at the same time
	How we source where that comes from
	Are they fringe cases (outliers)
	Backfill the data
	This is a proxy
	Live query -- cached or replicated
	One-time load




