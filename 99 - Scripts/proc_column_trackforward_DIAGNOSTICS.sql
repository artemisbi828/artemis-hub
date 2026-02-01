-- =============================================
-- DIAGNOSTIC HARNESS for proc_column_trackforward
-- Testing prKey = 101
-- =============================================

set nocount on;

declare @prkey int = 101;
declare @DatabaseName nvarchar(128) = 'EDW';
declare @SchemaName nvarchar(128) = 'bi';
declare @ProcedureName nvarchar(128) = 'usp_OfficeDayStats_Swell_Net_Promoter_Score';

print '=============================================';
print 'CHECKPOINT 1: Testing Procedure Retrieval';
print '=============================================';

-- Get the procedure definition
declare @ProcedureSQL nvarchar(max);
declare @SQL nvarchar(max);

set @SQL = N'
SELECT @ProcedureSQL_OUT = m.definition
FROM ' + quotename(@DatabaseName) + N'.sys.sql_modules AS m
INNER JOIN ' + quotename(@DatabaseName) + N'.sys.objects AS o ON m.object_id = o.object_id
INNER JOIN ' + quotename(@DatabaseName) + N'.sys.schemas AS s ON o.schema_id = s.schema_id
WHERE s.name = @SchemaName_IN
  AND o.name = @ProcedureName_IN
  AND o.type = ''P'';';

exec sp_executesql
    @SQL,
    N'@ProcedureSQL_OUT NVARCHAR(MAX) OUTPUT, @SchemaName_IN NVARCHAR(128), @ProcedureName_IN NVARCHAR(128)',
    @ProcedureSQL_OUT = @ProcedureSQL output,
    @SchemaName_IN = @SchemaName,
    @ProcedureName_IN = @ProcedureName;

if @ProcedureSQL is null begin
    print '❌ FAILED: Procedure definition not found';
    return;
end else begin
    print '✓ Procedure definition retrieved: ' + cast(len(@ProcedureSQL) as varchar(10)) + ' characters';
end;

print '';
print '=============================================';
print 'CHECKPOINT 2: Testing MERGE Detection';
print '=============================================';

declare @MergePos int = charindex('MERGE INTO', @ProcedureSQL);
if @MergePos = 0 begin
    print '❌ FAILED: No MERGE statement found';
    return;
end else begin
    print '✓ MERGE found at position: ' + cast(@MergePos as varchar(10));
end;

declare @MergeBlock nvarchar(max) = substring(@ProcedureSQL, @MergePos, len(@ProcedureSQL));
print '  MERGE block length: ' + cast(len(@MergeBlock) as varchar(10)) + ' characters';

print '';
print '=============================================';
print 'CHECKPOINT 3: Testing Normalization';
print '=============================================';

-- Full normalization (matching main script)
declare @NormalizedMerge nvarchar(max) = @MergeBlock;
declare @CleanSQL nvarchar(max) = @MergeBlock;
declare @CommentStart int;
declare @CommentEnd int;
declare @LineStart int;
declare @LineEnd int;
declare @Line nvarchar(max);
declare @Result nvarchar(max);

-- Remove multi-line comments /* ... */
while 1 = 1 begin
    set @CommentStart = charindex('/*', @CleanSQL);
    if @CommentStart = 0 break;
    set @CommentEnd = charindex('*/', @CleanSQL, @CommentStart + 2);
    if @CommentEnd = 0 break;
    set @CleanSQL = substring(@CleanSQL, 1, @CommentStart - 1) + N' ' + substring(@CleanSQL, @CommentEnd + 2, len(@CleanSQL));
end;

-- Remove single-line comments --
set @Result = N'';
set @LineStart = 1;
while @LineStart <= len(@CleanSQL) begin
    set @LineEnd = charindex(char(10), @CleanSQL, @LineStart);
    if @LineEnd = 0 set @LineEnd = len(@CleanSQL) + 1;
    set @Line = substring(@CleanSQL, @LineStart, @LineEnd - @LineStart);
    set @CommentStart = charindex('--', @Line);
    if @CommentStart > 0 set @Line = left(@Line, @CommentStart - 1);
    set @Result = @Result + @Line + char(10);
    set @LineStart = @LineEnd + 1;
