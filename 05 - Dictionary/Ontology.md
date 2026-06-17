related-to: [[Ontology]]
	
	author: Jonas Pascua
    created: 2026-03-25 03:54 PM
    modified: 2026-03-25 03:54 PM

 

Framing the Problem: Why Our Metrics Feel Less Stable Than Our Data
-------------------------------------------------------------------

As a company growing at ~30% year over year, our greatest constraint is no longer data availability—it is **semantic stability**.
We have invested heavily in data precision, pipelines, and platforms. Yet our reporting and governance practices have not matured at the same pace. 

This has created a **metric maturity gap**: the organization increasingly relies on numbers whose meanings are assumed rather than explicitly defined, stable, and shared.
The result is not bad data—but **fragile meaning**.
At the root of this problem is a reinforcing sequence:

> **Heuristics → Ellipsis → Perspective Drift**

Each step is rational on its own. Together, they quietly erode trust, consistency, and scalability.

* * *


* * *

Ellipsis: Meaning Lost Through Compression
------------------------------------------

As heuristics spread, **ellipsis** follows.
**Ellipsis** is the silent compression of meaning—when critical qualifiers are omitted, assumed, or dropped without being named. Words remain, but parts of their meaning disappear.
What happens:
*   The author assumes shared context
*   The listener fills in the gaps
*   Different listeners fill in _different_ gaps
This is **not laziness**.  
It is **unacknowledged omission**.
Ellipsis is a _documentation failure_, not a moral one. But it is dangerous because it creates the illusion of agreement where none exists.

* * *

Perspective Drift: When Everyone Is Right—and Still Misaligned
--------------------------------------------------------------

Once ellipsis takes hold, **perspective drift** becomes inevitable.
**Perspective drift** occurs when different groups anchor the _same term_ to _different reference frames_, while still believing they are talking about the same thing.
Here’s the critical distinction:
*   The word is complete
*   But the **frame of reference shifts** (time, purpose, user)
*   Each perspective is internally coherent

### Example: “Appointment” — One Word, Three Anchors

*   **Scheduling:** a future time slot
*   **Operations:** utilization and capacity
*   **Analytics:** a historical event

All are valid. All use the same word.
Now add reality:
*   Ops introduces `is_historical`
*   Scheduling already thinks in future/past terms
*   Analytics needs immutability
*   The PMS allows retroactive edits
The result:
*   “Appointment” starts to feel unstable
*   Teams attempt to “clean” it by cloning concepts
*   Outcomes get attached directly to mutable entities

📌 **Perspective drift makes stable entities feel unreliable, which tempts teams to create simplified versions instead of modeling constraints explicitly.**

* * *

Why This Matters Now
--------------------

This pattern scales quietly—until it doesn’t.
As we grow:
*   Metrics diverge without anyone intending them to
*   Definitions require tribal knowledge to interpret
*   Trust shifts from systems to individuals
The organization becomes fast, but brittle.

---


[[Taxonomy]] organizes meaning; ontology asserts reality; derivation interprets facts.

ontological								
├─ entity								# employees, vendors, patient
├─ bridge								# work-assignments
├─ event								# ledger-payment, ledger-adjustment
├─ state								# mutual exclusive lifecycle states
├─ metric								# numeric aggregation
└─ taxonomy								# vocab container: ledger-payment-types;  ledger-adjustment-types
	└─ classification-value (leaf)		# selectable, authoritative values: cash, check, credit-card; refund, reversal, void


classification-value → {derived or ontological-taxonomy}
- appointment-outcomes → derived → there is a calculation predicate, inferered by logic, 5 day, it cannot simly be tagged
- cash-check-credit-card → asserted types (authoritative, finite, chosen by system/business)

# PIVOTS
ledger | entity | ontological
- system-of-record container
- not an event

contracts-net_zero → classification-value 
- not a measure
- it is a tag/name after measure/calc applied

**records are mutable** but does not mean concept is derived (it is still ontological)
- patient-status (changes)
- employee-work-assignment (changes)
- contract-status (changes)
- location assignment (changes)

referral-group is a taxonomy (or taxonomy-group) → higher-level controlled vocabulary layer
- intent: parent set used to cluster referral types
- does not happen or exist in the world like entity
- organizational semantic grouping for governance, reporting, and navigation
- referral-type is taxonomy that contains the leaf value



