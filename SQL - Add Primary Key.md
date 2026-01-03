```sql
alter table dbo.Categories
alter column CategoryKey int not null
go

alter table dbo.Categories
add primary key (CategoryKey)
go

alter table std.Dates 
add constraint [PK__std__Dates] 
primary key clustered (DateKey)
go
```
