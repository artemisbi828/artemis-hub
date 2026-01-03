#quick-paste-merge-later 

```sql
declare @startdate date = '2025-02-17';
declare @enddate date = '2025-06-01';
--
with seq (n)
as (
   --
   select 0
   union all
   select n + 1 from seq where n < datediff(day, @startdate, @enddate)
--
)
select * from [seq]
option (maxrecursion 0);
```

```sql
declare @startdate datetime2 = '2025-02-17 08:30';
declare @enddate datetime2 = '2025-06-01';
--
with seq (n, datekey)
as (
   --
   select 0, @startdate
   union all
   select
       n + 1,
       dateadd(minute, 30, datekey)
   --
   from seq
   where n < datediff(day, @startdate, @enddate)
--
)
select * from [seq]
option (maxrecursion 0);
```