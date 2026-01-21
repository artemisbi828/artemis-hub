- Remove brackets
- Top 5 → Limit 5
- TO_DATE(TO_VARCHAR(), 'YYYYMMDD')
- ISNULL() → NVL()

# MSSQL
```sql
set tran isolation level read uncommitted;
use EDW_PROD_SNOWFLAKE;

select top 5
       loc.LOCATION_NAME,
       cast(cast(trans.D_TRANSACTION_DATE_KEY as char(8)) as date) as transDate,
       cast(cast(trans.[D_TRANSACTION_POSTED_DATE_KEY] as char(8)) as date) as transDatePosted,
       sum(trans.TOTAL_DUE_AMOUNT) TOTAL_DUE_AMOUNT
from [EDW_PROD_SNOWFLAKE].[EDW].[F_TRANSACTION] trans
    inner join [EDW_PROD_SNOWFLAKE].[EDW].[D_TRANSACTION_TYPE] ttyp
        on ttyp.D_TRANSACTION_TYPE_KEY = trans.D_TRANSACTION_TYPE_KEY
       and ttyp.SOURCESYSTEMID = trans.SOURCE_SYSTEM_ID
    inner join [EDW_PROD_SNOWFLAKE].[EDW].[D_LOCATION] loc
        on loc.D_LOCATION_KEY = trans.D_LOCATION_ASSIGNED_KEY
where 1 = 1
  and trans.[TOTAL_DUE_AMOUNT] <> 0
  and loc.[CLOUD9_CONVERSION_DATE] >= '20240101'
  and trans.D_TRANSACTION_DATE_KEY >= '20240101'
  and trans.D_TRANSACTION_DATE_KEY <= '20250930'
  and trans.D_TRANSACTION_POSTED_DATE_KEY >= '20240101'
  and trans.D_TRANSACTION_POSTED_DATE_KEY <= '20251001'
  and cast(cast(trans.D_TRANSACTION_DATE_KEY as char(8)) as date) >= loc.[CLOUD9_CONVERSION_DATE]
  and cast(cast(trans.D_TRANSACTION_DATE_KEY as char(8)) as date) <= eomonth(loc.[CLOUD9_CONVERSION_DATE])
--and ttyp.[DESCRIPTION] not like '%[*]%' ESCAPE '\'
--and lower(ttyp.COMMENT) not like ('%balance converted%')
--and lower(ttyp.COMMENT) not like ('%converted balance%')
--and loc.FAS_IN_ORTHOFI<>'true'
--and loc.LOCATION_NAME = 'Hendersonville - Blythe'

group by loc.LOCATION_NAME,
         cast(cast(trans.D_TRANSACTION_DATE_KEY as char(8)) as date),
         cast(trans.[D_TRANSACTION_POSTED_DATE_KEY] as char(8));

```
# Snowflake
```sql

USE DATABASE EDW_PROD_SNOWFLAKE;
USE SCHEMA EDW;

SELECT
    loc.LOCATION_NAME,
    TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_DATE_KEY), 'YYYYMMDD')          AS transDate,
    TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_POSTED_DATE_KEY), 'YYYYMMDD')   AS transDatePosted,
    SUM(trans.TOTAL_DUE_AMOUNT) AS TOTAL_DUE_AMOUNT
FROM EDW_PROD.EDW.F_TRANSACTION trans
INNER JOIN EDW_PROD.EDW.D_TRANSACTION_TYPE ttyp
    ON ttyp.D_TRANSACTION_TYPE_KEY = trans.D_TRANSACTION_TYPE_KEY
   AND ttyp.SOURCESYSTEMID = trans.SOURCE_SYSTEM_ID
INNER JOIN EDW_PROD.EDW.D_LOCATION loc
    ON loc.D_LOCATION_KEY = trans.D_LOCATION_ASSIGNED_KEY
WHERE 1 = 1
  AND trans.TOTAL_DUE_AMOUNT <> 0
  AND loc.CLOUD9_CONVERSION_DATE >= '2024-01-01'
  AND trans.D_TRANSACTION_DATE_KEY     >= '20240101'
  AND trans.D_TRANSACTION_DATE_KEY     <= '20250930'
  AND trans.D_TRANSACTION_POSTED_DATE_KEY >= '20240101'
  AND trans.D_TRANSACTION_POSTED_DATE_KEY <= '20251001'
  AND TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_DATE_KEY), 'YYYYMMDD')
        >= loc.CLOUD9_CONVERSION_DATE
  AND TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_DATE_KEY), 'YYYYMMDD')
        <= LAST_DAY(loc.CLOUD9_CONVERSION_DATE)
GROUP BY
    loc.LOCATION_NAME,
    TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_DATE_KEY), 'YYYYMMDD'),
    TO_DATE(TO_VARCHAR(trans.D_TRANSACTION_POSTED_DATE_KEY), 'YYYYMMDD')
LIMIT 5;
```

# Bugs

Can't parse '0' as date with format 'YYYYMMDD'

```sql
TO_DATE() → TRY_TO_DATE()
```
