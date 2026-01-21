```sql
exec sp_rename 'bi.Appointments_Collections', 'bi.Appointments_Collections_obs_20231101'
exec sp_rename 'bi.Appointments_Collections2', 'Appointments_Collections'
```

> [!Warning]
> - must declare DB
> - cannot use 3 objects in rename

2026-01-21 04:46 PM -- added these 2 to the logic
- - any views using that object
- any documentation tables that need to be updated

- check if it is a fk constraint
- any procs using that column -- rename
- any procs writing to that column
- jobs referencing that proc need to be renamed

```sql
-- accidental rename? revert
exec sp_rename 'bi.[bi.d_ttypg]', 'd_ttypg'
```

```sql

-- gregg's proc
declare @proc as varchar(max) = 'sd.usp_CurrentArAging';
set @proc = replace(replace(@proc, '[', ''), ']', '');
declare @newName as varchar(max) = '_obsolete_' + convert(varchar(10), getdate(), 121) + '_' + SqlMgmt.dbo.udf_StripValueV2(@proc, '.', '', null);
declare @msg as nvarchar(max) = '`' + @proc + '` changed to `' + @newName + '`';
raiserror(@msg, 10, 1) with nowait
exec sp_rename @proc, @newName
```

