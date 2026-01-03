```sql
select db_name() as DB;

/* #1. define schema + object name */
declare @schema nvarchar(64) = N'map'; -- N'referral';
declare @string nvarchar(125) = null; -- 'swell'
set @string = null; -- '%' + @string + '%'

select
    '[' + db_name() + '].[' + C.name + '].[' + A.name + ']' ObjectName,
    *
from sys.all_objects as A
    left join sys.schemas as C
        on A.schema_id = C.schema_id
where 1 = 1
  and (C.name = @schema or @schema is null)
  and C.name not in ('sys')
  /* not constraints */
  and A.type_desc not in ('DEFAULT_CONSTRAINT', 'FOREIGN_KEY_CONSTRAINT', 'PRIMARY_KEY_CONSTRAINT', 'UNIQUE_CONSTRAINT')
  /* not ?servicequeues?, functions or procs */
  and A.type_desc not in ('SERVICE_QUEUE', 'SQL_SCALAR_FUNCTION', 'SQL_STORED_PROCEDURE')
  and (A.name like @string or @string is null)
  and left(A.name, 1) <> '_'
order by A.type_desc,
         A.modify_date desc; -- schema
return;
```

