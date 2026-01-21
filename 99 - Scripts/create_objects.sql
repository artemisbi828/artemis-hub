-- ================================================================================
-- SCRIPT 1: CREATE TABLE STATEMENTS
-- Optimized datatypes for metadata tracking tables
-- ================================================================================

-- Create schema if not exists
if not exists (select * from sys.schemas where name = 'docm') begin
    exec ('CREATE SCHEMA docm');
end;
go

-- ================================================================================
-- Table 1: docm.objects_tables_views
-- Tracks all tables and views with row/column counts
-- ================================================================================
if object_id('docm.objects_tables_views', 'U') is null begin
    create table docm.objects_tables_views (
        tvKey int identity(1, 1) not null,
        DatabaseName sysname not null,         -- sysname = nvarchar(128)
        SchemaName sysname not null,           -- sysname = nvarchar(128)
        TableViewName sysname not null,        -- sysname = nvarchar(128)
        TableViewType nvarchar(64) null,
        TotalRows bigint null,
        LoadDateTimeUtc datetime2(3) not null, -- 3 decimal places sufficient
        LoadSource sysname not null,           -- sysname for user names,
        EndDateTimeUtc datetime2(3) null
            constraint PK__objects_tables_views
            primary key clustered (tvKey),
        constraint UQ__objects_tables_views_Database_Schema_Table
            unique (DatabaseName, SchemaName, TableViewName)
    );

end
else begin
    -- Add DatabaseName column if it doesn't exist
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views') and name = 'DatabaseName'
    ) begin
        alter table docm.objects_tables_views add DatabaseName sysname not null default DB_NAME();
        print 'Added DatabaseName column to docm.objects_tables_views';
        
        -- Drop old constraint and create new one with DatabaseName
        if exists (select 1 from sys.key_constraints where name = 'UQ__objects_tables_views_Schema_Table') begin
            alter table docm.objects_tables_views drop constraint UQ__objects_tables_views_Schema_Table;
            print 'Dropped old unique constraint UQ__objects_tables_views_Schema_Table';
        end;
        
        alter table docm.objects_tables_views add constraint UQ__objects_tables_views_Database_Schema_Table
            unique (DatabaseName, SchemaName, TableViewName);
        print 'Created new unique constraint UQ__objects_tables_views_Database_Schema_Table';
    end;
end;
go

-- ================================================================================
-- Table 2: docm.objects_tables_views_columns
-- Tracks columns for each table/view with data quality metrics
-- ================================================================================
if object_id('docm.objects_tables_views_columns', 'U') is null begin
    create table docm.objects_tables_views_columns (
        tvcKey int identity(1, 1) not null,
        tvKey int not null,
        SortOrder decimal(5, 2) not null, -- Ordinal position
        ColumnName sysname not null,      -- sysname = nvarchar(128)
        DataType sysname not null,        -- sysname for data type names
        MaxLength int null,               -- Max length for string types (-1 for MAX)
        IsNullable bit not null
            default 0,                    -- 1 = Nullable, 0 = Not Null
        IsPrimaryKey bit not null
            default 0,                    -- 1 = Part of primary key
        IsForeignKey bit not null
            default 0,                    -- 1 = Part of foreign key
        IsIdentity bit not null
            default 0,                    -- 1 = Identity column
        IsComputed bit not null
            default 0,                    -- 1 = Computed column
        DefaultValue nvarchar(500) null,  -- Default constraint value
        LoadDateTimeUtc datetime2(3) not null,
        LoadSource sysname not null,
        EndDateTimeUtc datetime2(3) null
            constraint PK__objects_tables_views_columns
            primary key clustered (tvcKey),
        constraint FK__objects_tables_views_columns__tvKey
            foreign key (tvKey)
            references docm.objects_tables_views (tvKey),
        constraint UQ__objects_tables_views_columns_Key
            unique (tvKey, ColumnName)
    );