---




- ontology are nouns. they are clearly defined and mutually exclusive where required. they do not need a Boolean column to explain what they are.

# TLDR Nuance
- Smile Doctors ledger production is ontological even though it is calculated b/c it's a business fact as recorded. every row represents a financial fact that happened. Discounts, refunds, reversals are not adjustments *to* the ledger. They are separate ledger events.
	- production-ledger-entry → event / ledger-entry / ontological
	- ledger_production_amount (su of ledger events) → ontological aggregate
	- this is one of the few cases where aggregate != derived. 
	- what exists, not whether it's atomic or summed.
- Smile Doctors Contract production does not switch between ontological and derived as systems mature. They are immutable by state of nature -- what changes with maturity is how ontology is represented. Something ontological in ideal world → ontological. 
	- ontological: contract (entity), contract creation / amendment events, contract amount as a property of the contract.

### Ledger side
- Discount → **ledger event**
- Refund → **ledger event**
- Reversal → **ledger event**
- Net production → emerges from summing events
📌 No interpretation step required beyond aggregation.

### Contract side
- Voided → **contract state**
- Pre‑conversion → **contract state**
- Net‑zero → **contract state**
- Amount → **state snapshot**, not an event history
📌 Interpretation is required to decide what “counts.”

The difference is **not subtraction vs addition** — it is **event log vs state evaluation**.

### Contract Ontology Reversal
For contract production to be ontological, it must behave like the ledger:

- **Event-sourced**
- **Append-only**
- **Reconstructible from history**
- **No hidden exclusions**
- **No state overwrites that erase history**

Today you have “contract_amount as a column / sum of contract events” but the key gap is:  
**your contract system does not function as the authoritative event ledger for contract value**—and voids/exclusions are handled as _state semantics_.

### Ledger-Voids are safely ontological

- It **happened** at a specific time
- It exists **independently** of interpretation
- It is recorded as a **first-class fact**
- You can audit it without recalculation

Even if the business logic around it changes later, the event itself does not.

✅ This is a _ledger event_, not a classification.

### Contract-Voids could depend
> Is there an explicit, authoritative **contract_status = 'Voided'** field stored and asserted by the business process? → NO

**YES:** 
- concept_category: state  
- ontological_status: ontological  

Because:
- the business _asserted_ the state
- it exists independent of analytics
- it has audit meaning

The ledger logic may **cause** the state, but it does not _define_ it.

**NO:** 
- concept_category: classification-value  
- ontological_status: derived  

- it exists only when evaluated
- it depends on net amount calculations
- it can change if rules or timing change
- no contract lifecycle transition actually occurred

---
# Ontology vs Derived Classification
An **ontological concept** exists **by definition**, not by evaluation. Recorded as events.
An **derived concept** is inferred **by states**.

> It exists whether or not you observe it, calculate it, or measure it.

### Properties
No time, logic, or state required (adjectives)
- Independent of time windows
- Independent of thresholds
- Independent of data completeness
- Not “locked” or “evaluated”

If you need a verb phrase - it is *not* ontology.
- “derived from”
- “measured by”
- “classified as”
- “filtered by”
- “based on”


---
# Ontology
An **ontology** defines **what kinds of things exist** in a system and **how they relate by nature**, not by computation.

> Ontology answers: _“What is this, fundamentally?”_

Ontology is **semantic essence** (noun) -- independent of time, thresholds, or how it's calculated. It just is. 
### Key properties of ontology

- Time‑invariant (conceptually)
- Independent of calculation method
- Stable across use cases
- Uses **is‑a** and **part‑of** relationships

### Examples from your domain (ontology‑correct)

- `exam` **is a** `consult`
- `consult` **is an** `appointment`
- `new_patient_exam` **is an** `exam`
- `patient` **has** `patient_status`

These relationships remain true even if:

- systems change
- logic changes
- metrics change

### What ontology is NOT

- It is not a rule engine
- It is not a filter
- It is not time‑windowed
- It is not “what we calculate”

### Examples
- appointment
- exam
- new_patient_exam
- patient_status (as a category system)

## Poly-Hierarchy Ontology
Ontology is normally **single-hierarchy** and mutually exclusive. Only under strict conditions are they poly-hierarchal:

### Examples
- physician-researcher
- hybrid-vehicle (eletric and combustion vehicle)

