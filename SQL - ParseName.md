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