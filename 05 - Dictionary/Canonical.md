> [!info] Single Source of Truth

> “We used heuristics to map source fields, then aligned them to the canonical model.”> 

Related to [[Heuristics]]
## Side‑by‑side comparison

| Term          | Core Meaning          | Nature                  |
| ------------- | --------------------- | ----------------------- |
| **Heuristic** | A helpful shortcut    | Informal, probabilistic |
| **Canonical** | The official standard | Formal, authoritative   |


## **Canonical**

**Definition:**  
**Canonical** means *the authoritative, standard, or “single source of truth” version* of something.

It answers the question:

> “Which version is the one we trust?”

### Examples

*   **Data modeling:**  
    “This table is the **canonical customer dimension**.”
*   **BI semantics:**  
    “Use the canonical definition of revenue across all reports.”
*   **Engineering:**  
    “Convert inputs to a canonical format before processing.”

### Common uses

*   **Canonical table**
*   **Canonical definition**
*   **Canonical schema**
*   **Canonical name**

### What canonical implies

*   Preferred over alternatives
*   Stable and governed
*   Used for consistency and alignment

**One‑line summary:**

> *Canonical means the official, trusted version everyone should use.*

***

## ASCII tree — **full relationship model (with canonical layered correctly)**

```
DOMAIN REALITY
└─ Ontological Layer
   ├─ Entity
   │  ├─ patient
   │  ├─ employee
   │  ├─ location
   │  ├─ ledger-net-production
   │  ├─ contract
   │  └─ referral
   │
   ├─ Bridge (Current State)
   │  ├─ employee-work-assignment (location)
   │  └─ patient-employee-assignment (treatment-coordinator vs orthodontist)
   │
   ├─ Event
   │  ├─ appointment
   │  ├─ employee-work-assignment
   │  ├─ patient-employee-asssignment
   │  ├─ ledger-payment
   │  └─ ledger-adjustment
   │
   ├─ State
   │  ├─ patient-status
   │  ├─ appointment-status
   │  └─ contract-status
   │
   └─ Measure (semantic, not numeric storage)
      ├─ gross-production-amount
      ├─ discount-amount
      └─ net-contract-amount


SEMANTIC CONTROL
└─ Taxonomy Layer
   ├─ Taxonomy (vocabulary containers)
   │  ├─ appointment-type
   │  ├─ referral-type
   │  ├─ referral-type-group
   │  ├─ ledger-payment-type
   │  └─ ledger-adjustment-type
   │
   └─ Classification-value (leaf values)
      ├─ cash
      ├─ credit-card
      ├─ refund
      ├─ reversal
      ├─ void
      └─ no-show


INTERPRETATION / LOGIC
└─ Derived Layer
   ├─ Derived classifications
   │  ├─ appointment-past-v-future
   │  ├─ payment-overpayment
   │  ├─ contracts-net-zero
   │  └─ contracts-pre-conversion
   │
   └─ Derived measures
      ├─ outstanding-balance
      └─ capacity-utilization


AUTHORITY & GOVERNANCE (orthogonal)
└─ Canonical Designation
   ├─ Canonical Entities
   │  ├─ canonical-patient
   │  └─ canonical-contract
   │
   ├─ Canonical Events
   │  ├─ canonical-ledger-payment
   │  └─ canonical-ledger-adjustment
   │
   ├─ Canonical Measures
   │  ├─ canonical-gross-production
   │  └─ canonical-net-contract
   │
   └─ Canonical Taxonomies
      ├─ canonical-referral-type
      └─ canonical-appointment-type
```

---
