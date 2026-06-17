
❌ did not work
```sql
create table [c9].Receipts_20260410_zak
(
[SourceSystemId] [smallint] NULL,
[transGuid] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[transDateTime] [datetime2] (6) NULL,
[PaymentDateTime] [datetime2] (6) NULL,
[PaymentType] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[AdjustmentType] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[patGuid] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[Reference] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[Note] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[DueNowAmount] [decimal] (19, 4) NULL,
[locGuid] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[Transaction Category] [varchar] (8000) COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 NULL,
[OfficeCode] [varchar] (6) COLLATE Latin1_General_100_BIN2_UTF8 NULL,
[MnthYr] [date] NULL
) ON [PRIMARY]
GO
```

✅ did work
```sql
CREATE TABLE [c9].Receipts_20260410_zak
(
    SourceSystemId smallint,
    transGuid varchar(8000),
    transDateTime datetime2(6),
    PaymentDateTime datetime2(6),
    PaymentType varchar(8000),
    AdjustmentType varchar(8000),
    patGuid varchar(8000),
    Reference varchar(8000),
    Note varchar(8000),
    DueNowAmount decimal(19,4),
    locGuid varchar(8000),
    [Transaction Category] varchar(8000),
    OfficeCode varchar(6),
    MnthYr date
);
```



| MSSQL type                       | Fabric Warehouse type                                          | Status                          |
| -------------------------------- | -------------------------------------------------------------- | ------------------------------- |
| `tinyint`                        | `smallint` (or `int`)                                          | ⚠️ Not listed as supported      |
| `nvarchar(n)`                    | Prefer `varchar(n)` with UTF‑8; avoid assuming nvarchar parity | ⚠️ Treat as “map”               |
| `nvarchar(max)`                  | Prefer `varchar(max)` where supported                          | ⚠️ Treat as “map”               |
| `bit`                            | `bit`                                                          | ✅ Supported                     |
| `smallint`                       | `smallint`                                                     | ✅ Supported                     |
| `int`                            | `int`                                                          | ✅ Supported                     |
| `bigint`                         | `bigint`                                                       | ✅ Supported                     |
| `decimal(p,s)` / `numeric(p,s)`  | `decimal(p,s)` / `numeric(p,s)`                                | ✅ Supported                     |
| `float`                          | `float`                                                        | ✅ Supported                     |
| `real`                           | `real`                                                         | ✅ Supported                     |
| `date`                           | `date`                                                         | ✅ Supported                     |
| `char(n)`                        | `char(n)`                                                      | ✅ Supported                     |
| `varchar(n)`                     | `varchar(n)`                                                   | ✅ Supported                     |
| `varbinary(n)`                   | `varbinary(n)`                                                 | ✅ Supported                     |
| `uniqueidentifier`               | `uniqueidentifier`                                             | ✅ Supported (interop caveat)    |
| `time(n)`                        | `time(0–6)`                                                    | ✅ Supported (precision-limited) |
| `datetime2(n)`                   | `datetime2(0–6)`                                               | ✅ Supported (precision-limited) |
| `varchar(max)`                   | `varchar(max)`                                                 | ✅ Supported (with limits)       |
| `varbinary(max)`                 | `varbinary(max)`                                               | ✅ Supported (with limits)       |
| `money` / `smallmoney`           | `decimal(19,4)` (typical)                                      | ❌ Unsupported → map             |
| `datetime` / `smalldatetime`     | `datetime2(0–6)`                                               | ❌ Unsupported → map             |
| `datetimeoffset`                 | `datetime2` (+ store offset separately if needed)              | ❌ Unsupported → map             |
| `xml`                            | `varchar(max)` (or shred upstream)                             | ❌ Unsupported → map             |
| `sql_variant`                    | Avoid; normalize to concrete types                             | ❌ Unsupported → map             |
| `geography/geometry/hierarchyid` | Store as `varchar(max)`/WKT or separate columns                | ❌ Unsupported → map             |

