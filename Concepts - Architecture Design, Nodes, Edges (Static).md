# Atomicity
single responsibility principle
singularity of purpose

# Orthogonal vs Hierarchal
AHA: Avoid Hasty Abstractions.
WET vs DRY: 

Orthonogal vs Hierarchal: different dimensions vs parent-child subsets (drill-down vs roll-up)
- Exams is a Grouping Dimension
- Consults = Attribute. NPE is a Sub-Attribute of Consults.

Umbrella Term = {Parent, Superset}
Intercalation: Inserting an interlayer (between 2 existing layers)

# 1 Degree of Separation
1-deg of separation, d1_from_DavidNolan
Direct Report
lvl1


# Change
Slowly Changing Dimension := SCDType2, D2 Tables. Use columns below for indexing/fast partition.
- IsCurrent = 1
- EndDate (is not null)

Mutable Historical Data
- Uncontrolled, untracked
- Dynamic (vs opposite - {Static, Locked})
- {Retroactively Updateable, Editable History}
- Soft-Closed Data (vs !Hard-Closed)

• sequential-file-versioning
	This is called "auto-incrementing filename collision resolution" or "sequential file versioning". Terms you can use:
	"Increment if exists"
	"Auto-versioning"
	"Collision-free naming"
	"Sequential suffix pattern"