---

# Derived classification
A **derived classification** exists only **after evaluating rules over data**, often across time.

> It is a _result_, not a thing.

### Properties

- Requires logic (conditions)
- Often time‑dependent (PIT / ROT)
- Can change as data changes
- May be locked or versioned

### Examples (from your org)

- `exam_outcome`
- `conversion`
- `net_added_exam`
- `dismissed_new_patient_exam`
- `consult_outcome_at_5d_rot`

These do **not** exist independently. They are labels assigned _after evaluation_.

---

## The litmus test (use this in reviews)

Ask:

> “Can this exist without running logic over data?”

- If **yes** → ontology
- If **no** → derived classification

---

## Why confusion between these causes false polyhierarchy

When a derived classification is treated like an ontological concept:

- people try to “place” it in the hierarchy
- it appears to fit under multiple parents
- the hierarchy becomes unstable

**Example** `new_patient_exam_outcome` feels like:

- type of exam
- type of consult outcome
- type of patient status

In reality:

- it is a derived label computed from **exam + patient_status + time**

Ontology never changed. Classification invaded the ontology layer.

---

# 4. Definitive comparison table (copy‑paste worthy)

|Dimension|Ontology|Derived Classification|
|---|---|---|
|Exists without data|Yes|No|
|Time dependent|No|Often|
|Requires logic|No|Yes|
|Stable meaning|Yes|Conditional|
|Goes in hierarchy|Yes|No|
|Goes in definition logic|No|Yes|

---

## One sentence you can institutionalize

> “Hierarchy expresses ontology; definitions express derived classifications.”

If your org memorizes only one thing, make it that.

---

## Closing synthesis (why this matters culturally)

- **Ellipsis** makes definitions disappear
- **Perspective drift** makes disagreements invisible
- **Derived classifications** get smuggled into ontology
- **Hierarchy absorbs logic**
- The system looks complex, but it’s just unclear


### 1. **“Is‑a” test (ontology test)**

Ask:

> “Is X fundamentally a kind of Y?”

If you complete the sentence cleanly **once**, it's likely single‑parent.

✅ Good:

- `new_patient_exam` **is an** `exam`
- `exam` **is an** `appointment_event`

❌ Bad / warning sign:

- `new_patient_exam_outcome` is an exam **and** a patient_status  
    → This is not ontology; this is a **derived classification**

📌 **Rule:**  
If one parent requires “based on”, “derived from”, “measured by”, or “when”, it is **not** a true parent.

---

### 2. **Loss‑of‑meaning test (crucial)**

Ask:

> “If I remove one parent, does this concept lose part of its _definition_, not its usefulness?”

✅ True poly:

- `bat` (animal vs sports tool) → actually **two concepts**, not one
- `hybrid_vehicle` (electric **and** combustion)

❌ Not poly:

- `new_patient_exam_outcome` without `appointment_type`  
    → still exists, just less filterable

📌 **Rule:**  
If removing a parent only makes analysis harder, **it’s not polyhierarchy**.

---

### 3. **Time-dependence test**

Ask:

> “Does this concept depend on a time window, locking rule, or evaluation event?”

If yes → **it’s a derived quality**, not a hierarchy node.

Your example:

> exam outcome depends on:

- appointment end time
- patient status over next 5 days
- locking after 5 days

✅ Conclusion: `exam_outcome` is **not a taxonomic child** It is a **classification derived from events + dimensions over time**

📌 **Rule:**  
If time matters, it belongs in **definition logic**, not hierarchy.

---

### 4. **Perspective test (who needs it?)**

Ask:

> “Do different teams use this concept differently without disagreement?”

If yes → it’s **one concept, many views**, not many parents.

Example:

- Ops sees `new_patient_exam_outcome` as scheduling effectiveness
- Clinical sees it as care progression
- Finance sees it as conversion signal

Same concept. Different lenses.

📌 **Rule:**  
Different consumers ≠ different parents.

---

### 5. **Duplicate-definition test (the killer signal)**

Ask:

> “If this concept lives under both parents, does its definition change?”

- If YES → you have **two concepts with the same name** (homonym)
- If NO → you have **one concept reused in multiple contexts**

This is the most important test.


