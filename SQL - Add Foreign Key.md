```sql
alter table MySchema.MyTable
add constraint [fk__MySchema_MyTable_MyColumn]
foreign key (MyColumn)
references ParentSchema.ParentColumn (ParentColumn)
```
