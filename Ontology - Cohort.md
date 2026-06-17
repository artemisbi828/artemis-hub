Parallel to the **grain** model.  
Focus: **grouping logic over time**, why cohorts exist, and where people break their mental model.

---
## TLDR (EIL5)

- **Cohort = who entered _when_**
- Cohorts **freeze the denominator** at entry
- Time then moves **forward relative to cohort start**

```
Cohort ≠ Filter
Cohort = Membership + Time Origin
```

---

## Key Distinctions (Where People Break)

|Concept|Wrong Mental Model|Correct Mental Model|
|---|---|---|
|Time|Calendar‑based|Relative to cohort entry|
|Population|Grows/shrinks|Fixed at entry|
|Filtering|Slice data|Assign identity|
|Re‑assignment|Allowed|**Never allowed**|

---

## Common Cohort Anti‑Patterns

- ❌ Using appointment date as cohort date
- ❌ Letting entities appear in multiple cohorts
- ❌ Comparing different cohort sizes without normalization
- ❌ Mixing calendar metrics with cohort metrics
- ❌ Recomputing cohort membership dynamically

---

## Self‑Checks (Learning Oriented)

Ask these **before trusting a cohort metric**:

- “Can this entity ever change cohorts?” → **No**
- “Is my denominator fixed at entry?” → **Must be**
- “Am I comparing cohorts formed the same way?” → **Required**
- “Is time relative (Week 0, Week 1) or absolute (calendar)?” → **Be explicit**

---

## Grain vs Cohort (One‑Line Contrast)

```
Grain = what one row means
Cohort = which group an entity permanently belongs to
```

If you want next, I can:

- Combine **grain + cohort into a single guardrail diagram**
- Map this directly to **Power BI modeling patterns**
- Build a **cohort violation checklist** for reviews

## Cohort Mental Model (End‑to‑End)

```
REALITY (What actually happens)
└─ Entity Enters a State
   └─ "A patient has their first exam"
      (this moment is irreversible)

COHORT DEFINITION (Business Truth)
└─ Cohort Rule
   ├─ Entry Event
   │  └─ First Exam Date
   │
   ├─ Inclusion Criteria
   │  ├─ New Patient = TRUE
   │  └─ Not previously treated
   │
   └─ Assignment Rule
      └─ An entity belongs to ONE cohort
         based on first qualifying event

COHORT ASSIGNMENT (Logical Layer)
└─ Cohort Key
   ├─ cohort_date = First Exam Date
   ├─ cohort_week = Week of First Exam
   └─ cohort_month = Month of First Exam

PHYSICAL REPRESENTATION (Table Level)
└─ TABLE
   ├─ patients
   │  └─ cohort_date (derived, immutable)
   │
   ├─ appointments
   │  └─ joined to patient cohort
   │
   └─ fact_case_lifecycle
      └─ carries cohort attributes forward

MEASURE BEHAVIOR (Cohort‑Aware Math)
└─ Measures Scoped by Cohort
   ├─ Cohort Size
   │  └─ Count(distinct patient_id)
   │
   ├─ Conversion by Week N
   │  └─ Case Starts within N weeks
   │
   └─ Retention / Decay
      └─ % remaining active vs original cohort

METRIC INTERPRETATION (Decision Layer)
└─ Cohort‑Based Metrics
   ├─ "Week‑4 Exam → Case Conversion"
   │  ├─ Base population fixed at cohort entry
   │  └─ Numerator evolves over time
   │
   └─ Benchmark
      └─ Compare like‑for‑like cohorts only
```

---

