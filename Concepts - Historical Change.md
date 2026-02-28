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