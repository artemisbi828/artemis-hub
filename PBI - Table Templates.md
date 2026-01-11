![[Pasted image 20260111110125.png]]
### OFC TEMPLATE
OfficeKey
Name
RollUp

### EMP TEMPLATE
EmployeeKey
Email
CommonName, FirstName, LastName
ManagerEmployeeKey
JobTitleKey

### ODS TEMPLATE -- 
DateKey
OfficeKey
Production_TotalAmount
Collection_TotalAmount → TrendingPerformance
CaseStart_NetProduction_TotalAmount
CaseStart_TotalCount
CaseStart_ConversionCount
CaseStart_AutoPay_IsStartedCount
CaseStart_AutoPay_IsCandidateCount
CaseStart_DownPaymentAmount
AppointmentsHistoric_NPETotalCount → dnm-showUpRate
AppointmentsHistoric_NPEDismissedCount → nmr-showUpRate

### GUIDANCE
Flags are prefixed → "Is"
SUMS → TotalAmount ($)
If it can be calculated (eg AverageCaseFee (CS_TotalAmount/CS_TotalCount) , NonCaseStartProduction (NetPDX - CS_TotalAmount)
OfficeNameAlias → sdrs.OfficeNameAlias
TeamNameAlias → sdrs.Teams (will also store team imgs)