# Measure Specific
- Create a @py column

```dax
NPE Total PY = 
VAR __CurrentDates =
    CALCULATETABLE( VALUES( D_Dates[DateKey] ) )
VAR __ShiftedDates =
    SELECTCOLUMNS(
        ADDCOLUMNS(__CurrentDates, "@py", EDATE([DateKey], -12)),
        "DateKey", [@py]
    )
RETURN
CALCULATE(
    [NPE Total CY],
    TREATAS(__ShiftedDates, D_Dates[DateKey])
)
```

- EDATE 
	- months.qty before or after given start date. 
	- tries for SAME DAY (eomonth = last day of month). 
	- invalid handling = auto returns last day of month EDATE(2024-01-31,1) --> 2024-02-29 (leap year). 


have to do outer apply (select top 1 order by DateKey) → SQLSVR will dupe on LeapYear dates
PreviousYear (PY) is more semantically correct than LastYear (LY) → more dynamic

you can also use clean join
```sql
where py.YYYY = ty.YYYY - 1
  and py.Month = ty.Month
  and py.DayOfMonth = ty.DayOfMonth
```


# Calculation Groups
Use explicit measures
Can make SELECTEDMEASURES a parameter