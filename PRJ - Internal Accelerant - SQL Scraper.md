We have (M) versions running around we need to consolidate and review. 
Speed up Refactoring Queries and working w SQL
- normalize
	- remove all brackets
	- lines start w `from` and `join` 
- find the objects



```
#1 create a python script that takes an input file path and creates an dir called "output_sqlscraper" in the same dir of the input
output_filename: "20250113_0956AM" (current timestamp)
#2 get all objects referenced, this was my manual method: 
1. any lines start with "from" and "join" go to the right of that word boundary → select everything to the end of the line
2. put in a separate tab, trim trailing and leading spaces
3. remove all brackets "[, ]"
4. to the right of it, after a space, remove everything to the end of the line to remove any aliases
5. get a distinct list (remove dupes) → send to output.
#3 create a distinct list of any functions called in the script → add that to the output
#4 review "select" and "where" sections, if an object is not being referenced in those, they are unnecessary → append " (Junk)" to the output list the distinct list in output with + MyObject (Junk)
#5 output a distinct list of any parameters used → add a new section "Variables"
#5 output the original script with corrections



TARGET INPUT
```sql
use LHS_DEV_JONAS

declare @startdate date = '2025-12-01'; -- input monthkey
declare @enddate date = dateadd(month, 1, @startdate);
declare @officekey int = (select top 1 OfficeKey from EDW.bi.vw_D_Offices as [ofc] where ofc.OfficeName like '%Alpharetta%');
declare @startdateint int = replace(@startdate, '-', '');
declare @enddateint int = replace(@enddate, '-', '');


with cte1
as (select
        convert(date, convert(varchar, [FC].[D_START_DATE_KEY]), 112) as [DateKey],
        [EO].[OfficeKey],
        pat.patID,
        pat.DateOfBirth,
        sum(FC.IS_CONTRACT_SDS) as [CaseStart_IsSDSCount],
        count(*) as CaseStart_Total,
        'Cloud9' as SourceType
    from [Snowflake].[vw_dbo_F_CONTRACT] FC
        join [SnowFlake].[dbo].[D_TRANSACTION_TYPE] DT
            on [FC].[D_CONTRACT_TRANSACTION_TYPE_KEY] = [DT].[D_TRANSACTION_TYPE_KEY]
        join [SnowFlake].[dbo].[D_LOCATION] DL
            on [FC].[D_LOCATION_ASSIGNED_KEY] = [DL].[D_LOCATION_KEY]
        join [EDW].[bi].[Offices] EO
            on [DL].[GL_CODE] = [EO].[OfficeCode]
        -- get patient
        join CentralC9.dbo.TreatmentFeePlan as tfp
            on tfp.SourceSystemId = FC.SOURCESYSTEMID
           and tfp.tfpGUID = FC.CONTRACT_ID
        join Lake.C9.PersonAggregate as pat
            on pat.SourceSystemId = tfp.SourceSystemId
           and pat.patGuid = tfp.patGUID
    where [DT].[IS_ORIGIN_OF_START] = 1
      and [FC].[D_START_DATE_KEY] >= @startdateint
      and [FC].[D_START_DATE_KEY] < @enddateint
      and (EO.OfficeKey = @officekey or @officekey is null)
    group by convert(date, convert(varchar, [FC].[D_START_DATE_KEY]), 112),
             [EO].[OfficeKey],
             pat.patID,
             pat.DateOfBirth
    union all
    select
        [c].[DateKey],
        [c].[OfficeKey],
        pat.patID,
        pat.DateOfBirth,
        sum(iif([c].[IsContractSDS] = 1, 1, 0)) as [CaseStart_IsSDSCount],
        count(*) CaseStart_Total,
        'OrthoFi' as SourceType
    from [sd].[Contracts] [c]
        join [sd].[ContractKeys] [ck]
            on [ck].ContractKey = [c].[ContractKey]
        left join bi.Persons as p
            on p.PersonKey = c.PersonKey
        left join Lake.C9.PersonAggregate as pat
            on pat.SourceSystemId = p.ssid
           and pat.patGuid = p.patGuid
    where [c].[DateKey] >= @startdate
      and [c].[DateKey] < @enddate
      and [ck].Orthofi_ContractId is not null
      and c.IsCaseStart = 1
      and (c.OfficeKey = @officekey or @officekey is null)
    group by [c].[DateKey],
             [c].[OfficeKey],
             pat.patID,
             pat.DateOfBirth)
```

TARGET OUTPUT
CentralC9.dbo.TreatmentFeePlan
EDW.bi.Offices
EDW.bi.Persons
EDW.bi.vw_D_Offices
EDW.sd.ContractKeys
Lake.C9.PersonAggregate
Lake.C9.PersonAggregate
sd.Contracts
SnowFlake.dbo.D_LOCATION
SnowFlake.dbo.D_TRANSACTION_TYPE
Snowflake.vw_dbo_F_CONTRACT
```