end;
set @CleanSQL = @Result;

-- Remove brackets, normalize whitespace
set @CleanSQL = replace(@CleanSQL, '[', '');
set @CleanSQL = replace(@CleanSQL, ']', '');
set @CleanSQL = replace(@CleanSQL, char(13) + char(10), ' ');
set @CleanSQL = replace(@CleanSQL, char(13), ' ');
set @CleanSQL = replace(@CleanSQL, char(10), ' ');
set @CleanSQL = replace(@CleanSQL, char(9), ' ');
while charindex('  ', @CleanSQL) > 0 set @CleanSQL = replace(@CleanSQL, '  ', ' ');

-- Truncate at semicolon, remove OPTION
declare @SemicolonPos int = charindex(';', @CleanSQL);
if @SemicolonPos > 0 set @CleanSQL = substring(@CleanSQL, 1, @SemicolonPos);
set @CleanSQL = replace(@CleanSQL, 'OPTION (RECOMPILE)', '');
set @CleanSQL = replace(@CleanSQL, 'OPTION(RECOMPILE)', '');

-- Convert to uppercase
set @CleanSQL = upper(@CleanSQL);
set @NormalizedMerge = ltrim(rtrim(@CleanSQL));

-- Extract target table (simple pattern)
declare @UsingPos int = charindex(' USING ', @NormalizedMerge);
declare @TargetSection nvarchar(500) = substring(@NormalizedMerge, 12, @UsingPos - 12);
set @TargetSection = ltrim(rtrim(@TargetSection));

declare @AsPosition int = charindex(' AS ', @TargetSection);
declare @TargetTable nvarchar(500);
declare @TargetAlias nvarchar(128);

if @AsPosition > 0 begin
    set @TargetTable = ltrim(rtrim(substring(@TargetSection, 1, @AsPosition)));
    set @TargetAlias = ltrim(rtrim(substring(@TargetSection, @AsPosition + 4, 500)));
end;

print '✓ Target Table: ' + isnull(@TargetTable, 'NULL');
print '✓ Target Alias: ' + isnull(@TargetAlias, 'NULL');

print '';
print '=============================================';
print 'CHECKPOINT 4: Testing Column Extraction';
print '=============================================';

-- Create temp table for columns
if object_id('tempdb..#TestTargetColumns') is not null drop table #TestTargetColumns;
create table #TestTargetColumns (ColumnName nvarchar(128), SourceTable nvarchar(500), StatementType nvarchar(50));

-- Extract UPDATE SET columns
declare @UpdateSetPos int = charindex('UPDATE SET ', @NormalizedMerge);
if @UpdateSetPos > 0 begin
    declare @UpdateSetSection nvarchar(max) = substring(@NormalizedMerge, @UpdateSetPos + 11, len(@NormalizedMerge));
    declare @UpdateSetEnd int = charindex('WHEN ', @UpdateSetSection);
    if @UpdateSetEnd = 0 set @UpdateSetEnd = len(@UpdateSetSection);
    
    set @UpdateSetSection = substring(@UpdateSetSection, 1, @UpdateSetEnd);
    
    print '✓ UPDATE SET section found';
    print '  Section preview (first 200 chars): ' + left(@UpdateSetSection, 200);
    
    -- Parse assignments
    declare @AssignmentList nvarchar(max) = @UpdateSetSection + N',';
    declare @CommaPos int;
    declare @Assignment nvarchar(500);
    declare @EqualsPos int;
    declare @ColumnPart nvarchar(500);
    declare @DotPos int;
    declare @ColumnName nvarchar(128);
    declare @FullMergeTarget nvarchar(500) = @DatabaseName + N'.' + @TargetTable;
    declare @AssignmentNum int = 0;
    
    print '';
    print 'DEBUG: Parsing assignments...';
    
    while charindex(',', @AssignmentList) > 0 begin
        set @AssignmentNum = @AssignmentNum + 1;
        set @CommaPos = charindex(',', @AssignmentList);
        set @Assignment = ltrim(rtrim(substring(@AssignmentList, 1, @CommaPos - 1)));
        
        print '  Assignment #' + cast(@AssignmentNum as varchar(10)) + ': ' + left(@Assignment, 100);
        
        set @EqualsPos = charindex('=', @Assignment);
        if @EqualsPos > 0 begin
            set @ColumnPart = ltrim(rtrim(substring(@Assignment, 1, @EqualsPos - 1)));
            print '    Column part: ' + @ColumnPart;
            print '    Target alias: ' + isnull(@TargetAlias, 'NULL');
            print '    Pattern match test: ' + @TargetAlias + '.%';
            
            if @TargetAlias is not null and @ColumnPart like @TargetAlias + '.%' begin
                set @DotPos = charindex('.', @ColumnPart);
                set @ColumnName = substring(@ColumnPart, @DotPos + 1, 500);
                set @ColumnName = ltrim(rtrim(@ColumnName));
                
                print '    ✓ MATCHED! Column: ' + @ColumnName;
                
                insert into #TestTargetColumns (ColumnName, SourceTable, StatementType)
                values (@ColumnName, @FullMergeTarget, 'MERGE-UPDATE');
            end else begin
                print '    ✗ NO MATCH';
            end;
        end else begin
            print '    ✗ No equals sign found';
        end;
        
        set @AssignmentList = substring(@AssignmentList, @CommaPos + 1, len(@AssignmentList));
    end;
