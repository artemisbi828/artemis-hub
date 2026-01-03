```sql
alter table [stg].[S_Customers]
add
    constraint [fk_S_Customers]
    foreign key ([hk_H_Customer])
    references [stg].[H_Customers] ([hk_H_Customer]);
```
