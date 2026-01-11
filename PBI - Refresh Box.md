```DAX
Refresh Check = IF(DATEVALUE(CALCULATE(MAX(F_LastRefreshed[DataLoad_LastRefreshedDateTime]))) = Today(), "☑", "☒")
```