end;

-- Extract INSERT columns
declare @InsertPos int = charindex('THEN INSERT (', @NormalizedMerge);
if @InsertPos > 0 begin
    declare @InsertSection nvarchar(max) = substring(@NormalizedMerge, @InsertPos + 13, len(@NormalizedMerge));
    declare @InsertEnd int = charindex(')', @InsertSection);
    
    if @InsertEnd > 0 begin
        set @InsertSection = substring(@InsertSection, 1, @InsertEnd - 1);
        
        print '✓ INSERT section found';
        print '  Section: ' + @InsertSection;
        
        set @AssignmentList = @InsertSection + N',';
        
        while charindex(',', @AssignmentList) > 0 begin
            set @CommaPos = charindex(',', @AssignmentList);
            set @ColumnName = ltrim(rtrim(substring(@AssignmentList, 1, @CommaPos - 1)));
            
            if charindex('.', @ColumnName) > 0 begin
                set @DotPos = charindex('.', @ColumnName);
                set @ColumnName = substring(@ColumnName, @DotPos + 1, 500);
            end;
            
            set @ColumnName = ltrim(rtrim(@ColumnName));
            
            insert into #TestTargetColumns (ColumnName, SourceTable, StatementType)
            values (@ColumnName, @FullMergeTarget, 'MERGE-INSERT');
            
            set @AssignmentList = substring(@AssignmentList, @CommaPos + 1, len(@AssignmentList));
        end;
    end;
end;

print '';
print 'Columns extracted:';
select * from #TestTargetColumns;

print '';
print '=============================================';
print 'CHECKPOINT 5: Testing Fully Qualified Names';
print '=============================================';

if object_id('tempdb..#TestFQColumns') is not null drop table #TestFQColumns;
create table #TestFQColumns (prKey int, FullyQualifiedName nvarchar(500), StatementType nvarchar(50));

insert into #TestFQColumns (prKey, FullyQualifiedName, StatementType)
select @prkey, tc.SourceTable + '.' + tc.ColumnName, tc.StatementType 
from #TestTargetColumns tc;

print 'Fully qualified column names:';
select 
    FullyQualifiedName,
    parsename(FullyQualifiedName, 4) as [Database],
    parsename(FullyQualifiedName, 3) as [Schema],
    parsename(FullyQualifiedName, 2) as [Table],
    parsename(FullyQualifiedName, 1) as [Column],
    StatementType
from #TestFQColumns;

print '';
print '=============================================';
print 'CHECKPOINT 6: Testing Metadata Table Join';
print '=============================================';

