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


# Output All View Create Scripts
```sql

/*
T-SQL script to generate CREATE VIEW statements for all user-defined views.
Uses OBJECT_DEFINITION to retrieve the original SQL used to create the view.
*/
SET NOCOUNT ON;
DECLARE @SchemaName NVARCHAR(128)
DECLARE @ViewName NVARCHAR(128)
DECLARE @Definition NVARCHAR(MAX)
DECLARE view_cursor CURSOR FOR
SELECT 
    s.name AS SchemaName,
    v.name AS ViewName,
    OBJECT_DEFINITION(v.object_id) AS ViewDefinition
FROM sys.views v
INNER JOIN sys.schemas s ON v.schema_id = s.schema_id
WHERE v.is_ms_shipped = 0 -- Exclude system views
ORDER BY v.create_date ASC -- Order by creation date (oldest first)
OPEN view_cursor
FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @Definition
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '----------------------------------------------------------------------------'
    PRINT '-- View: [' + @SchemaName + '].[' + @ViewName + ']'
    PRINT '----------------------------------------------------------------------------'
    
    -- Basic error handling for views that might be encrypted or inaccessible
    IF @Definition IS NULL
    BEGIN
        PRINT '-- ERROR: Could not retrieve definition for [' + @SchemaName + '].[' + @ViewName + ']'
        PRINT '-- (It might be encrypted or you lack permission)'
    END
    ELSE
    BEGIN
        -- Optional: Add an idempotent check before the CREATE VIEW
        -- PRINT 'IF OBJECT_ID(''[' + @SchemaName + '].[' + @ViewName + ']'', ''V'') IS NOT NULL'
        -- PRINT '    DROP VIEW [' + @SchemaName + '].[' + @ViewName + '];'
        -- PRINT 'GO'
        PRINT @Definition
        PRINT 'GO'
    END
    PRINT '' -- Empty line for readability
    FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @Definition
END
CLOSE view_cursor
DEALLOCATE view_cursor
```