end;
else begin
    -- Fix unique constraint if it includes LoadDateTimeUtc (old version)
    if exists (
        select 1 
        from sys.indexes i
        inner join sys.index_columns ic1 on i.object_id = ic1.object_id and i.index_id = ic1.index_id
        inner join sys.columns c1 on ic1.object_id = c1.object_id and ic1.column_id = c1.column_id
        where i.name = 'UQ__objects_tables_views_columns_Key'
          and i.object_id = object_id('docm.objects_tables_views_columns')
          and c1.name = 'LoadDateTimeUtc'
    ) begin
        alter table docm.objects_tables_views_columns drop constraint UQ__objects_tables_views_columns_Key;
        print 'Dropped old unique constraint UQ__objects_tables_views_columns_Key (included LoadDateTimeUtc)';
        
    end;
    
    -- Add new columns if they don't exist
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'IsNullable'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            IsNullable bit not null
                default 0;
        print 'Added IsNullable column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'MaxLength'
    ) begin
        alter table docm.objects_tables_views_columns add MaxLength int null;
        print 'Added MaxLength column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'IsPrimaryKey'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            IsPrimaryKey bit not null
                default 0;
        print 'Added IsPrimaryKey column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'IsForeignKey'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            IsForeignKey bit not null
                default 0;
        print 'Added IsForeignKey column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'IsIdentity'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            IsIdentity bit not null
                default 0;
        print 'Added IsIdentity column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'IsComputed'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            IsComputed bit not null
                default 0;
        print 'Added IsComputed column to docm.objects_tables_views_columns';
    end;
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_tables_views_columns') and name = 'DefaultValue'
    ) begin
        alter table docm.objects_tables_views_columns
        add
            DefaultValue nvarchar(500) null;
        print 'Added DefaultValue column to docm.objects_tables_views_columns';
    end;
end;
go

-- ================================================================================
-- Table 4: docm.objects_extended_properties
-- Tracks extended properties (descriptions) for tables and columns
-- ================================================================================
if object_id('docm.objects_extended_properties', 'U') is null begin
    create table docm.objects_extended_properties (
        epKey int identity(1, 1) not null,
        tvcKey int not null,
        DatabaseName sysname not null,
        SchemaName sysname not null,
        TableName sysname not null,
        ColumnName sysname null,        -- NULL for table-level properties
        Description nvarchar(500) null, -- Extended to 500 for descriptions
        LoadDateTimeUtc datetime2(3) not null,
        LoadSource sysname not null,
        IsCurrent bit not null
            default 0,
        constraint PK__objects_extended_properties
            primary key clustered (epKey),
        constraint UQ__objects_extended_properties_Key
            unique (DatabaseName, SchemaName, TableName, ColumnName, LoadDateTimeUtc)
    );

    create nonclustered index IX_objects_extended_properties_IsCurrent
        on docm.objects_extended_properties (IsCurrent)
        include (DatabaseName, SchemaName, TableName, ColumnName, LoadDateTimeUtc);
end
else begin
    -- Add DatabaseName column if it doesn't exist
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_extended_properties') and name = 'DatabaseName'
    ) begin
        alter table docm.objects_extended_properties add DatabaseName sysname not null default DB_NAME();
        print 'Added DatabaseName column to docm.objects_extended_properties';
    end;
end;
go

-- Create progress log table if it doesn't exist
if object_id('docm.objects_load_progress_log', 'U') is null begin
    create table docm.objects_load_progress_log (
        logKey int identity(1, 1) not null primary key,
        LoadBatchId uniqueidentifier not null,
        StepName nvarchar(100) not null,
        ObjectType nvarchar(50) null,
        SchemaName sysname null,
        ObjectName sysname null,
        ColumnName sysname null,
        CurrentProgress int null,
        TotalCount int null,
        StatusMessage nvarchar(500) null,
        StartTime datetime2(3) not null,
        EndTime datetime2(3) null,
        DurationSeconds decimal(10, 2) null,
        IsComplete bit not null
            default 0,
        ErrorMessage nvarchar(max) null
    );
    print 'Created docm.objects_load_progress_log table';
end;
go

