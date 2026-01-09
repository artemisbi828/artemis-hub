```PowerQuery(M)
let
    // 1. Connect to your SQL Date Table (Replace with your actual Source)
    Source = Sql.Database("YourServer", "YourDatabase", [Query="SELECT * FROM YourDateTable"]),
    
    // 2. Identify the "Anchor" (The most recent date in your static dataset)
    // We assume 2025-12-31 is your max date.
    StaticMaxDate = List.Max(Source[CalendarDate]),
    
    // 3. Identify the "Target" (Yesterday)
    TargetDate = Date.From(DateTime.LocalNow()) - #duration(1, 0, 0, 0),
    
    // 4. Calculate the Shift (How many days to move forward)
    // If Today is Jan 10 2026, Target is Jan 9. 
    // Shift = Target - StaticMax
    DateShift = Duration.Days(TargetDate - StaticMaxDate),
    
    // 5. Apply the transformation to the Date column
    ShiftedDates = Table.TransformColumns(Source, {
        {"CalendarDate", each Date.AddDays(_, DateShift), type date}
    }),

    // 6. Recalculate DayWeight if necessary 
    // (Since holidays like MLK shift dates, you may want to re-run your SQL 
    // holiday logic or DAX weights against these NEW dates)
    FinalTable = ShiftedDates
in
    FinalTable
```

