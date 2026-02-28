
Font: [Segoe UI, Size: 10]

[[PBI - Colors]]
Standards
Panel Dividers
Certified Logo

Grains & Boundaries: 
- Date Scope
	- Month to Month: Month
	- Dynamic Date w Date → Grain: Date
- Extended Date Scope Main Scope of Interest 
	- has YoY → less 1 Year
	- has FutureGoal → Predictions
Dimensions: 
- ~~DateKey~~ --> Date
- ~~OfficeKey~~ → ~~OfficeCode~~ → LocationCode
Dynamic Dates: 
- build off of D_Dates
- D_Dates: IsTrailingNMonths, IsTrailinNWeeks, IsTrailingNDays (N: 12, 10)
Features: 
- [[DAX- Refresh Box|Refresh Box]]
- [[DAX - AsOfDate]]
- [[DAX - Same Store Sales (SSS)|SSS]] - 
- [[DAX - Work Day Equivalent (WDE)|WDE]] -  
- Data Dictionary 


> [!info] Current Month
> If data lags by 1 day, on 2026-03-01, should show yesterday (not today) as Current Month since there is no data to say with the 1-day-lag. Also, should we show current? 

