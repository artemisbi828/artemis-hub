```sql
/* #1 -- define database + schema */
declare @schema nvarchar(64) = N'bi';
set @schema = replace(replace(@schema, '[', ''), ']', '');
-- 
 
 
select
    [C].[name] + '.' + [A].[name] as [ObjectName]
from [sys].[all_objects] as [A]
    left join [sys].[schemas] as [C]
        on [A].[schema_id] = [C].[schema_id]
where 1 = 1
  and C.name not in ('sys', 'INFORMATION_SCHEMA') -- exclusion
  and ([C].[name] = @schema or @schema is null)
  and [A].[type] = 'V' -- views only
order by 1;
```
