use EDW; -- # input database

-- ==================================================
-- CONFIGURATION: Set the source and target databases
-- ==================================================
-- DBS == CentralC9, Lake, EDW, Snowflake, OrthoFi, Dayforce

declare @userconfirmation bit = 0; -- set to 1 to enter 
declare @schema nvarchar(64) = N'bi';
declare @loaddatetimeutc datetime2 = sysutcdatetime();
declare @loadsource nvarchar(128) = N'Initial Load';
declare @loadedby nvarchar(128) = suser_name();
declare @exceptions table (schema_name nvarchar(16));

-- set configs
set nocount on;
set @schema = null;
insert into @exceptions values ('TaskHosting'), ('dss'), ('sys'), ('deleted');

-- if database exists exit out for now
if exists (select top 1 1 from Playground.docm.procedures as p where p.database_name = db_name())
and @userconfirmation = 0 --
begin
    ;throw 50000, 'Records for this database already exist in playground.docm.procedures. Execution aborted.', 1;
    return; -- exit failsafe, just in case
end;

insert into Playground.docm.procedures (database_name, schema_name, procedure_name, create_date, diff_modify_date, loaddatetimeutc, loadsource, loadedby)
select
    db_name() database_name,
    s.name as schema_name,
    a.name as procedure_name,
    a.create_date,
    case when cast(a.modify_date as date) = cast(a.create_date as date) then null
         else a.modify_date end diff_modify_date,
    @loaddatetimeutc as loaddatetimeutc,
    @loadsource as loadsource,
    @loadedby as loadedby
from sys.all_objects as a
    left join sys.schemas as s
        on a.schema_id = s.schema_id
    left join @exceptions as e
        on e.schema_name = s.name
where 1 = 1
  and a.type_desc = 'SQL_STORED_PROCEDURE'
  and (s.name = @schema or @schema is null)
  /* anti join */
  and e.schema_name is null
order by 2,
         3,
         4;


-- output
declare @rowcount nvarchar(16) = @@ROWCOUNT;
print 'records processed ' + @rowcount;
select top 200 * from Playground.docm.procedures as p order by 1 desc;

set nocount off;


/*
drop table docm.procedures

create table docm.procedures (
    prKey int primary key identity(1, 1),
    database_name sysname,
    schema_name sysname,
    procedure_name sysname,
    create_date datetime,
    diff_modify_date datetime,
    loaddatetimeutc datetime2(3)
        default sysutcdatetime(),
    loadsource nvarchar(128),
    loadedby nvarchar(128)
        default suser_sname()
        unique (database_name, schema_name, procedure_name)
);
*/
