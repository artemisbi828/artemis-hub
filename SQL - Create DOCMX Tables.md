
```
# toggle through
CentralC9;
Dayforce
EDW
ETL
Lake
OrthoFi
Playground
SnowFlake
```
# Update Tables
```sql
-- #1: toggle through all the databases here
use SnowFlake; 

;
with cte1
as (select
        row_number() over (order by s.name, o.name) sr,
        o.object_id,
        db_name() as db_name,
        s.name as schema_name,
        o.name as table_name,
        o.type
    from sys.objects as o
        join sys.schemas as s
            on o.schema_id = s.schema_id
    where 1 = 1
      and s.name not in ('sys')
      and left(o.name, 4) <> '_obs'
      and type = 'U')

-- #2: update statement
update
    t2
set
    t2.object_id = t.object_id
from cte1 t
    inner join Playground.docm.tables as t2
        on t2.DatabaseName = t.db_name
       and t2.SchemaName = t.schema_name
       and t2.TableName = t.table_name;

```

# Update Columns
```sql
-- #1: review results
-- #2: toggle through to go through database
-- use 

declare @loaddatetimeutc datetime2 = sysutcdatetime();
declare @loadsource nvarchar(128) = suser_name();
declare @loadedby nvarchar(128) = suser_name();

with cte1
as (select
        c.name as column_name,
        o.object_id,
        c.column_id,
        s.name as schema_name,
        o.name as table_name
    from sys.columns c
        inner join sys.objects as o
            on c.object_id = o.object_id
        join sys.schemas as s
            on o.schema_id = s.schema_id
    where 1 = 1
      and s.name not in ('sys')
      and s.name not in ('sys')
      and left(o.name, 4) <> '_obs'
      and type = 'U')
-- #3: toggle on for insert
--insert into Playground.docm.columns (object_id, column_id, column_name, ordinal, data_type, max_length, is_nullable, loaddatetimeutc, loadsource, loadedby)
select
    t.object_id,
    c.column_id,
    c.column_name,
    c2.ORDINAL_POSITION as ordinal,
    c2.DATA_TYPE as data_type,
    c2.CHARACTER_MAXIMUM_LENGTH as max_length,
    case when c2.IS_NULLABLE = 'NO' then 1 else 0 end as is_nullable,
    @loaddatetimeutc,
    @loadsource,
    @loadedby
from cte1 c
    inner join Playground.docm.tables t
        on t.object_id = c.object_id
    inner join [INFORMATION_SCHEMA].[COLUMNS] as c2
        on c2.TABLE_CATALOG = t.DatabaseName
       and c2.TABLE_SCHEMA = t.SchemaName
       and c2.TABLE_NAME = t.TableName
       and c2.COLUMN_NAME = c.column_name;

```