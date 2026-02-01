declare @debugmode bit = 1;
declare @prkey int = 101;

-- =============================================
-- MERGE Procedure Column Dependencies Generator v4
-- Enhanced with Batch Processing
-- =============================================
-- Usage: Run this script in SSMS against the Playground database
-- Processes all procedures and accumulates results in #FinalResults
-- =============================================
-- Filter by prKey: Modify WHERE clause in line ~73
-- =============================================
/* NORMALIZATION
normalization...
  -> Removing multi-line comments /* ... */
  -> Removing single-line comments --
  -> Removing brackets [ ]
  -> Normalizing whitespace
  -> Collapsing multiple spaces
  -> Truncating at semicolon
  -> Removing OPTION (RECOMPILE)
  -> Converting to uppercase
  -> Adding newlines before WHEN
  -> Adding newlines before THEN
  -> NEW: Detecting CTE targets and prepending CTE definitions
  -> NEW: Batch processing mode with debug flag
*/

-- CLEANUP: Drop any existing temp tables from previous runs
if object_id('tempdb..#MergeNormalized') is not null drop table #MergeNormalized;
if object_id('tempdb..#TargetColumns') is not null drop table #TargetColumns;
if object_id('tempdb..#FullyQualifiedColumns') is not null drop table #FullyQualifiedColumns;
if object_id('tempdb..#FinalResults') is not null drop table #FinalResults;
if object_id('tempdb..#ProceduresToProcess') is not null drop table #ProceduresToProcess;

set nocount on;

-- =============================================
-- CREATE PERSISTENT TEMP TABLES
-- =============================================
-- Note: To filter by specific prKey, modify the INSERT statement below
-- =============================================

-- Table to store normalized merge blocks
create table #MergeNormalized (
    prKey int,
    DatabaseName nvarchar(128),
    SchemaName nvarchar(128),
    ProcedureName nvarchar(128),
    OriginalMergeBlock nvarchar(max),
    NormalizedMergeBlock nvarchar(max),
    ProcessingStatus nvarchar(50),
    ErrorMessage nvarchar(max)
);

-- Table to store final results (accumulated across all procedures)
create table #FinalResults (prKey int, cKey int, FullyQualifiedName nvarchar(500), StatementType nvarchar(50));

-- =============================================
-- HELPER: SQL Normalization Function (inline to avoid GO/variable scope issues)
-- =============================================
-- This normalization logic will be called inline where needed
-- TRUE DRY PRINCIPLE - No duplicate code!

-- =============================================
-- POPULATE PROCEDURES TO PROCESS
-- =============================================
create table #ProceduresToProcess (prKey int, DatabaseName nvarchar(128), SchemaName nvarchar(128), ProcedureName nvarchar(128));

-- Load all procedures (or filter by adding WHERE clause, e.g., WHERE prKey = 26)
insert into #ProceduresToProcess (prKey, DatabaseName, SchemaName, ProcedureName)
select
    prKey,
    database_name,
    schema_name,
    procedure_name
from Playground.docm.procedures
where 1 = 1
  and (prKey = @prkey and @debugmode = 1) -- Uncomment and set prKey to filter to specific procedure
order by prKey;

-- =============================================
-- MAIN PROCESSING LOOP
-- =============================================

declare @CurrentPrKey int;
declare @DatabaseName nvarchar(128);
declare @SchemaName nvarchar(128);
declare @ProcedureNameOnly nvarchar(128);
declare @ProcedureSQL nvarchar(max);
declare @SQL nvarchar(max);

-- MERGE extraction variables
declare @MergePos int;
declare @MergeBlock nvarchar(max);
declare @NormalizedMerge nvarchar(max);

-- CTE extraction variables
declare @CTEName nvarchar(128);
declare @CTEBlock nvarchar(max);
declare @CTESearchPattern nvarchar(200);
declare @CTEPos int;
declare @CTEEnd int;
declare @BeforeMergeSQL nvarchar(max);

-- Comment removal variables
declare @CommentStart int;
declare @CommentEnd int;
declare @LineStart int;
declare @LineEnd int;
declare @Line nvarchar(max);
declare @CleanSQL nvarchar(max);

-- Target extraction variables
declare @TargetTable nvarchar(500);
declare @TargetAlias nvarchar(128);
declare @UpdateType nvarchar(50);
declare @ActualTargetTable nvarchar(500);
declare @ActualTargetSchema nvarchar(128);

