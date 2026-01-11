
---
if there's a group by, 
first check if there is a column w "IS" → wrap it first with cast(`Value` as tinyint)
other than the columns in the group by → wrap everything in sum()
also make sure any aliases have " as "
```sql
-- # before
select
            cte1.DateKey,
            cte1.OfficeKey,
            --cte1.LedgerType,
            cte1.NetProduction_TotalAmount,
            cte1.CaseStart_ConversionCount,
            cte1.AppointmentsHistoric_NPECount,
            cte1.AppointmentsHistoric_NPEDismissedCount,
            cte1.PaymentCollection_Amount,
            cte1.AppointmentsHistoric_Count
        from cte1
        where cte1.DateKey >= '2024-01-01'
        group by cte1.DateKey,
                 cte1.OfficeKey

-- # after
select
            cte1.DateKey,
            cte1.OfficeKey,
            --cte1.LedgerType,
            sum(cte1.NetProduction_TotalAmount) as NetProduction_TotalAmount,
            sum(cte1.CaseStart_ConversionCount) as CaseStart_ConversionCount,
            sum(cte1.AppointmentsHistoric_NPECount) as AppointmentsHistoric_NPECount,
            sum(cte1.AppointmentsHistoric_NPEDismissedCount) as AppointmentsHistoric_NPEDismissedCount,
            sum(cte1.PaymentCollection_Amount) as PaymentCollection_Amount,
            sum(cte1.AppointmentsHistoric_Count) as AppointmentsHistoric_Count
        from cte1
        where cte1.DateKey >= '2024-01-01'
        group by cte1.DateKey,
                 cte1.OfficeKey
```
---
if it's a full join, on the the join, wrap isnull 

```sql
-- # source
    from cte2
        full join dbo.Contracts as c
            on c.DateKey = cte2.DateKey
           and c.OfficeKey = cte2.OfficeKey;

-- # input into select
        select isnull(cte2.DateKey, c.DateKey) as DateKey,
        isnull(cte2.OfficeKey, c.OfficeKey) as OfficeKey,
```