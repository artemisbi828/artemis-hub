---
knowledge_type:
aliases:
definition: '"Does this change break anything we already rely on"'
related_object:
---
1. Define Selected Dataset (time slice + locations)

2. Create 2 tables
- bi.TestBaseline_Contracts
- bi.TestCandidate_Contracts

3. Run a diff
```sql
SELECT *
FROM bi.TestCandidate_Contracts c
FULL OUTER JOIN bi.TestBaseline_Contracts b
    ON c.ContractKey = b.ContractKey
WHERE ISNULL(c.Value, '') <> ISNULL(b.Value, '');
```

3. SME reviews diff
```
If differences are expected → update baseline.  
If differences are unexpected → fix the logic.
```

You’re looking for a term that captures:
- A defined dataset
- A repeatable testing process
- A controlled environment
- A known SME reviewer
- A comparison between “current” and “proposed”
Here are strong candidates that fit BI and data engineering culture:
### **📌 “Test Harness”**
Still valid, but more common in software engineering than BI.
### **📌 “Validation Framework”**
Clean, BI‑friendly, and implies repeatable rules + structure.
### **📌 “Regression Testing Suite”**
Perfect when your goal is: _“Does this change break anything we already rely on?”_
### **📌 “Data Quality Test Bed”**
Emphasizes the curated dataset used for testing.
### **📌 “BI Certification Pipeline”**
Used by mature analytics teams to describe the process required before a report/model is “certified.”
### **📌 “Controlled Test Slice”**
A term you can use internally to describe the fixed time range + fixed locations.
### **📌 “Reference Dataset”**
Industry term for a frozen dataset used for validation.
If you want something that sounds polished and BI‑specific, I’d go with:
### ⭐ **“BI Regression & Validation Framework”**
It’s broad enough to cover your needs and specific enough to sound intentional.