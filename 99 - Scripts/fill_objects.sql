-- ================================================================================
-- CROSS-DATABASE METADATA SCAN WITH PROGRESS TRACKING & LOGGING
-- Features:
-- 1. Cross-database metadata collection
-- 2. Merges into central metadata repository (Playground database)
-- 3. Non-blocking reads with NOLOCK
-- 4. Progress logging
-- ================================================================================

SET NOCOUNT ON;
SET XACT_ABORT OFF;

-- ================================================================================
-- CONFIGURATION: Set the source and target databases
-- ================================================================================
DECLARE @SourceDatabase SYSNAME = DB_NAME(); -- Database to scan (current database)
DECLARE @TargetDatabase SYSNAME = 'Playground'; -- Database where metadata tables exist

PRINT '================================================================================';
PRINT 'CROSS-DATABASE METADATA SCAN';
PRINT 'Source Database: ' + @SourceDatabase;
PRINT 'Target Database: ' + @TargetDatabase;
PRINT '================================================================================';
PRINT '';

-- ================================================================================
-- MAIN EXECUTION SCRIPT
-- ================================================================================
DECLARE @LoadSource SYSNAME = SUSER_SNAME();
DECLARE @LoadDateTimeUtc DATETIME2(3) = SYSUTCDATETIME();
DECLARE @LoadBatchId UNIQUEIDENTIFIER = NEWID();
DECLARE @BatchStartTime DATETIME2(3) = SYSDATETIME();
DECLARE @SQL NVARCHAR(MAX);
DECLARE @ParamDef NVARCHAR(MAX);

-- Progress tracking variables
DECLARE @TotalTables INT = 0;
DECLARE @TotalColumns INT = 0;
DECLARE @StatusMsg NVARCHAR(500);

PRINT 'METADATA SCAN STARTED: ' + CONVERT(VARCHAR(30), @BatchStartTime, 120);
PRINT 'Batch ID: ' + CAST(@LoadBatchId AS NVARCHAR(50));
PRINT '';

-- ================================================================================
-- STEP 1: POPULATE objects_tables_views from source database
-- ================================================================================
PRINT '--- STEP 1: Loading Tables and Views from ' + @SourceDatabase + ' ---';

-- Build dynamic SQL to query source database
SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

;WITH src AS (
    -- All tables (exclude _obsolete)
    SELECT 
        ''' + @SourceDatabase + N''' AS DatabaseName,
        s.name AS SchemaName, 
        t.name AS TableViewName,
        ''Table'' AS TableViewType
    FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.tables t WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) ON t.schema_id = s.schema_id
    WHERE t.name NOT LIKE ''%\_obsolete%'' ESCAPE ''\''
    
    UNION ALL
    
    -- All views (exclude _obsolete)
    SELECT 
        ''' + @SourceDatabase + N''' AS DatabaseName,
        s.name AS SchemaName, 
        v.name AS TableViewName,
        ''View'' AS TableViewType
    FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.views v WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) ON v.schema_id = s.schema_id
    WHERE v.name NOT LIKE ''%\_obsolete%'' ESCAPE ''\''
)
MERGE INTO docm.objects_tables_views WITH (ROWLOCK) AS tgt
USING src ON src.DatabaseName = tgt.DatabaseName 
    AND src.SchemaName = tgt.SchemaName 
    AND src.TableViewName = tgt.TableViewName
WHEN NOT MATCHED THEN 
    INSERT (DatabaseName, SchemaName, TableViewName, TableViewType, LoadDateTimeUtc, LoadSource)
    VALUES (src.DatabaseName, src.SchemaName, src.TableViewName, src.TableViewType, @LoadDateTimeUtc, @LoadSource)
WHEN MATCHED THEN
    UPDATE SET TableViewType = src.TableViewType, LoadDateTimeUtc = @LoadDateTimeUtc, EndDateTimeUtc = NULL
WHEN NOT MATCHED BY SOURCE AND tgt.DatabaseName = ''' + @SourceDatabase + N''' THEN 
    UPDATE SET EndDateTimeUtc = @LoadDateTimeUtc;

SELECT @TablesLoaded = @@ROWCOUNT;';

SET @ParamDef = N'@LoadDateTimeUtc DATETIME2(3), @LoadSource SYSNAME, @TablesLoaded INT OUTPUT';
DECLARE @TablesLoaded INT;

