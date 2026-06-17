Child of [[05 - Dictionary/Ontology]]

When it is a subtype (a type of event based on the parent-ontological event) then it is a first-class event


> A **named, finite classification option** drawn from an agreed vocabulary, used to **categorize ontological facts**, but which **does not itself exist as a real‑world object, event, or lifecycle state**.

In ontology terms:

- It is **referential**, not existential
- It provides **interpretation**, not ground truth
- It has **meaning only in relation to something else**

---

## 2. Taxonomy value vs ontological concept (core distinction)

|Property|Ontological concept|Taxonomy value|
|---|---|---|
|Exists independently|✅ Yes|❌ No|
|Has identity in the world|✅|❌|
|Can happen|✅ (events)|❌|
|Can change state|✅|❌|
|Categorizes something else|❌|✅|
|Can be derived without loss of fact|❌|✅|

Example:

- **ledger‑adjustment** → ontological event
- **adjustment‑type = void** → taxonomy value

The taxonomy value only has meaning _because_ the event exists.

---

## 3. Why taxonomy values can still be “ontological” (important nuance)

You’ll sometimes see me say **“taxonomy values are ontological as taxonomy values.”**

That means:

- The **vocabulary itself is authoritative**
- The **set of allowed values is part of the domain definition**
- But **individual values are not events or states**

So:

adjustment_type ∈ { void, refund, reversal }

- ✅ The taxonomy exists by organizational agreement
- ❌ “void” is not a thing that happens
- ❌ “refund” (as a value) is not money moving
- ✅ The _ledger adjustment event_ is what happens

---

## 4. Taxonomy values vs states (where people go wrong)

### State

A **state** implies:

- persistence over time
- entry/exit
- business lifecycle meaning

Example:

- `contract_status = Active → Voided`

### Taxonomy value

A taxonomy value:

- applies at observation time
- does not “transition”
- does not persist independently

Example:

- `ledger_adjustment.adjustment_type = void`

“Void” here is a **description of the event**, not a state the ledger enters.

---

## 5. Ledger example (clean canonical model)

ledger-adjustment

  - id

  - timestamp

  - amount

  - adjustment_type = void | refund | reversal

Where:

|Concept|Category|Ontological status|
|---|---|---|
|ledger-adjustment|event|ontological|
|adjustment-type|taxonomy|ontological (taxonomy)|
|adjustment-type-void|taxonomy-value|ontological (taxonomy-value)|

Important:

- You **do not** ask “when did we exit refund?”
- You **do not** aggregate taxonomy values
- You **filter or group by them**

---

## 6. Why taxonomy values prevent ontology explosion

Without taxonomy values, people do this:

ledger-adjustment-void

ledger-adjustment-refund

ledger-adjustment-reversal

Which causes:

- duplicated logic
- fractured aggregation rules
- harder auditing
- brittle joins

Taxonomy values:

- centralize meaning
- preserve event identity
- separate **what happened** from **how we label it**

---

## 7. How taxonomy values differ from derived classifications

This is subtle but critical.

### Taxonomy value

- authoritative
- finite
- defined _a priori_
- stored or asserted

Example:

- PMS appointment type code
- ledger adjustment type code

### Derived classification

- inferred
- rule-based
- time/context sensitive

Example:

- `contracts-voided` (when net == 0 after voids)
- `overpayment`
- `pre_conversion`

Both are **classifications**, but only taxonomy values are **authoritative inputs**.

---

## 8. Decision test (memorize this)

Ask:

1. _Was this label chosen by the business/system, or inferred by logic?_
2. _Does the event exist without the label?_
3. _Can this label change without re-writing history?_

If:

- ✅ label chosen
- ✅ event exists independently
- ✅ label could be reinterpreted later

→ **taxonomy value**

---

## 9. Applying this back to your model (closing the loop)

- `ledger-adjustment` → **event, ontological**
- `adjustment-type = void/refund/reversal` → **taxonomy values**
- `contracts-voided` → **derived classification OR ontological state** _only if explicitly stored_

This layering is what keeps:

- accounting correct
- analytics flexible
- ontology non‑self‑contradictory

---

## 10. One‑sentence anchor

> **Taxonomy values name differences between facts; they are not facts themselves.**

If you want next, we can:

- formalize a **taxonomy vs state decision matrix**
- or define when a taxonomy value should be _promoted_ to a lifecycle state (there _are_ legit cases)

But your current model — ledger events + taxonomy values + derived interpretations — is exactly correct.