print 'Testing vw_tables lookup:';
select 
    fqc.FullyQualifiedName,
    upper(parsename(fqc.FullyQualifiedName, 4)) as ParsedDatabase,
    upper(parsename(fqc.FullyQualifiedName, 3)) as ParsedSchema,
    upper(parsename(fqc.FullyQualifiedName, 2)) as ParsedTable,
    otv.DatabaseName as MetaDatabase,
    otv.SchemaName as MetaSchema,
    otv.TableName as MetaTable,
    otv.tKey,
    case 
        when upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4)) then '✓'
        else '❌ DB mismatch'
    end as DatabaseMatch,
    case 
        when upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo')) then '✓'
        else '❌ Schema mismatch'
    end as SchemaMatch,
    case 
        when upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2)) then '✓'
        else '❌ Table mismatch'
    end as TableMatch
from #TestFQColumns fqc
    left join Playground.docm.vw_tables as otv
        on upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4))
       and upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo'))
       and upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2));

print '';
print 'Testing vw_columns lookup:';
select 
    fqc.FullyQualifiedName,
    upper(parsename(fqc.FullyQualifiedName, 1)) as ParsedColumn,
    otv.tKey,
    otvc.ColumnName as MetaColumn,
    otvc.cKey,
    case 
        when upper(otvc.ColumnName) = upper(parsename(fqc.FullyQualifiedName, 1)) then '✓'
        else '❌ Column mismatch'
    end as ColumnMatch
from #TestFQColumns fqc
    left join Playground.docm.vw_tables as otv
        on upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4))
       and upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo'))
       and upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2))
    left join Playground.docm.vw_columns as otvc
        on otvc.tKey = otv.tKey
       and upper(otvc.ColumnName) = upper(parsename(fqc.FullyQualifiedName, 1));

print '';
print '=============================================';
print 'CHECKPOINT 7: Testing Full Join Logic';
print '=============================================';

print 'Final join results (what would be inserted into #FinalResults):';
select
    fqc.prKey,
    otvc.cKey,
    fqc.FullyQualifiedName,
    fqc.StatementType
from #TestFQColumns fqc
    inner join Playground.docm.vw_tables as otv
        on upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4))
       and upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo'))
       and upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2))
    inner join Playground.docm.vw_columns as otvc
        on otvc.tKey = otv.tKey
       and upper(otvc.ColumnName) = upper(parsename(fqc.FullyQualifiedName, 1));

declare @ResultCount int;
select @ResultCount = count(*)
from #TestFQColumns fqc
    inner join Playground.docm.vw_tables as otv
        on upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4))
       and upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo'))
       and upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2))
    inner join Playground.docm.vw_columns as otvc
        on otvc.tKey = otv.tKey
       and upper(otvc.ColumnName) = upper(parsename(fqc.FullyQualifiedName, 1));

print '';
if @ResultCount = 0 begin
    print '❌ PROBLEM IDENTIFIED: Join returns 0 rows!';
    print '';
    print 'Possible causes:';
    print '1. Table not in Playground.docm.vw_tables';
    print '2. Columns not in Playground.docm.vw_columns';
    print '3. Name parsing issue (check PARSENAME results above)';
    print '4. Database/Schema/Table/Column name mismatch';
end else begin
    print '✓ SUCCESS: Join returns ' + cast(@ResultCount as varchar(10)) + ' rows';
end;

print '';
print '=============================================';
print 'CHECKPOINT 8: Verify Metadata Exists';
print '=============================================';

print 'Searching for table in metadata:';
select top 5
    DatabaseName,
    SchemaName,
    TableName,
    tKey
from Playground.docm.vw_tables
where upper(TableName) like '%OFFICEDAYSTATS%SWELL%'
   or upper(TableName) like '%SWELL%';

print '';
print 'Searching for columns in metadata (if table exists):';
select top 10
    t.DatabaseName,
    t.SchemaName,
    t.TableName,
    c.ColumnName,
    c.cKey
from Playground.docm.vw_columns c
    inner join Playground.docm.vw_tables t on t.tKey = c.tKey
where upper(t.TableName) like '%OFFICEDAYSTATS%SWELL%'
   or upper(t.TableName) like '%SWELL%';

-- Cleanup
drop table #TestTargetColumns;
drop table #TestFQColumns;

print '';
print '=============================================';
print 'DIAGNOSTIC COMPLETE';
print '=============================================';