EXEC sp_executesql @SQL, @ParamDef, 
    @LoadDateTimeUtc = @LoadDateTimeUtc, 
    @LoadSource = @LoadSource,
    @TablesLoaded = @TablesLoaded OUTPUT;

PRINT 'Loaded ' + CAST(@TablesLoaded AS VARCHAR(10)) + ' tables/views';
PRINT '';

-- ================================================================================
-- STEP 2: POPULATE objects_tables_views_columns from source database
-- ================================================================================
PRINT '--- STEP 2: Loading Columns from ' + @SourceDatabase + ' ---';

SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

;WITH src_columns AS (
    SELECT 
        tv.tvKey,
        tv.DatabaseName,
        tv.SchemaName,
        tv.TableViewName,
        c.column_id AS SortOrder,
        c.name AS ColumnName,
        TYPE_NAME(c.user_type_id) AS DataType,
        c.max_length AS MaxLength,
        c.is_nullable AS IsNullable,
        MAX(CASE WHEN pk.column_id IS NOT NULL THEN 1 ELSE 0 END) AS IsPrimaryKey,
        MAX(CASE WHEN fk.parent_column_id IS NOT NULL THEN 1 ELSE 0 END) AS IsForeignKey,
        c.is_identity AS IsIdentity,
        c.is_computed AS IsComputed,
        MAX(dc.definition) AS DefaultValue
    FROM docm.objects_tables_views tv WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) 
        ON tv.SchemaName = s.name
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.objects o WITH (NOLOCK) 
        ON s.schema_id = o.schema_id AND tv.TableViewName = o.name
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.columns c WITH (NOLOCK) 
        ON o.object_id = c.object_id
    LEFT JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.index_columns pk WITH (NOLOCK) 
        ON pk.object_id = c.object_id 
        AND pk.column_id = c.column_id
        AND pk.index_id IN (
            SELECT index_id 
            FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.indexes WITH (NOLOCK) 
            WHERE object_id = o.object_id AND is_primary_key = 1
        )
    LEFT JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.foreign_key_columns fk WITH (NOLOCK) 
        ON fk.parent_object_id = c.object_id 
        AND fk.parent_column_id = c.column_id
    LEFT JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.default_constraints dc WITH (NOLOCK) 
        ON dc.parent_object_id = c.object_id 
        AND dc.parent_column_id = c.column_id
    WHERE tv.DatabaseName = ''' + @SourceDatabase + N'''
      AND tv.EndDateTimeUtc IS NULL
    GROUP BY tv.tvKey, tv.DatabaseName, tv.SchemaName, tv.TableViewName, 
             c.column_id, c.name, c.user_type_id, c.max_length, c.is_nullable,
             c.is_identity, c.is_computed
)
MERGE INTO docm.objects_tables_views_columns WITH (ROWLOCK) AS tgt
USING src_columns AS src
ON src.tvKey = tgt.tvKey AND src.ColumnName = tgt.ColumnName
WHEN NOT MATCHED THEN
    INSERT (tvKey, SortOrder, ColumnName, DataType, MaxLength, IsNullable, IsPrimaryKey, IsForeignKey, 
            IsIdentity, IsComputed, DefaultValue, LoadDateTimeUtc, LoadSource)
    VALUES (src.tvKey, src.SortOrder, src.ColumnName, src.DataType, src.MaxLength, src.IsNullable, 
            src.IsPrimaryKey, src.IsForeignKey, src.IsIdentity, src.IsComputed, src.DefaultValue, 
            @LoadDateTimeUtc, @LoadSource)
WHEN MATCHED THEN
    UPDATE SET SortOrder = src.SortOrder, DataType = src.DataType, MaxLength = src.MaxLength, 
               IsNullable = src.IsNullable, IsPrimaryKey = src.IsPrimaryKey, IsForeignKey = src.IsForeignKey, 
               IsIdentity = src.IsIdentity, IsComputed = src.IsComputed, DefaultValue = src.DefaultValue,
               LoadDateTimeUtc = @LoadDateTimeUtc, EndDateTimeUtc = NULL;

SELECT @ColumnsLoaded = @@ROWCOUNT;';

