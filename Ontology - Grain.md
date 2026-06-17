## TLDR (EIL5)

- **Grain = what one row actually means**
- Everything inherits meaning **upward** from grain
- You cannot “fix” grain problems with DAX, SQL, or logic

```
Wrong Grain → Wrong Measure → Wrong Metric → Wrong Decision
```

---

## Common Grain Anti‑Patterns (Mental Traps)

- ❌ Counting rows without stating grain
- ❌ Summing amounts on non‑transaction tables
- ❌ Mixing appointment‑grain measures with patient‑grain measures
- ❌ Ratios without verifying same base grain

---

## Self‑Check Questions (Learning Oriented)

Ask **before writing logic**:

- “What real‑world thing does **one row represent**?”
- “If I duplicate a row, does reality change?”
- “Does this aggregation preserve or distort reality?”
- “Would this metric break if grain changed?”


## Grain Mental Model (End‑to‑End)

```
REALITY (What actually happens)
└─ Atomic Event
   └─ "One appointment occurred at a specific time"

LOGICAL GRAIN (Business Truth)
└─ Business Grain Statement
   ├─ One row = One Appointment
   ├─ One row = One Patient per Day
   └─ One row = One Financial Transaction

PHYSICAL GRAIN (Table Level)
└─ TABLE
   ├─ appointments
   │  └─ Grain: 1 row per appointment_id
   │
   ├─ patient_daily_snapshot
   │  └─ Grain: 1 row per patient_id per date
   │
   └─ financial_transactions
      └─ Grain: 1 row per transaction_id

ATTRIBUTE GRAIN (Column Semantics)
└─ COLUMN Meaning Depends on Table Grain
   ├─ completed_flag
   │  └─ Means: "Was *this appointment* completed?"
   │
   ├─ charge_amount
   │  └─ Means: "Dollar value of *this transaction*"
   │
   └─ case_started_flag
      └─ Means: "Did *this appointment* start a case?"

MEASURE GRAIN (Math Validity)
└─ Aggregation Assumptions
   ├─ Count(*) 
   │  └─ Counts rows ≈ counts grain units
   │
   ├─ Sum(charge_amount)
   │  └─ Valid only if grain = transaction
   │
   └─ Ratio
      └─ Only valid if numerator & denominator are
         ✅ same grain
         ✅ or intentionally reconciled grains

METRIC GRAIN (Decision Integrity)
└─ Metric Interpretability
   ├─ Weekly Exam Conversion Rate
   │  ├─ Base grain: appointment
   │  └─ Time grain: week
   │
   └─ Benchmark Validity
      └─ Benchmarks only comparable
         when grain matches
```

---
#status/deferred/quick-paste-merge-later 


> [!definition] 
> It is the lowest level at which the measure is semantically valid without further aggregation.

Answers at what level a statement is true. It is about resolution, not existence. 
- "One row per what does this apply to?"

It references ontology but is not itself ontology. 
[[net_collection_rate_pct_actual]] can be calculated at the patient level, but:

- It is **not comparable across patients**
- It is unstable for patients with partial lifecycle
- It mixes timing mismatches (production vs later payments)
- Finance would not accept this as “the” net collection rate

That tells you something critical:

> **This measure is not semantically defined at patient grain.**

What you computed is a _diagnostic ratio_, not the canonical KPI.

---
Ask this:

> Can I line up two patients and say “this one is better” based on this number alone?

For Net Collection Rate, the answer is **no**, unless:

- Both patients are confirmed “closed”
- No further payments are expected
- Write‑offs are finalized

But you **do not** have that guarantee for arbitrary patients at `now()`.

Therefore:

> Patient is **not an atomic comparison unit** for this measure.

And **grain requires atomic comparability**.
999

You asked:

> _“When evaluated as a snapshot in time, it is comparable — right?”_

No, because:

- Snapshot freezes _time_, not _process_
- Patients are **mid‑process vs end‑process**
- Freezing does **not normalize lifecycle completion**

A patient snapshot lacks a crucial dimension:

> **Expected future collections**

Without that, the ratio is inherently asymmetric.

---
# Why this _does_ work at location / portfolio grain

At higher grains:

## 4.1 Lifecycle effects cancel out statistically

When aggregating:

```
location_net_collection_rate =
    sum(all payments)
    /
    sum(all production)
```

You are combining:

- Early patients
- Late patients
- Written‑off patients
- Completed patients

The lifecycle distribution becomes part of the _population_, not a contaminant.

This transforms the question from:

> “How good is this specific patient’s collections right now?”

to:

> “How effective is our system at converting production into cash over the cohort?”

That second question **is stable, comparable, and meaningful**.

---

## 4.2 This is why finance accepts portfolio‑level NCR

Finance KPIs assume:

- Sufficient volume
- Lifecycle coverage
- Temporal smoothing

Patient‑level NCR violates all three.

---

# 5. The formal rule you were circling (state it explicitly)

Here is the rule you can safely encode:

> A measure cannot declare grain **X** if differences at **X** are dominated by _process stage_, not _performance_.

Or even sharper:

> If a value’s variance is primarily explained by **where an entity is in its lifecycle**, it cannot be the grain.

This is exactly the case for patient‑level net collection rate.