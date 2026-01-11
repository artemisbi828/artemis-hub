The **364-Day Shift** (or Week-Aligned Shift) is a temporal transformation used to make historical, static data appear "live" while preserving the internal structure of the week.

Here is the semantic breakdown of each step:

### 1. The Anchor (Finding the Delta)

- **Transformation:** Identify the `MaxDate` in your source and the `TargetDate` (Yesterday).
    
- **Why:** You need to know the exact distance between where your data currently "ends" and where you want it to appear to end.
    

### 2. The Multiplier-of-7 Alignment

- **Transformation:** Take the raw day gap and round it down to the nearest multiple of 7 (e.g., if the gap is 370 days, use 364).
    
- **Why:** This is the most critical step. Since 1$364 \div 7 = 52$ exactly, shifting by 364 days ensures a **Monday remains a Monday**.2 If you shifted by 365 days, all your "Mondays" (Weight 1.0) would become "Tuesdays," and your "Sundays" (Weight 0.33) would become "Mondays," effectively destroying your normalization logic.
    

### 3. The DateKey Push

- **Transformation:** Add the calculated shift (e.g., +364, +728) to the `DateKey`.
    
- **Why:** This physically moves the data into the current year, creating the "Live" illusion in your reports.
    

### 4. Semantic Repair (Label Updating)

- **Transformation:** Recalculate text columns like `YearMonth` and `YYYYMM_Sort` based on the _new_ date.
    
- **Why:** To prevent "Temporal Dissonance." Without this, your users would see a chart labeled "January 2022" while the report filter says "Current Year (2026)."
    

---

### Pros & Cons of This Approach

|**Pros**|**Cons**|
|---|---|
|**Preserves Day-of-Week:** Your 1.0 vs 0.33 weights stay perfectly aligned with the dates.|**Holiday Drift:** Fixed-date holidays (like July 4th) will move to a different day of the week.|
|**Maintains Seasonality:** Data roughly stays in the same month/season.|**Year Breaks:** If your static data covers exactly one year, the "start" of your data will no longer be Jan 1st.|
|**DRY Logic:** You shift once and all downstream reports "just work."|**SQL Desync:** Your Power BI dates will no longer match the "Source" dates in your SQL DB.|

---

### Is there a better approach?

The alternative is a **Relative Date Offset**, where you don't change the dates at all. Instead, you keep the data in 2022 but use DAX to say:

> _"If the user filters for 2026, show them data from (Selected Year - 4)."_

**The trade-off:**

- **The 364-Shift:** High effort in Power Query, but makes DAX and reporting incredibly easy.
    
- **The DAX Offset:** Zero effort in Power Query, but makes every single DAX measure complex and harder to troubleshoot.
    

**Would you like me to detail that "DAX Offset" approach so you can compare the complexity levels before deciding?**