-- Error handling
declare @ErrorMessage nvarchar(max);
declare @ProcessingStatus nvarchar(50);
declare @msg nvarchar(max);

-- Cursor for procedures
declare proc_cursor cursor local fast_forward for
    select prKey, DatabaseName, SchemaName, ProcedureName from #ProceduresToProcess;

open proc_cursor;
fetch next from proc_cursor
into
    @CurrentPrKey,
    @DatabaseName,
    @SchemaName,
    @ProcedureNameOnly;

declare @TotalProcs int;
select @TotalProcs = count(*)from #ProceduresToProcess;
declare @CurrentProcNum int = 0;

while @@FETCH_STATUS = 0 begin
    begin try
        set @CurrentProcNum = @CurrentProcNum + 1;

        -- Display progress
        set @msg = N'[' + cast(@CurrentProcNum as nvarchar(10)) + N'/' + cast(@TotalProcs as nvarchar(10)) + N'] Processing: ' + @DatabaseName + N'.' + @SchemaName + N'.' + @ProcedureNameOnly;
        raiserror(@msg, 10, 1) with nowait;

        -- Reset variables for each procedure
        set @ProcedureSQL = null;
        set @MergeBlock = null;
        set @NormalizedMerge = null;
        set @TargetTable = null;
        set @TargetAlias = null;
        set @ActualTargetTable = null;
        set @UpdateType = null;
        set @ErrorMessage = null;
        set @ProcessingStatus = N'Processing';

        -- Get procedure definition
        set @SQL
            = N'
        SELECT @ProcedureSQL_OUT = m.definition
        FROM ' + quotename(@DatabaseName) + N'.sys.sql_modules AS m
        INNER JOIN ' + quotename(@DatabaseName) + N'.sys.objects AS o ON m.object_id = o.object_id
        INNER JOIN ' + quotename(@DatabaseName)
              + N'.sys.schemas AS s ON o.schema_id = s.schema_id
        WHERE s.name = @SchemaName_IN
          AND o.name = @ProcedureName_IN
          AND o.type = ''P'';';

        exec sp_executesql
            @SQL,
            N'@ProcedureSQL_OUT NVARCHAR(MAX) OUTPUT, @SchemaName_IN NVARCHAR(128), @ProcedureName_IN NVARCHAR(128)',
            @ProcedureSQL_OUT = @ProcedureSQL output,
            @SchemaName_IN = @SchemaName,
            @ProcedureName_IN = @ProcedureNameOnly;

        if @ProcedureSQL is null begin
            set @ErrorMessage = N'Procedure definition not found';
            set @ProcessingStatus = N'Skipped';
            goto NextProcedure;
        end;

        -- Extract MERGE INTO block
        set @MergePos = charindex('MERGE INTO', @ProcedureSQL);
        if @MergePos = 0 begin
            set @ErrorMessage = N'No MERGE statement found';
            set @ProcessingStatus = N'Skipped';
            goto NextProcedure;
        end;

        set @MergeBlock = substring(@ProcedureSQL, @MergePos, len(@ProcedureSQL));
        set @BeforeMergeSQL = substring(@ProcedureSQL, 1, @MergePos - 1);

        -- Normalize MERGE block (inline normalization logic)
        set @CleanSQL = @MergeBlock;

        -- Remove multi-line comments /* ... */
        while 1 = 1 begin
            set @CommentStart = charindex('/*', @CleanSQL);
            if @CommentStart = 0 break;
            set @CommentEnd = charindex('*/', @CleanSQL, @CommentStart + 2);
            if @CommentEnd = 0 break;
            set @CleanSQL = substring(@CleanSQL, 1, @CommentStart - 1) + N' ' + substring(@CleanSQL, @CommentEnd + 2, len(@CleanSQL));
        end;

        -- Remove single-line comments --
        declare @Result nvarchar(max) = N'';
        set @LineStart = 1;
        while @LineStart <= len(@CleanSQL)begin
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

        -- Add newlines for readability
        set @NormalizedMerge = replace(@NormalizedMerge, ' WHEN ', char(13) + char(10) + 'WHEN ');
        set @NormalizedMerge = replace(@NormalizedMerge, ' THEN ', char(13) + char(10) + 'THEN ');

        -- Extract target table and alias
        declare @MergeIntoPattern nvarchar(max);
        declare @AsPosition int;
        declare @UsingPosition int;
        declare @TargetSection nvarchar(500);

        -- Extract section between "MERGE INTO" and "USING"
        set @UsingPosition = charindex(' USING ', @NormalizedMerge);
        if @UsingPosition > 0 begin
            -- Get text between "MERGE INTO " and " USING"
            set @TargetSection = substring(@NormalizedMerge, 12, @UsingPosition - 12);
            set @TargetSection = ltrim(rtrim(@TargetSection));

            -- Check if there's an AS keyword
            set @AsPosition = charindex(' AS ', @TargetSection);

            if @AsPosition > 0 begin
                -- Target table is before AS, alias is after AS
                set @TargetTable = ltrim(rtrim(substring(@TargetSection, 1, @AsPosition)));
                set @TargetAlias = ltrim(rtrim(substring(@TargetSection, @AsPosition + 4, 500)));

                -- Remove any trailing spaces or parentheses
                set @TargetAlias = replace(@TargetAlias, ' ', '');
                set @TargetAlias = replace(@TargetAlias, '(', '');
            end;
            else begin
                -- No AS keyword, last word might be alias
                -- Find last space in target section
                declare @LastSpace int = len(@TargetSection) - charindex(' ', reverse(@TargetSection)) + 1;

                if @LastSpace > 0
               and @LastSpace < len(@TargetSection)begin
                    set @TargetTable = ltrim(rtrim(substring(@TargetSection, 1, @LastSpace)));
                    set @TargetAlias = ltrim(rtrim(substring(@TargetSection, @LastSpace + 1, 500)));
                end;
                else begin
                    set @TargetTable = @TargetSection;
                    set @TargetAlias = null;
                end;
            end;
        end;

        -- =============================================
        -- STEP 2: CTE DETECTION AND EXTRACTION
        -- =============================================
        -- Check if target table is defined as a CTE in a WITH clause
        -- This now works for ANY CTE name (not just ones containing 'CTE')
        -- and handles multiple CTEs (e.g., WITH cte_a (...), cte_b (...))

        -- Extract the CTE name (it's the target table in this case)
        set @CTEName = @TargetTable;

        -- Normalize the "before MERGE" SQL for searching (inline)
        declare @CleanBeforeMerge nvarchar(max);
        set @CleanSQL = @BeforeMergeSQL;

        -- Remove multi-line comments
        while 1 = 1 begin
            set @CommentStart = charindex('/*', @CleanSQL);
            if @CommentStart = 0 break;
            set @CommentEnd = charindex('*/', @CleanSQL, @CommentStart + 2);
            if @CommentEnd = 0 break;
            set @CleanSQL = substring(@CleanSQL, 1, @CommentStart - 1) + N' ' + substring(@CleanSQL, @CommentEnd + 2, len(@CleanSQL));
        end;

        -- Remove single-line comments
        set @Result = N'';
        set @LineStart = 1;
        while @LineStart <= len(@CleanSQL)begin
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

        set @CleanSQL = upper(@CleanSQL);
        set @CleanBeforeMerge = ltrim(rtrim(@CleanSQL));

        -- Search for CTE definition pattern: CTEName AS (
        -- Use uppercase for both pattern and search string
        set @CTESearchPattern = upper(@CTEName) + N' AS (';
        set @CTEPos = charindex(@CTESearchPattern, @CleanBeforeMerge);

        if @CTEPos > 0 begin
            -- Find matching closing parenthesis
            declare @ParenCount int = 0;
            declare @SearchPos int = @CTEPos + len(@CTESearchPattern) - 1;
            declare @CurrentChar char(1);
            set @CTEEnd = 0;

            while @SearchPos <= len(@CleanBeforeMerge)begin
                set @CurrentChar = substring(@CleanBeforeMerge, @SearchPos, 1);
                if @CurrentChar = '(' set @ParenCount = @ParenCount + 1;
                if @CurrentChar = ')' begin
                    set @ParenCount = @ParenCount - 1;
                    if @ParenCount = 0 begin
                        set @CTEEnd = @SearchPos;
                        break;
                    end;
                end;
                set @SearchPos = @SearchPos + 1;
            end;

            -- Extract CTE block (already normalized and uppercased)
            if @CTEEnd > 0 begin
                set @CTEBlock = substring(@CleanBeforeMerge, @CTEPos, @CTEEnd - @CTEPos + 1);
                set @CTEBlock = ltrim(rtrim(@CTEBlock));

                -- Extract actual target table from CTE's FROM clause
                -- Pattern: FROM schema.table or FROM schema.table alias
                declare @FromPos int = charindex('FROM ', @CTEBlock);
                if @FromPos > 0 begin
                    declare @FromSection nvarchar(500) = substring(@CTEBlock, @FromPos + 5, 500);
                    -- Find end of FROM clause (look for next keyword or closing paren)
                    declare @FromEnd int = charindex(')', @FromSection);
                    if @FromEnd = 0 set @FromEnd = charindex(' WHERE ', @FromSection);
                    if @FromEnd = 0 set @FromEnd = charindex(' JOIN ', @FromSection);
                    if @FromEnd = 0 set @FromEnd = len(@FromSection);

                    set @FromSection = ltrim(rtrim(substring(@FromSection, 1, @FromEnd)));

                    -- Extract schema.table (first word or first two words with dot)
                    declare @SpaceInFrom int = charindex(' ', @FromSection);
                    if @SpaceInFrom > 0 set @ActualTargetTable = substring(@FromSection, 1, @SpaceInFrom - 1);
                    else set @ActualTargetTable = @FromSection;

                    set @ActualTargetTable = ltrim(rtrim(@ActualTargetTable));
                    set @ActualTargetSchema = parsename(@ActualTargetTable, 2);
                end;

                -- Prepend CTE to normalized MERGE
                set @NormalizedMerge = @CTEBlock + char(13) + char(10) + char(13) + char(10) + @NormalizedMerge;
            end;
        end;

        -- If no CTE detected, use target table as-is
        if @ActualTargetTable is null set @ActualTargetTable = @TargetTable;

        -- =============================================
        -- EXTRACT COLUMNS FROM MERGE AND INSERT STATEMENTS
        -- =============================================

        -- Create temp table for columns (recreate for each procedure)
        if object_id('tempdb..#TargetColumns') is not null drop table #TargetColumns;
        create table #TargetColumns (ColumnName nvarchar(128), SourceTable nvarchar(500), StatementType nvarchar(50));

        -- Find the UPDATE SET section
        declare @UpdateSetPos int = charindex('UPDATE SET ', @NormalizedMerge);
        if @UpdateSetPos > 0 begin
            -- Extract everything after "UPDATE SET " 
            declare @UpdateSetSection nvarchar(max) = substring(@NormalizedMerge, @UpdateSetPos + 11, len(@NormalizedMerge));

            -- Find the end of UPDATE SET (look for next WHEN or semicolon)
            declare @UpdateSetEnd int = charindex('WHEN ', @UpdateSetSection);
            if @UpdateSetEnd = 0 set @UpdateSetEnd = charindex(';', @UpdateSetSection);
            if @UpdateSetEnd = 0 set @UpdateSetEnd = len(@UpdateSetSection);

            set @UpdateSetSection = substring(@UpdateSetSection, 1, @UpdateSetEnd);

            -- Parse column assignments (pattern: alias.column = value)
            -- Split by comma
            declare @AssignmentList nvarchar(max) = @UpdateSetSection + N',';
            declare @CommaPos int;
            declare @Assignment nvarchar(500);
            declare @EqualsPos int;
            declare @ColumnPart nvarchar(500);
            declare @DotPos int;
            declare @ColumnName nvarchar(128);

            while charindex(',', @AssignmentList) > 0 begin
                set @CommaPos = charindex(',', @AssignmentList);
                set @Assignment = ltrim(rtrim(substring(@AssignmentList, 1, @CommaPos - 1)));

                -- Get part before equals sign
                set @EqualsPos = charindex('=', @Assignment);
                if @EqualsPos > 0 begin
                    set @ColumnPart = ltrim(rtrim(substring(@Assignment, 1, @EqualsPos - 1)));

                    -- Check if it starts with the target alias
                    if @TargetAlias is not null
                   and @ColumnPart like @TargetAlias + '.%' begin
                        -- Extract column name after the dot
                        set @DotPos = charindex('.', @ColumnPart);
                        set @ColumnName = substring(@ColumnPart, @DotPos + 1, 500);

                        -- Clean up column name
                        set @ColumnName = ltrim(rtrim(@ColumnName));

                        -- Build fully qualified source table (Database.Schema.Table)
                        declare @FullMergeTarget nvarchar(500) = @DatabaseName + N'.' + @ActualTargetTable;

                        -- Insert into temp table
                        if len(@ColumnName) > 0
                       and not exists (
                                   select
                                       1
                                   from #TargetColumns
                                   where ColumnName = @ColumnName
                                     and SourceTable = @FullMergeTarget
                                     and StatementType = 'MERGE-UPDATE'
                               ) begin
                            insert into #TargetColumns (ColumnName, SourceTable, StatementType)
                            values
                            (@ColumnName, @FullMergeTarget, 'MERGE-UPDATE');
                        end;
                    end;
                end;

                set @AssignmentList = substring(@AssignmentList, @CommaPos + 1, len(@AssignmentList));
            end;
        end;

        -- Find the INSERT section
        declare @InsertPos int = charindex('THEN INSERT (', @NormalizedMerge);
        if @InsertPos > 0 begin
            -- Extract column list from INSERT (...)
            declare @InsertSection nvarchar(max) = substring(@NormalizedMerge, @InsertPos + 13, len(@NormalizedMerge));

            -- Find closing parenthesis
            declare @InsertEnd int = charindex(')', @InsertSection);
            if @InsertEnd > 0 begin
                set @InsertSection = substring(@InsertSection, 1, @InsertEnd - 1);

                -- Parse column list (comma-separated)
                set @AssignmentList = @InsertSection + N',';

                while charindex(',', @AssignmentList) > 0 begin
                    set @CommaPos = charindex(',', @AssignmentList);
                    set @ColumnName = ltrim(rtrim(substring(@AssignmentList, 1, @CommaPos - 1)));

                    -- Clean up column name (remove any alias prefix if present)
                    if charindex('.', @ColumnName) > 0 begin
                        set @DotPos = charindex('.', @ColumnName);
                        set @ColumnName = substring(@ColumnName, @DotPos + 1, 500);
                    end;

                    set @ColumnName = ltrim(rtrim(@ColumnName));

                    -- Build fully qualified source table (Database.Schema.Table)
                    set @FullMergeTarget = @DatabaseName + N'.' + @ActualTargetTable;

                    -- Insert into temp table
                    if len(@ColumnName) > 0
                   and not exists (
                               select
                                   1
                               from #TargetColumns
                               where ColumnName = @ColumnName
                                 and SourceTable = @FullMergeTarget
                                 and StatementType = 'MERGE-INSERT'
                           ) begin
                        insert into #TargetColumns (ColumnName, SourceTable, StatementType)
                        values
                        (@ColumnName, @FullMergeTarget, 'MERGE-INSERT');
                    end;

                    set @AssignmentList = substring(@AssignmentList, @CommaPos + 1, len(@AssignmentList));
                end;
            end;
        end;

        -- =============================================
        -- STEP 3: PARSE STANDALONE INSERT STATEMENTS
        -- =============================================
        -- Find all INSERT INTO statements (excluding temp tables #, table variables @)
        declare @InsertStartPos int = 1;
        declare @InsertIntoPos int;
        declare @InsertStatement nvarchar(max);
        declare @NormalizedInsert nvarchar(max);
        declare @InsertTarget nvarchar(500);
        declare @InsertTargetSchema nvarchar(128);
        declare @InsertTargetTable nvarchar(128);
        declare @InsertColumnsStart int;
        declare @InsertColumnsEnd int;
        declare @InsertColumnList nvarchar(max);
        declare @SelectPos int;
        declare @ValuesPos int;
        declare @InsertEndPos int;

        while 1 = 1 begin
            -- Find next INSERT INTO
            set @InsertIntoPos = charindex('INSERT INTO', @ProcedureSQL, @InsertStartPos);
            if @InsertIntoPos = 0 break;

            -- Extract INSERT statement (up to SELECT or VALUES keyword)
            set @SelectPos = charindex('SELECT', @ProcedureSQL, @InsertIntoPos);
            set @ValuesPos = charindex('VALUES', @ProcedureSQL, @InsertIntoPos);
            set @InsertEndPos = case when @SelectPos > 0
                                      and (@ValuesPos = 0 or @SelectPos < @ValuesPos) then @SelectPos
                                     when @ValuesPos > 0 then @ValuesPos
                                     else @InsertIntoPos + 1000 end;

            set @InsertStatement = substring(@ProcedureSQL, @InsertIntoPos, @InsertEndPos - @InsertIntoPos);

            -- Normalize INSERT statement (inline)
            set @CleanSQL = @InsertStatement;

            -- Remove multi-line comments
            while 1 = 1 begin
                set @CommentStart = charindex('/*', @CleanSQL);
                if @CommentStart = 0 break;
                set @CommentEnd = charindex('*/', @CleanSQL, @CommentStart + 2);
                if @CommentEnd = 0 break;
                set @CleanSQL = substring(@CleanSQL, 1, @CommentStart - 1) + N' ' + substring(@CleanSQL, @CommentEnd + 2, len(@CleanSQL));
            end;

            -- Remove single-line comments
            set @Result = N'';
            set @LineStart = 1;
            while @LineStart <= len(@CleanSQL)begin
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

            set @CleanSQL = upper(@CleanSQL);
            set @NormalizedInsert = ltrim(rtrim(@CleanSQL));

            -- Extract target table (pattern: INSERT INTO [schema].[table] (columns))
            -- Look for table name after "INSERT INTO "
            set @InsertColumnsStart = charindex('(', @NormalizedInsert);
            if @InsertColumnsStart > 0 begin
                set @InsertTarget = ltrim(rtrim(substring(@NormalizedInsert, 13, @InsertColumnsStart - 13)));

                -- Skip if temp table or table variable
                if @InsertTarget not like '#%'
               and @InsertTarget not like '@%' begin
                    -- Parse Database.Schema.Table using PARSENAME
                    declare @InsertTargetDatabase nvarchar(128);
                    set @InsertTargetTable = parsename(@InsertTarget, 1);
                    set @InsertTargetSchema = isnull(parsename(@InsertTarget, 2), 'dbo');
                    set @InsertTargetDatabase = isnull(parsename(@InsertTarget, 3), @DatabaseName); -- Use @DatabaseName if missing

                    -- Build fully qualified target (Database.Schema.Table)
                    declare @FullInsertTarget nvarchar(500) = @InsertTargetDatabase + N'.' + @InsertTargetSchema + N'.' + @InsertTargetTable;

                    -- Extract column list
                    set @InsertColumnsEnd = charindex(')', @NormalizedInsert, @InsertColumnsStart);
                    if @InsertColumnsEnd > 0 begin
                        set @InsertColumnList = substring(@NormalizedInsert, @InsertColumnsStart + 1, @InsertColumnsEnd - @InsertColumnsStart - 1);

                        -- Parse columns (comma-separated)
                        set @AssignmentList = @InsertColumnList + N',';
                        while charindex(',', @AssignmentList) > 0 begin
                            set @CommaPos = charindex(',', @AssignmentList);
                            set @ColumnName = ltrim(rtrim(substring(@AssignmentList, 1, @CommaPos - 1)));

                            -- Clean up column name (remove any alias prefix if present)
                            if charindex('.', @ColumnName) > 0 begin
                                set @DotPos = charindex('.', @ColumnName);
                                set @ColumnName = substring(@ColumnName, @DotPos + 1, 500);
                            end;

                            set @ColumnName = ltrim(rtrim(@ColumnName));

                            -- Insert into temp table (with full qualified table name)
                            if len(@ColumnName) > 0
                           and not exists (
                                       select
                                           1
                                       from #TargetColumns
                                       where ColumnName = @ColumnName
                                         and SourceTable = @FullInsertTarget
                                         and StatementType = 'INSERT'
                                   ) begin
                                insert into #TargetColumns (ColumnName, SourceTable, StatementType) values (@ColumnName, @FullInsertTarget, 'INSERT');
                            end;

                            set @AssignmentList = substring(@AssignmentList, @CommaPos + 1, len(@AssignmentList));
                        end;
                    end;
                end;
            end;

            set @InsertStartPos = @InsertIntoPos + 1;
        end;

        -- Generate fully qualified column names
        if object_id('tempdb..#FullyQualifiedColumns') is not null drop table #FullyQualifiedColumns;
        create table #FullyQualifiedColumns (prKey int, FullyQualifiedName nvarchar(500), StatementType nvarchar(50));

        -- Insert fully qualified names (Database.Table.Column from SourceTable)
        insert into #FullyQualifiedColumns (prKey, FullyQualifiedName, StatementType)
        select @CurrentPrKey, tc.SourceTable + '.' + tc.ColumnName, tc.StatementType from #TargetColumns tc;

        -- Join to get cKey and insert into #FinalResults (accumulating)
        insert into #FinalResults (prKey, cKey, FullyQualifiedName, StatementType)
        select
            fqc.prKey,
            otvc.cKey,
            fqc.FullyQualifiedName,
            fqc.StatementType
        from #FullyQualifiedColumns fqc
            inner join Playground.docm.vw_tables as otv
                on upper(otv.DatabaseName) = upper(parsename(fqc.FullyQualifiedName, 4))
               and upper(otv.SchemaName) = upper(isnull(parsename(fqc.FullyQualifiedName, 3), 'dbo'))
               and upper(otv.TableName) = upper(parsename(fqc.FullyQualifiedName, 2))
            inner join Playground.docm.vw_columns as otvc
                on otvc.tKey = otv.tKey
               and upper(otvc.ColumnName) = upper(parsename(fqc.FullyQualifiedName, 1));


        set @ProcessingStatus = N'Completed';

    end try
    begin catch
        set @ErrorMessage = error_message();
        set @ProcessingStatus = N'Error';
    end catch;

    NextProcedure:
    -- Insert into merge normalized table for tracking
    insert into #MergeNormalized (prKey, DatabaseName, SchemaName, ProcedureName, OriginalMergeBlock, NormalizedMergeBlock, ProcessingStatus, ErrorMessage)
    values
    (@CurrentPrKey, @DatabaseName, @SchemaName, @ProcedureNameOnly, @MergeBlock, @NormalizedMerge, @ProcessingStatus, @ErrorMessage);

    fetch next from proc_cursor
    into
        @CurrentPrKey,
        @DatabaseName,
        @SchemaName,
        @ProcedureNameOnly;
end;

close proc_cursor;
deallocate proc_cursor;

-- =============================================
-- FINAL OUTPUT
-- =============================================

-- Show batch processing summary
declare @TotalProcessed int;
declare @TotalCompleted int;
declare @TotalSkipped int;
declare @TotalErrors int;
declare @TotalResults int;

select @TotalProcessed = count(*)from #MergeNormalized;
select @TotalCompleted = count(*)from #MergeNormalized where ProcessingStatus = 'Completed';
select @TotalSkipped = count(*)from #MergeNormalized where ProcessingStatus = 'Skipped';
select @TotalErrors = count(*)from #MergeNormalized where ProcessingStatus = 'Error';
select @TotalResults = count(*)from #FinalResults;

print '=============================================';
print 'BATCH PROCESSING SUMMARY';
print '=============================================';
print 'Total Procedures Processed: ' + cast(@TotalProcessed as nvarchar(10));
print 'Successfully Completed: ' + cast(@TotalCompleted as nvarchar(10));
print 'Skipped (No MERGE): ' + cast(@TotalSkipped as nvarchar(10));
print 'Errors: ' + cast(@TotalErrors as nvarchar(10));
print 'Total Column Dependencies Found: ' + cast(@TotalResults as nvarchar(10));
print '';
print '---------------------------------------------';
print 'Query #FinalResults for detailed results:';
print 'SELECT * FROM #FinalResults ORDER BY prKey, cKey;';
print '';
print 'Query #MergeNormalized for processing details:';
print 'SELECT * FROM #MergeNormalized;';
print '---------------------------------------------';

-- Cleanup transient temp tables
if object_id('tempdb..#TargetColumns') is not null drop table #TargetColumns;
if object_id('tempdb..#FullyQualifiedColumns') is not null drop table #FullyQualifiedColumns;
if object_id('tempdb..#ProceduresToProcess') is not null drop table #ProceduresToProcess;

-- Keep #FinalResults and #MergeNormalized for querying

-- =============================================
-- DISPLAY RESULTS IN GRID
-- =============================================
select
    fr.prKey,
    fr.cKey,
    p.procedure_name as ProcedureName,
    otvc.ObjectQualifiedName,
    string_agg(fr.StatementType, ', ') StatementType
from #FinalResults as fr
    left join Playground.docm.procedures as p
        on p.prKey = fr.prKey
    left join Playground.docm.vw_columns as otvc
        on otvc.cKey = fr.cKey
    -- anti join 
    left join Playground.docm.column_proc_trackback as tgt
        on tgt.cKey = otvc.cKey
       and tgt.prKey = p.prKey
where 1 = 1
  and tgt.cKey is null
group by fr.prKey,
         fr.cKey,
         p.procedure_name,
         otvc.ObjectQualifiedName
order by fr.prKey,
         fr.cKey;

return;
go
