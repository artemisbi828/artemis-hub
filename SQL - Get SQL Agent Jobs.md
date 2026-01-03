```sql
	• sysjobhistory -- past 2 days 
	• sysjobhistoryall -- everything (2022-10-12)
-- union [sysjobhistory] with [sysjobhistoryall]
 
set tran isolation level read uncommitted;
 
/*
use msdb;
exec sp_start_job  'EDW.BI - Load'
*/
 
-- 
select
    [jb].[name] JobName,
    [a].[step_id],
    [a].[step_name],
    case [a].[run_status]
         when 0 then '0-Failed'
         when 1 then '1-Succeeded'
         when 2 then '2-Retry'
         when 3 then '3-Canceled'
         when 4 then '4-InProgress'
         else cast([a].[run_status] as varchar(16))end [RunStatus],
    dateadd(hour, -5, msdb.dbo.agent_datetime([a].[run_date], [a].[run_time])) RunDateTime,
    convert(varchar(128), dateadd(second, [a].[run_duration], 0), 108) as 'Duration_hhmmss'
from msdb.dbo.[sysjobhistory] as a
    inner join msdb.dbo.sysjobs as jb
        on [jb].[job_id] = [a].[job_id]
where 1 = 1
  and [jb].[name] in ('EDW.BI - Load')
union
select
    [jb].[name] JobName,
    [a].[step_id],
    [a].[step_name],
    case [a].[run_status]
         when 0 then '0-Failed'
         when 1 then '1-Succeeded'
         when 2 then '2-Retry'
         when 3 then '3-Canceled'
         when 4 then '4-InProgress'
         else cast([a].[run_status] as varchar(16))end [RunStatus],
    dateadd(hour, -5, msdb.dbo.agent_datetime([a].[run_date], [a].[run_time])) RunDateTime,
    convert(varchar(128), dateadd(second, [a].[run_duration], 0), 108) as 'Duration_hhmmss'
from msdb.dbo.sysjobhistoryall as a
    inner join msdb.dbo.sysjobs as jb
        on [jb].[job_id] = [a].[job_id]
where 1 = 1
  and [jb].[name] in ('EDW.BI - Load')
--and [a].[run_status] = 0 -- only looking for failures
order by [RunDateTime] desc;
```