SET @ParamDef = N'@LoadDateTimeUtc DATETIME2(3), @LoadSource SYSNAME, @ColumnsLoaded INT OUTPUT';
DECLARE @ColumnsLoaded INT;

EXEC sp_executesql @SQL, @ParamDef, 
    @LoadDateTimeUtc = @LoadDateTimeUtc, 
    @LoadSource = @LoadSource,
    @ColumnsLoaded = @ColumnsLoaded OUTPUT;

PRINT 'Loaded ' + CAST(@ColumnsLoaded AS VARCHAR(10)) + ' columns';
PRINT '';

-- ================================================================================
-- STEP 2.5: UPDATE TotalRows FOR TABLES
-- ================================================================================
PRINT '--- STEP 2.5: Loading Row Counts ---';

SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

UPDATE tv
SET TotalRows = (
    SELECT SUM(ps.row_count)
    FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.dm_db_partition_stats ps WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.objects o WITH (NOLOCK) ON ps.object_id = o.object_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) ON o.schema_id = s.schema_id
    WHERE s.name = tv.SchemaName
      AND o.name = tv.TableViewName
      AND ps.index_id IN (0, 1)
)
FROM docm.objects_tables_views tv
WHERE tv.DatabaseName = ''' + @SourceDatabase + N'''
  AND tv.TableViewType = ''Table''
  AND tv.EndDateTimeUtc IS NULL;

SELECT @RowCountsUpdated = @@ROWCOUNT;';

SET @ParamDef = N'@RowCountsUpdated INT OUTPUT';
DECLARE @RowCountsUpdated INT;

EXEC sp_executesql @SQL, @ParamDef, @RowCountsUpdated = @RowCountsUpdated OUTPUT;

PRINT 'Updated row counts for ' + CAST(@RowCountsUpdated AS VARCHAR(10)) + ' tables';
PRINT '';

-- ================================================================================
-- STEP 2.6: POPULATE objects_foreign_keys and objects_primary_keys
-- ================================================================================
PRINT '--- STEP 2.6: Loading Foreign Keys and Primary Keys ---';

-- Foreign Keys
SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

;WITH fk_data AS (
    SELECT 
        ''' + @SourceDatabase + N''' AS DatabaseName,
        fk.name AS ForeignKeyName,
        ps.name AS ParentSchema,
        pt.name AS ParentTable,
        pc.name AS ParentColumn,
        rs.name AS ReferencedSchema,
        rt.name AS ReferencedTable,
        rc.name AS ReferencedColumn
    FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.foreign_keys fk WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.foreign_key_columns fkc WITH (NOLOCK) 
        ON fk.object_id = fkc.constraint_object_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.tables pt WITH (NOLOCK) 
        ON fkc.parent_object_id = pt.object_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas ps WITH (NOLOCK) 
        ON pt.schema_id = ps.schema_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.columns pc WITH (NOLOCK) 
        ON fkc.parent_object_id = pc.object_id AND fkc.parent_column_id = pc.column_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.tables rt WITH (NOLOCK) 
        ON fkc.referenced_object_id = rt.object_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas rs WITH (NOLOCK) 
        ON rt.schema_id = rs.schema_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.columns rc WITH (NOLOCK) 
        ON fkc.referenced_object_id = rc.object_id AND fkc.referenced_column_id = rc.column_id
)
MERGE INTO docm.objects_foreign_keys WITH (ROWLOCK) AS tgt
USING fk_data AS src 
ON src.DatabaseName = tgt.DatabaseName
    AND src.ForeignKeyName = tgt.ForeignKeyName 
    AND src.ParentSchema = tgt.ParentSchema 
    AND src.ParentTable = tgt.ParentTable 
    AND src.ParentColumn = tgt.ParentColumn
WHEN NOT MATCHED THEN
    INSERT (DatabaseName, ForeignKeyName, ParentSchema, ParentTable, ParentColumn, 
            ReferencedSchema, ReferencedTable, ReferencedColumn, LoadDateTimeUtc, LoadSource)
    VALUES (src.DatabaseName, src.ForeignKeyName, src.ParentSchema, src.ParentTable, src.ParentColumn, 
            src.ReferencedSchema, src.ReferencedTable, src.ReferencedColumn, @LoadDateTimeUtc, @LoadSource)
WHEN NOT MATCHED BY SOURCE AND tgt.DatabaseName = ''' + @SourceDatabase + N''' THEN
    UPDATE SET EndDateTimeUtc = @LoadDateTimeUtc;

