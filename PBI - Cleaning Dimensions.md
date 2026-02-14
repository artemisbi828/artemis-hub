Use views to do left joins to see if there are issues. Most common culprits:
- **Facts** -- use `D_Dates` and `D_Locations` as predicates in building the 
- **Row Level Security** -- offices assigned that are not clinics or active locations