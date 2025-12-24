move these into project dir

```sql
-- list of users manually added and selected from OPX, RCM (Fran 111950), FPA (Tyler 119118), ACC (Zak)

select
    isnull(e.CommonName, e.FirstName) + ' ' + e.LastName as Name,
    e.Email,
    e.JobTitle
from Lake.sd.Employees as e
where 1 = 1
  and e.EmployeeCode in (115100, 115712, 111762, 116917, 111743, 111025, 111356, 111900, 111950, 113187, 119316, 114904, 115964, 119118, 119277, 119278, 119279, 119288, 119289, 119408, 119586,
                         119734, 120501, 120620, 120791, 120799, 120800, 121037, 121242, 121436, 121438, 121482, 123042, 123044, 123045, 333759, 333789, 116744
      )
  and e.JobTitle <> 'Contractor';
```

### Form Building Lessons
- card layouts -- 1 or 2 columns
- sub-categories to be saved into [request_type_detail] or separate field
- branching
- show inside card or follow up selection