SELECT @FkCount = @@ROWCOUNT;';

SET @ParamDef = N'@LoadDateTimeUtc DATETIME2(3), @LoadSource SYSNAME, @FkCount INT OUTPUT';
DECLARE @FkCount INT;

EXEC sp_executesql @SQL, @ParamDef, 
    @LoadDateTimeUtc = @LoadDateTimeUtc, 
    @LoadSource = @LoadSource,
    @FkCount = @FkCount OUTPUT;

PRINT 'Loaded ' + CAST(@FkCount AS VARCHAR(10)) + ' foreign key relationships';

-- Primary Keys
SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

;WITH pk_data AS (
    SELECT 
        ''' + @SourceDatabase + N''' AS DatabaseName,
        kc.name AS PrimaryKeyName,
        s.name AS SchemaName,
        t.name AS TableName,
        c.name AS ColumnName,
        ic.key_ordinal AS KeyOrdinal
    FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.indexes i WITH (NOLOCK)
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.index_columns ic WITH (NOLOCK) 
        ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.tables t WITH (NOLOCK) 
        ON i.object_id = t.object_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) 
        ON t.schema_id = s.schema_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.columns c WITH (NOLOCK) 
        ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.key_constraints kc WITH (NOLOCK) 
        ON i.object_id = kc.parent_object_id AND i.index_id = kc.unique_index_id
    WHERE i.is_primary_key = 1
)
MERGE INTO docm.objects_primary_keys WITH (ROWLOCK) AS tgt
USING pk_data AS src 
ON src.DatabaseName = tgt.DatabaseName
    AND src.PrimaryKeyName = tgt.PrimaryKeyName 
    AND src.SchemaName = tgt.SchemaName 
    AND src.TableName = tgt.TableName 
    AND src.ColumnName = tgt.ColumnName
WHEN NOT MATCHED THEN
    INSERT (DatabaseName, PrimaryKeyName, SchemaName, TableName, ColumnName, KeyOrdinal, LoadDateTimeUtc, LoadSource)
    VALUES (src.DatabaseName, src.PrimaryKeyName, src.SchemaName, src.TableName, src.ColumnName, 
            src.KeyOrdinal, @LoadDateTimeUtc, @LoadSource)
WHEN NOT MATCHED BY SOURCE AND tgt.DatabaseName = ''' + @SourceDatabase + N''' THEN
    UPDATE SET EndDateTimeUtc = @LoadDateTimeUtc;

SELECT @PkCount = @@ROWCOUNT;';

SET @ParamDef = N'@LoadDateTimeUtc DATETIME2(3), @LoadSource SYSNAME, @PkCount INT OUTPUT';
DECLARE @PkCount INT;

EXEC sp_executesql @SQL, @ParamDef, 
    @LoadDateTimeUtc = @LoadDateTimeUtc, 
    @LoadSource = @LoadSource,
    @PkCount = @PkCount OUTPUT;

PRINT 'Loaded ' + CAST(@PkCount AS VARCHAR(10)) + ' primary key columns';
PRINT '';

-- ================================================================================
-- STEP 3: POPULATE objects_extended_properties
-- ================================================================================
PRINT '--- STEP 3: Loading Extended Properties ---';

SET @SQL = N'
USE ' + QUOTENAME(@TargetDatabase) + N';