-- ================================================================================
-- Table 5: docm.objects_foreign_keys
-- Tracks foreign key relationships between tables
-- ================================================================================
if object_id('docm.objects_foreign_keys', 'U') is null begin
    create table docm.objects_foreign_keys (
        fkKey int identity(1, 1) not null primary key,
        DatabaseName sysname not null,
        ForeignKeyName sysname not null,
        ParentSchema sysname not null,
        ParentTable sysname not null,
        ParentColumn sysname not null,
        ReferencedSchema sysname not null,
        ReferencedTable sysname not null,
        ReferencedColumn sysname not null,
        LoadDateTimeUtc datetime2(3) not null,
        LoadSource sysname not null,
        EndDateTimeUtc datetime2(3) null,
        constraint UQ__objects_foreign_keys_Key
            unique (DatabaseName, ForeignKeyName, ParentSchema, ParentTable, ParentColumn)
    );
    print 'Created docm.objects_foreign_keys table';
end
else begin
    -- Add DatabaseName column if it doesn't exist
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_foreign_keys') and name = 'DatabaseName'
    ) begin
        alter table docm.objects_foreign_keys add DatabaseName sysname not null default DB_NAME();
        print 'Added DatabaseName column to docm.objects_foreign_keys';
    end;
end;
go

-- ================================================================================
-- Table 6: docm.objects_primary_keys
-- Tracks primary key constraints and their columns
-- ================================================================================
if object_id('docm.objects_primary_keys', 'U') is null begin
    create table docm.objects_primary_keys (
        pkKey int identity(1, 1) not null primary key,
        DatabaseName sysname not null,
        PrimaryKeyName sysname not null,
        SchemaName sysname not null,
        TableName sysname not null,
        ColumnName sysname not null,
        KeyOrdinal int not null, -- Position in composite key
        LoadDateTimeUtc datetime2(3) not null,
        LoadSource sysname not null,
        EndDateTimeUtc datetime2(3) null,
        constraint UQ__objects_primary_keys_Key
            unique (DatabaseName, PrimaryKeyName, SchemaName, TableName, ColumnName)
    );
    print 'Created docm.objects_primary_keys table';
end
else begin
    -- Add DatabaseName column if it doesn't exist
    if not exists (
        select 1 from sys.columns where object_id = object_id('docm.objects_primary_keys') and name = 'DatabaseName'
    ) begin
        alter table docm.objects_primary_keys add DatabaseName sysname not null default DB_NAME();
        print 'Added DatabaseName column to docm.objects_primary_keys';
    end;
end;
go

print 'All docm schema tables created successfully';
go


-- ================================================================================
-- Table 7: docm.objects_columnstats
-- Tracks column profiles
-- ================================================================================

create table docm.objects_columnstats (
    cstatKey int identity(1, 1) primary key,
    tvcKey int not null,
    ColumnName sysname not null,
    TotalRows bigint not null,
    NullRows bigint not null,
    DistinctCount bigint null,
    Top5DistinctExamples nvarchar(max) null,
    LoadDateTimeUtc datetime2(3) not null,
    LoadSource sysname not null,
    EndDateTimeUtc datetime2(3) null
);
go

create or alter view docm.vw_TablesViewsColumns
as
    select
        row_number() over (order by tav.DatabaseName, tav.SchemaName, tav.TableViewName, tavc.SortOrder) ViewId,
        tavc.tvcKey,
        tavc.tvKey,
        tav.DatabaseName,
        tav.SchemaName,
        tav.TableViewName,
        tav.TableViewType,
        tavc.SortOrder,
        tavc.ColumnName,
        oep.Description as ColumnDescription,
        tavc.DataType,
        oc.TotalRows,
        oc.NullRows,
        oc.DistinctCount,
        oc.Top5DistinctExamples,
        tavc.LoadDateTimeUtc,
        tavc.LoadSource,
        tavc.EndDateTimeUtc
    from docm.objects_tables_views_columns as tavc
        inner join docm.objects_tables_views as tav
            on tav.tvKey = tavc.tvKey
        left join docm.objects_columnstats as oc
            on oc.tvcKey = tavc.tvcKey
        left join docm.objects_extended_properties as oep
            on oep.tvcKey = tavc.tvcKey;