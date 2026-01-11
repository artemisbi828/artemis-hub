have to do outer apply (select top 1 order by DateKey) → SQLSVR will dupe on LeapYear dates
PreviousYear (PY) is more semantically correct than LastYear (LY) → more dynamic

you can also use clean join
```sql
where py.YYYY = ty.YYYY - 1
  and py.Month = ty.Month
  and py.DayOfMonth = ty.DayOfMonth
```