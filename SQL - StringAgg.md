```sql
string_agg(cast([MyColumn] as varchar(max)), '.') within group(order by [MyColumn] asc) loginrightHash
```