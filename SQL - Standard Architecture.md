- all objects are all caps → easier normalization
	- tables; columns; procs; views
- avoid abbreviations

- when you're large enough or change happens a lot. then put in governance. on initial no governance. 

# SQL Formatting Definitions
```
if line starts with `insert into ` or `create table`
	line should end with `(` --> anything after insert new line
	all lines should end with `,` except for the last line
	end of statement `)` should be its own independent line and all the way to left margin
	end of statement block should always end with `;`
	block should be wrapped with 1 free line (only 1 -- if there are > 1 then reduce back to 1)
	all tables and columns are all UPPERCASE

if line starts with `delete from`
	line should end with object then new line
```

# Notes
```
FLOW:
Raw_Source --> ADF --> Parquet --> Snowflake --> Bronze --> Silver --> Gold
  Permissions: Runner Service Accounts -- Create schemas and views,

---
SOURCE QUERIES: 
  Fact in scope (eg GUID or time-period)
  Get all dims (eg all patients)

RAW: ADD
  SRC_SYS  -- source -- 
  CRT_TS -- actual created timestamp 

BRONZE: ADD
  SRC_CRT_TS -- source created timestamp -- null
  SRC_UPD_TS -- source updated timestamp -- (RAW.SD_LASTMODIFIED)
  UPD_TS -- updated timestamp -- current_timestamp

SILVER:
  CLEANSING
    string -- trim(), upper
    strip special characters -- accents, @#!
  ENRICHMENT
    merging for dim
    dedup -- windowed function / macro --> partition vs order by (prioritization)
    securing
  
GOLD: Separate concat 
  add surrogate keys
  keep SRC_SYS

---
RAW_CENTRALC9__APPOINTMENTS --> BRONZE_CENTRALC9__APPOINTMENTS
RAW_CENTRALC9__APPOINTMENT_STATUS_HISTORY --> BRONZE_CENTRALC9__APPOINTMENT_STATUS_HISTORY
RAW_CENTRALC9__SCHEDULE_VIEW --> BRONZE_CENTRALC9__SCHEDULE_VIEW
RAW_CENTRALC9__LOCATIONS --> BRONZE_CENTRALC9__LOCATIONS
RAW_CENTRALC9__PATIENTS --> BRONZE_CENTRALC9__PATIENTS
RAW_CENTRALC9__EMPLOYEES --> BRONZE_CENTRALC9__EMPLOYEES
RAW_CENTRALC9__VENDORS --> BRONZE_CENTRALC9__VENDORS
RAW_CENTRALC9__PERSONS --> BRONZE_CENTRALC9__PERSONS
RAW_LAKE__LOCATIONS --> BRONZE_LAKE__LOCATIONS
RAW_CENTRALC9__APPOINTMENT_STATUS --> BRONZE_CENTRALC9__APPOINTMENT_STATUS
RAW_CENTRALC9__APPOINTMENT_TYPES --> BRONZE_CENTRALC9__APPOINTMENT_TYPES
RAW_LOOKUP__APPOINTMENT_STATUS --> BRONZE_LOOKUP__APPOINTMENT_STATUS
RAW_LOOKUP__APPOINTMENT_TYPES --> BRONZE_LOOKUP__APPOINTMENT_TYPES
RAW_LOOKUP__TIMEZONE_ABBREVIATIONS --> BRONZE_LOOKUP__TIMEZONE_ABBREVIATIONS

---
catalog: raw_dev
table_schema: lake, centralc9, dayforce, orthofi
table_name

catalog: sqlmesh_dev
table_schema: centralc9__bronze_centralc9__person

---
Raw_Source --> ADF --> Parquet --> Snowflake --> Bronze --> Silver --> Gold
3 days bronze
 -- terraform not having grants to create schemas and views
 -- python scripts needed adjusting for bronze
 -- audits
```

```
static: documentation + resources
  menus. gallery.
  format: markdown. docusaurus
inputs: forms. polls.
  authenticated - normal weight. 
  if not, certain ones. cross calidated for dedup
  questionID + value. type. default. explanation. 
     why used? what normally people put.
  prioritize sequence.
dynamic: templates 
  1 vs M
standards
  organization. location. types
  users. persons. 
  organization_x_user: admin.
  employees. customers. vendors. 
form-setup. database. markdown output.
  bidirectional. scd2. can reenter a "rollback" edit
  

domain - basic linktree. docusaurus. 
  type. 
  pictures. 
  theme. 
  short description. long description.
  admin, curators (email) + folders. 
```
### Object Examples
```powershell
# Examples
CENTRALC9__APPOINTMENT_STATUS
CENTRALC9__APPOINTMENT_STATUS_HISTORY
CENTRALC9__APPOINTMENT_TYPES
CENTRALC9__APPOINTMENTS
CENTRALC9__EMPLOYEES
CENTRALC9__LOCATIONS
CENTRALC9__PATIENTS
CENTRALC9__PERSONS
CENTRALC9__SCHEDULE_VIEW
CENTRALC9__TRANSACTION_TYPES
CENTRALC9__VENDORS
DFN__APPOINTMENT_STATUS
DFN__APPOINTMENT_TYPES
DFN__CONTRACT_TYPES
DFN__OFFICE_MONTH_GOALS
DFN__PRODUCTION_DAY_WEIGHT
DFN__TIMEZONE_ABBREVIATIONS
DFN__TRANSACTION_TYPES
GOLD_DIM__APPOINTMENT_STATUS
GOLD_DIM__APPOINTMENT_TYPES
GOLD_DIM__CLINICS
GOLD_DIM__COST_CENTERS
GOLD_DIM__EMPLOYEES
GOLD_DIM__PATIENTS
GOLD_DIM__PERSON
GOLD_DIM__PERSON_ADDRESS
GOLD_DIM__PERSON_CONTACT_INFO
GOLD_DIM__TIMEZONES
GOLD_DIM__VENDORS
GOLD_FACT__APPOINTMENT_CL9
GOLD_FACT__APPOINTMENT_NPE_ADDED_CL9
GOLD_FACT__APPOINTMENT_NPE_DISMISSED_CL9
GOLD_FACT__CONTRACT_CL9
GOLD_FACT__CONTRACT_OFI
GOLD_FACT__TRANSACTION_CL9
LAKE__EMPLOYEES
LAKE__LOCATIONS
LAKE__WORK_ASSIGNMENTS
SILVER_CENTRALC9__APPOINTMENT_STATUS
SILVER_CENTRALC9__APPOINTMENT_TYPES
SILVER_CENTRALC9__EMPLOYEES
SILVER_CENTRALC9__LOCATION
SILVER_CENTRALC9__PATIENTS
SILVER_DFN__APPOINTMENT_TYPES
SILVER_DFN__PRODUCTION_DAY_WEIGHT
SILVER_DFN__TIMEZONE_ABBREVIATIONS
SILVER_DIM__APPOINTMENT_STATUS
SILVER_DIM__APPOINTMENT_TYPES
SILVER_DIM__CALENDAR
SILVER_DIM__CLINICS
SILVER_DIM__COST_CENTERS
SILVER_DIM__EMPLOYEES
SILVER_DIM__ISO_WEEK
SILVER_DIM__PATIENTS
SILVER_DIM__PERSON
SILVER_DIM__PERSON_ADDRESS
SILVER_DIM__PERSON_CONTACT_INFO
SILVER_DIM__TIMEZONES
SILVER_DIM__VENDORS
SILVER_LAKE__EMPLOYEES
SILVER_LAKE__LOCATION
SILVER_ORTHOFI__PATIENTS
```
