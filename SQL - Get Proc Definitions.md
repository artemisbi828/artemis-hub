```sql
-- view procedure text
select
       '[' + s2.[name] + '].[' + [o].[name] + ']' objectname,
       [s].[text]
from sys.[syscomments] as [s]
    inner join sys.[objects] as [o]
        on [o].[object_id] = [s].[id]
    inner join sys.[schemas] as [s2]
        on s2.[schema_id] = o.[schema_id]
where [s].[text] like '%warnings%'
order by 1;

----
-- procedure text is in sys.sql_modules.definition and sys.syscomments (use this one)
	-- sys.sql_modules.definition is a view but there is a cap -- nvarchar 
-- object_definition(o.id) -- obscure table 
```

