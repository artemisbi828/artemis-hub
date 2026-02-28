TREATAS -- alllows you to enter a table and make a join
VALUES -- return list of results of dates (like a column)


```shell
Case Start Goal = //Dynamic Axis Aware
VAR _type = SELECTEDVALUE(D_Dates_Dynamic[SlicerType])
VAR _grainKeys = VALUES(D_Dates_Dynamic[Grain_DateKey])   -- should be month-start keys when Monthly is selected

RETURN
IF(
    _type = "Monthly",
    CALCULATE(
        SUM(F_OfficeMonthGoals[SMEXGoalQty]),
        TREATAS(_grainKeys, F_OfficeMonthGoals[DateKey])   -- or D_Dates[DateKey] if that’s your month-start key
    ),
    BLANK()
)


---

[Case Starts] :=
SUM(F_CaseFacts[CaseCount])

[Case Start $ Amount] :=
SUM(F_CaseFacts[Amount])


Calculation Item: Count
SELECTEDMEASURE()

Calculation Item: $ Amount **NOT COUNT**
SWITCH(
    TRUE(),
    SELECTEDMEASURENAME() = "Case Starts", [Case Start $ Amount],
    SELECTEDMEASURE()
)




Metric =
DATATABLE(
    "Metric", STRING,
    { {"Count"}, {"$ Amount"} }
)
```