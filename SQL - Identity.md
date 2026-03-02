SavePoint: still cleaning the oneNote\`Add Identity; Reseed`

```sql
-- check identity
dbcc checkident(@tablename);

-- to transfer a table with identity, you must CREATE A NEW TABLE
set identity_insert docm.Keywords on -- default off; tur it on 
set identity_insert docm.Keywords off -- turn it back off after
```

```sql
ALTER proc std.usp_ResetTableIdentity (@tablename nvarchar(250)) as
declare @SqlStatement nvarchar(max);
declare @maxseed int;

-- 1. Dynamically retrieve the maximum existing key value
set @SqlStatement = N'SELECT @MaxSeedOUT = ISNULL(MAX([CommandKey]), 0) ' + N'FROM ' + @tablename + N';';
exec sp_executesql
    @SqlStatement,
    N'@MaxSeedOUT INT OUTPUT',
    @MaxSeedOUT = @maxseed output;

dbcc checkident(@tablename, reseed, @maxseed);
dbcc checkident(@tablename);
GO

-- 2. How to use It
begin tran
dbo.usp_MonthlyAttributes1_IsNewPatient_IsVestedStartMonth_ManagerReview;

select * from std.ProcNames as pn
select * from std.ProcLogs as pl

-- ** here we're rolling the seed back since we're testing **
rollback tran

exec std.usp_ResetTableIdentity
    'std.ProcNames';
```



#open-loop/quick-paste-merge-later 

```sql
declare @tablename nvarchar(128) = N'dbo.Commands';
declare @SqlStatement nvarchar(max);
declare @maxseed int;

-- 1. Dynamically retrieve the maximum existing key value
set @SqlStatement = N'SELECT @MaxSeedOUT = ISNULL(MAX([CommandKey]), 0) ' + N'FROM ' + @tablename + N';';
select @SqlStatement;
exec sp_executesql
    @SqlStatement,
    N'@MaxSeedOUT INT OUTPUT',
    @MaxSeedOUT = @maxseed output;

set @maxseed = @maxseed + 1;
dbcc checkident(@tablename, reseed, @maxseed);
dbcc checkident(@tablename);
```




The procedure sp_executesql is a system stored procedure used to execute a T-SQL statement from a dynamic string. It is the preferred method for dynamic SQL because it allows you to separate the command structure from the data values, which prevents SQL injection attacks and allows SQL Server to efficiently reuse execution plans.
It accepts three main arguments, as you highlighted:
1. @SqlStatement (The Command)
SQL

@SqlStatement -- N'SELECT @MaxSeedOUT = ISNULL(MAX([CommandKey]), 0) FROM dbo.Commands;'
This is the string containing the T-SQL command you want to execute dynamically.
2. Parameter Definition String (The Blueprint)
SQL

N'@MaxSeedOUT INT OUTPUT'
This is the second parameter, and it acts as the formal definition of the parameters used inside the dynamic SQL string. It is a comma-separated list of parameter names and their data types, just as if you were defining them for a stored procedure.
	• @MaxSeedOUT: This name is used internally within the dynamic @SqlStatement.
	• INT: This defines the data type of the internal parameter.
	• OUTPUT: This keyword is vital. It tells the dynamic query engine that the value assigned to @MaxSeedOUT inside the dynamically executed statement should be passed back out to the calling environment.
3. Parameter Value Assignment (The Mapping)
SQL

@MaxSeedOUT = @MaxSeed OUTPUT
This is the third and subsequent parameters, where you map the values between the calling environment (your main script) and the dynamic statement's environment.
	• @MaxSeedOUT: This is the formal parameter name defined in the second argument.
	• @MaxSeed: This is your local variable from the main script (DECLARE @MaxSeed INT;).
	• OUTPUT: This keyword on the local variable must match the OUTPUT keyword in the parameter definition string (the second argument). It tells the main script to accept the returned value from the dynamic execution and place it into your local @MaxSeed variable.

Summary of the Flow
	1. Define: You define a local variable @MaxSeed in your Canvas script.
	2. Execute: You call sp_executesql.
	3. Dynamic Execution: SQL Server executes the SELECT MAX() command, which assigns the result to the internal parameter @MaxSeedOUT.
	4. Mapping: The OUTPUT mapping tells SQL Server to take the value from the internal @MaxSeedOUT and place it into the external, local variable @MaxSeed.
This allows the dynamic query to be executed efficiently while safely passing data back and forth without needing to concatenate user-provided values directly into the main SQL string.