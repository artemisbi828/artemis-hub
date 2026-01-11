```
Net Production - Case Start (K Format) = FORMAT(DIVIDE(Sum(F_OfficeDayStats[NetProduction_CaseStartAmount]), 1000, BLANK()), "$0,000.0") & " K"

FORMAT(@, "#,##0,,.0M")
```