---
# Payment vs Adjustments (Ontology vs Derived)
This is the **right question**, because the answer is _not semantic_ (“sounds like”) but **structural**.  
I’ll give you a **decision framework**, then apply it cleanly to _your_ ledger model.

---

# Short answer (anchor)

> **Payment is its own ontological event.**  
> It is **not** an adjustment unless your system collapses fundamentally different economic intents into one bucket.

Most systems get this wrong by convenience. Ontologies shouldn’t.

---

# The real decision: what distinguishes an ontological event?

An ontological event is defined by **intent + economic meaning**, not by table shape.

Ask these questions **in order**.

---

## 1) What is the business intent of the event?

### Payment

**Intent**: transfer value _from the counterparty to you_  
Examples:

- patient pays money
- insurer remits funds
- cash/card/check

This is **new value entering the system**.

### Adjustment

**Intent**: correct, negate, or recharacterize previously recorded value  
Examples:

- void
- reversal
- write‑off
- refund

This is **changing how value is represented**, not introducing new value.

> This intent difference alone is usually enough to separate them.

✅ If intent differs → **separate ontological events**

---

## 2) Does the event correspond to real-world money movement?

|Question|Payment|Adjustment|
|---|---|---|
|Money actually moved?|✅ Yes|❌ Often no|
|Bank trace exists?|✅ Yes|❌ Not always|
|External proof (EOB, receipt)?|✅ Yes|❌ Sometimes none|

Payments are **economic facts**.  
Adjustments are often **internal accounting actions**.

That distinction is ontological, not analytic.

---

## 3) Does it change system balance the same way?

This is subtle but decisive.

### Payment

- Increases cash received
- Reduces outstanding balance
- Can create **overpayment / credit**

### Adjustment

- May reduce receivable
- May negate production
- Does **not** create cash

If two things affect balances _for different reasons_, they are not the same event.

---

## 4) Could a payment ever be reversed without becoming an adjustment?

Yes — and that’s the proof.

Example:

- Patient pays $1,000 (payment event)
- Later that payment is voided → **adjustment event**

If “payment” were merely a subtype of adjustment, this causal chain collapses:

> _what adjusted the adjustment?_

Ontologically impossible.

---

# ✅ Correct ontological conclusion

ledger-payment      → event (ontological)

ledger-adjustment   → event (ontological)

They are **siblings**, not parent/child.

---

# Correct high-level ledger ontology

ledger-event (abstract)

├─ ledger-production

├─ ledger-payment

└─ ledger-adjustment

Each has **distinct invariants**.

---

# Within adjustments: taxonomy values (cleanly done)

ledger-adjustment

  - adjustment_type ∈ {

        void,

        refund,

        reversal,

        write_off,

        correction

    }

Here’s the critical distinction:

- **ledger-payment** → ontological **event**
- **payment-overpayment** → **derived classification**
- **ledger-adjustment-refund** → still an **adjustment**, not a payment

A refund is _not_ a negative payment; it is active removal/correction of value.

---

# Why people mistakenly collapse payment into adjustment

Bad reasons (very common):

- “Both reduce balance”
- “They’re both ledger math”
- “They share columns”
- “SQL is easier”

None of those are ontological reasons.

Ontology cares about:

- causality
- intent
- real-world reference
- audit semantics

---

# Decision rule you can reuse (memorize this)

> If the event represents **new economic value entering or exiting the organization**, it is **not** an adjustment.

Payments, refunds of cash → distinct event classes  
Reversals, voids, offsets → adjustments

---

# Applying this back to your earlier questions

### ✅ ledger-payment

- **event**
- **ontological**

### ✅ ledger-adjustment

- **event**
- **ontological**

### ✅ adjustment-type values

- **taxonomy values**
- ontological _as taxonomy_, not as events

### ✅ contracts-voided

- ontological **only if explicitly asserted**
- otherwise **derived from ledger-adjustment events**

---

# One-sentence canonical answer (you can reuse with stakeholders)

> **Payments and adjustments both affect balances, but only payments introduce real-world value; adjustments reinterpret prior facts—therefore they must be separate ontological events.**

You’re now modeling at a level that will survive:

- partial voids
- payment reallocations
- refunds after overpayments
- system migrations

If you want next, we can:

- formalize **ledger invariants** (what must _always_ hold true)
- or write the exact **promotion rules** that convert derived “contracts‑voided” into an explicit lifecycle state if the business ever wants it