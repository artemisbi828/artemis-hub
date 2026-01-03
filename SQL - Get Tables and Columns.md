```sql
declare @schema nvarchar(64) = N'bi';
declare @table nvarchar(64) = N'persons';
declare @objectname nvarchar(64) = null; -- N'LegacyPMSMetrics_Load';
 
set @table = N'%' + @table + N'%';
 
select
    '[' + db_name() + '].[' + C.name + '].[' + A.name + '].[' + B.name + ']' ObjectMapName,
    A.object_id as ObjectId,
    B.column_id,
    C.name as schemaName,
    A.name as ObjectName,
    B.name as columnName,
    E.DATA_TYPE as datatype,
    B.is_nullable,
    A.type_desc
--[A].[type], -- U = user_table, P = sql_stored_procedure
from sys.all_objects as A
    left join sys.all_columns as B
        on A.object_id = B.object_id
    left join sys.schemas as C
        on A.schema_id = C.schema_id
    left join sys.all_objects as D
        on A.parent_object_id = D.object_id
    left join INFORMATION_SCHEMA.COLUMNS as E
        on C.name = E.TABLE_SCHEMA
       and A.name = E.TABLE_NAME
       and B.name = E.COLUMN_NAME
where 1 = 1
  and A.name not like '%_History' -- not history tbls
  and A.type_desc not in ('SQL_STORED_PROCEDURE',                                                  -- not procs
                          'FOREIGN_KEY_CONSTRAINT', 'DEFAULT_CONSTRAINT', 'PRIMARY_KEY_CONSTRAINT' -- not constraints
      )
  -- ad hoc
  and C.name = @schema -- schema
  and A.name like @table
  and (A.name = @objectname or @objectname is null);
```