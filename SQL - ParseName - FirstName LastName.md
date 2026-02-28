2026-02-25 03:07 PM -- Cleaned up AD Group and used AI to create a cleaner to prevent this error: 

> [!error] Invalid length parameter passed to the LEFT or SUBSTRING function.

```sql
select Member from cte2
	cross apply (select CleanMember = nullif(trim(cte2.Member), '')) m
    cross apply (select SpacePos = charindex(' ', m.CleanMember)) p
    cross apply (
    select
        FirstNameParsed = case when m.CleanMember is null then null
                               when p.SpacePos = 0 then m.CleanMember -- no space; treat whole as FirstName
                               else left(m.CleanMember, p.SpacePos - 1) end,
        LastNameParsed = case when m.CleanMember is null then null
                              when p.SpacePos = 0 then null -- no space; no LastName
                              else ltrim(substring(m.CleanMember, p.SpacePos + 1, 8000)) end
) n
    left join Lake.sd.Employees as e2
        on e2.FirstName = n.FirstNameParsed
       and e2.LastName = n.LastNameParsed
       and u.UserPrincipalName is null
```

# Older


Originally designed to break down SQL object names (e.g., `Server.Database.Schema.Table`), `PARSENAME` is often "borrowed" by developers to split strings because it is incredibly fast and concise.

- **How it works:** It looks for periods (`.`) and returns the segment at the specified index (counting from right to left, 1 to 4).
    
- **The Limitation:** It only works for up to 4 segments and requires the delimiter to be a period.
    

**Example for Names:** If you have "Amy.Middle.Cortinas", `PARSENAME` can grab them instantly. To use it with spaces, you just `REPLACE` the space with a dot.

However, it fails if the name contains an actual period (like "Jr.") or more than 3 spaces.


```sql
DECLARE @name VARCHAR(100) = 'Amy B Cortinas';
-- Reverse logic: 1 is the last part, 2 is middle, 3 is first
SELECT 
    PARSENAME(REPLACE(@name, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(@name, ' ', '.'), 2) AS MiddleInitial,
    PARSENAME(REPLACE(@name, ' ', '.'), 1) AS LastName;
```