;WITH extended_props AS (
   -- Table-level extended properties
   SELECT s.name AS SchemaName, o.name AS TableName, NULL AS ColumnName,
          CAST(ep.value AS NVARCHAR(500)) AS Description
   FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.extended_properties ep WITH (NOLOCK)
   INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.objects o WITH (NOLOCK) ON ep.major_id = o.object_id
   INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) ON o.schema_id = s.schema_id
   WHERE ep.minor_id = 0 AND ep.name = ''MS_Description'' AND o.type IN (''U'', ''V'')

   UNION ALL

   -- Column-level extended properties
   SELECT s.name AS SchemaName, o.name AS TableName, c.name AS ColumnName,
          CAST(ep.value AS NVARCHAR(500)) AS Description
   FROM ' + QUOTENAME(@SourceDatabase) + N'.sys.extended_properties ep WITH (NOLOCK)
   INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.objects o WITH (NOLOCK) ON ep.major_id = o.object_id
   INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.schemas s WITH (NOLOCK) ON o.schema_id = s.schema_id
   INNER JOIN ' + QUOTENAME(@SourceDatabase) + N'.sys.columns c WITH (NOLOCK) 
        ON ep.major_id = c.object_id AND ep.minor_id = c.column_id
   WHERE ep.minor_id > 0 AND ep.name = ''MS_Description'' AND o.type IN (''U'', ''V'')
),
cte_src AS (
    SELECT 
        tavc.tvcKey,
        ''' + @SourceDatabase + N''' AS DatabaseName,
        src.SchemaName, 
        src.TableName, 
        src.ColumnName, 
        src.Description,
        @LoadDateTimeUtc AS LoadDateTimeUtc, 
        @LoadSource AS LoadSource, 
        0 AS IsCurrent
    FROM extended_props src
    INNER JOIN docm.objects_tables_views tav WITH (NOLOCK)
        ON tav.DatabaseName = ''' + @SourceDatabase + N'''
       AND tav.SchemaName = src.SchemaName
       AND tav.TableViewName = src.TableName
    LEFT JOIN docm.objects_tables_views_columns tavc WITH (NOLOCK)
        ON tavc.tvKey = tav.tvKey
       AND tavc.ColumnName = src.ColumnName
       AND tavc.EndDateTimeUtc IS NULL
    LEFT JOIN docm.objects_extended_properties tgt WITH (NOLOCK)
        ON tgt.DatabaseName = ''' + @SourceDatabase + N'''
       AND tgt.SchemaName = src.SchemaName
       AND tgt.TableName = src.TableName
       AND ISNULL(tgt.ColumnName, '''') = ISNULL(src.ColumnName, '''')
    WHERE tgt.SchemaName IS NULL
      AND (src.ColumnName IS NULL OR tavc.tvcKey IS NOT NULL)
)
INSERT INTO docm.objects_extended_properties 
    (tvcKey, DatabaseName, SchemaName, TableName, ColumnName, Description, LoadDateTimeUtc, LoadSource, IsCurrent)
SELECT tvcKey, DatabaseName, SchemaName, TableName, ColumnName, Description, LoadDateTimeUtc, LoadSource, IsCurrent 
FROM cte_src;

SELECT @ExtPropCount = @@ROWCOUNT;';

SET @ParamDef = N'@LoadDateTimeUtc DATETIME2(3), @LoadSource SYSNAME, @ExtPropCount INT OUTPUT';
DECLARE @ExtPropCount INT;

EXEC sp_executesql @SQL, @ParamDef, 
    @LoadDateTimeUtc = @LoadDateTimeUtc, 
    @LoadSource = @LoadSource,
    @ExtPropCount = @ExtPropCount OUTPUT;

PRINT 'Loaded ' + CAST(@ExtPropCount AS VARCHAR(10)) + ' extended properties';
PRINT '';

-- ================================================================================
-- FINAL SUMMARY
-- ================================================================================
DECLARE @BatchEnd DATETIME2(3) = SYSDATETIME();
DECLARE @TotalDuration DECIMAL(10,2) = DATEDIFF(MILLISECOND, @BatchStartTime, @BatchEnd) / 1000.0;
DECLARE @TotalMin INT = @TotalDuration / 60;
DECLARE @TotalSec INT = @TotalDuration % 60;

PRINT '================================================================================';
PRINT 'METADATA SCAN COMPLETED: ' + CONVERT(VARCHAR(30), @BatchEnd, 120);
PRINT 'Total Duration: ' + CAST(@TotalMin AS VARCHAR(10)) + 'm ' + CAST(@TotalSec AS VARCHAR(10)) + 's';
PRINT '================================================================================';
PRINT '';
PRINT 'Summary:';
PRINT '  Tables/Views: ' + CAST(@TablesLoaded AS VARCHAR(10));
PRINT '  Columns: ' + CAST(@ColumnsLoaded AS VARCHAR(10));
PRINT '  Foreign Keys: ' + CAST(@FkCount AS VARCHAR(10));
PRINT '  Primary Keys: ' + CAST(@PkCount AS VARCHAR(10));
PRINT '  Extended Properties: ' + CAST(@ExtPropCount AS VARCHAR(10));
