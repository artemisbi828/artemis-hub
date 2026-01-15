```sql
declare @loaddatetimeutc datetime2 = sysutcdatetime();
declare @loadsource nvarchar(128) = N'';
declare @loadedby nvarchar(128) = suser_name();

use Playground
create table docm.procedures (
    prKey int primary key identity(1, 1),
    database_name sysname,
    schema_name sysname,
    procedure_name sysname,
    create_date datetime,
    diff_modify_date datetime,
----
    sort_order_by_db decimal(4,2),
    comment nvarchar(250),
    loaddatetimeutc datetime2(3)
        default sysutcdatetime(),
    loadsource nvarchar(128),
    loadedby nvarchar(128)
        default suser_sname()
----        
--unique (database_name, schema_name, procedure_name)
);

```