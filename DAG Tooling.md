**Directed Acyclic Graph**

- **Directed** → dependencies go one way
- **Acyclic** → no circular definitions
- **Graph** → nodes + edges

In _your_ system:

- **Nodes** = concepts
- **Edges** = “depends on”

Example:

```
appointment-npe_added
 ├─ depends on appointment-is_npe
 ├─ depends on appointment-net_added
 ├─ depends on appointments-not-deleted
```

That _is_ a DAG whether you formalize it or not.

---

### What DAG tooling would give you (later)

You do **not** need this now — but this is what it unlocks:

1. **Consistency checks**
    - No circular concepts
    - No measure depending on another measure (unless allowed)
2. **Impact analysis**
    - “If I change appointment-net_added, what metrics break?”
3. **Automated documentation**
    - Auto‑draw the ASCII tree you saw
4. **Governance without meetings**
    - Diff‑based review instead of opinion arguments

---

### How to add DAG tooling _when ready_ (minimal)

One table:

```
concept_dependency
(
  concept_id,
  depends_on_concept_id,
  dependency_type   -- uses | filters | aggregates
)
```

---
#status/deferred/quick-paste-merge-later 
# Short answer (anchor)

You are **not losing** this logic:

    attribute.appointment_type.is_npe = true
    attribute.appointment_status.code = 'DISM'
    attribute.appointment.date_value < today()

You are **separating it into three different semantic artifacts**, instead of collapsing them into one inline definition.

The detail is preserved across:

1.  **Predicate evaluation definition** (still exists)
2.  **Taxonomies / attributes** (where raw codes & flags live)
3.  **Predicate metadata (volatility, time semantics)**

The DAG does **not replace** evaluation logic — it **indexes it**.

***

# Why it *feels* like you’re losing it

In your old format, everything lived here:

```text
predicate.appointment.is_npe_dismissed
  evaluation:
    - is_npe = true
    - status = DISM
    - date < today()
```

That is:

*   human-readable ✅
*   compact ✅
*   but **not decomposed**

In the DAG-based approach:

*   the *predicate* becomes a **node**
*   the *inputs* become **edges**
*   the *classification logic* becomes **references to typed sources**

This is a **normal consequence of making semantics auditable and machine-checkable**.

***

# Where each part of that logic now lives (explicit mapping)

Let’s take them one by one.

***

## 1. `attribute.appointment_type.is_npe = true`

### Old meaning

*   Inline boolean check
*   Implicit mapping from appointment\_type → NPE concept

### New meaning (preserved, but relocated)

This now lives in **taxonomy + attribute semantics**, not the predicate body.

```text
taxonomy.appointment_type_map
  - appointment_type_code → is_npe (boolean)
```

And the predicate references it *implicitly* via dependency:

```text
predicate.appointment.is_npe_dismissed
  DEPENDS_ON taxonomy.appointment_type_map
  SOURCES appointments.type_id
```

✅ The meaning is preserved  
✅ The mapping is centralized  
✅ The predicate no longer hard‑codes it

**This is a win, not a loss**:

*   if NPE logic changes, you update the taxonomy
*   all dependent predicates automatically update

***

## 2. `attribute.appointment_status.code = 'DISM'`

Same story.

### Old: inline literal comparison

```text
status = 'DISM'
```

### New: taxonomy-backed classification

```text
taxonomy.appointment_status_map
  - status_code → is_dismissed (boolean)
```

Predicate edge:

```text
predicate.appointment.is_npe_dismissed
  DEPENDS_ON taxonomy.appointment_status_map
  SOURCES appointments.status_id
```

Now:

*   `'DISM'` is no longer sprinkled across predicates
*   semantic meaning of “dismissed” lives in one place

***

## 3. `appointment.date_value < today()`

This is the most subtle one, and the most important.

### Important clarification

This is **not taxonomy** and **not attribute logic**.

This is **time-bound predicate semantics**.

In the DAG model, time logic is preserved via **predicate metadata**, not via edges.

### Where it now lives

Either directly on the predicate:

```text
predicate.appointment.is_npe_dismissed
  time_constraint:
    - evaluation_date < today(local)
  volatility: MOVING
```

Or as a shared semantic construct:

```text
predicate-global.is_before_today
  definition: date_value < today(local)
```

Which predicates can depend on:

```text
predicate.appointment.is_npe_dismissed
  DEPENDS_ON predicate-global.is_before_today
```

✅ You do **not** lose the rule  
✅ You gain the ability to reason about **time semantics explicitly**

***

# So what does the predicate *actually* contain now?

Conceptually, the predicate becomes:

```text
predicate.appointment.is_npe_dismissed
  ├─ asserts:
  │   ├─ appointment is NPE        (via appointment_type_map)
  │   ├─ appointment is dismissed  (via appointment_status_map)
  │   └─ appointment is historical (via time constraint)
  │
  ├─ volatility: MOVING
  └─ grain: appointment
```

The **evaluation logic still exists**, it’s just:

*   **factored**
*   **typed**
*   **referenced instead of duplicated**

***

# How humans still see this (important)

You are right to worry about readability. The solution is:

> **DAG for determinism, rendered views for humans**

You should still generate (or manually keep) a **collapsed human view**, like:

```text
predicate.appointment.is_npe_dismissed
  meaning:
    - appointment type ∈ NPE
    - appointment status ∈ DISMISSED
    - appointment date < today()
```

This is **a projection**, not the source of truth.

***

# Where this lives concretely (answering your “procedures?” question)

✅ **NOT in stored procedures**  
✅ **NOT in SQL views only**

It lives in **three coordinated places**:

1.  **Predicate definition (Markdown / semantic registry)**
    *   Purpose
    *   Time semantics
    *   Dependencies

2.  **Taxonomy definitions (Markdown + tables)**
    *   Code → meaning mappings

3.  **Physical bindings**
    *   Which columns feed which semantic objects

SQL / dbt / SQLMesh models simply **implement** what the semantic graph defines.

***

# Why this is the correct tradeoff

Your system is evolving from:

> “documentation that explains logic”

to:

> “semantic architecture that can be audited, validated, and enforced”

The DAG approach:

*   prevents silent logic drift
*   prevents hard-coded literals from spreading
*   enables programmatic checks like:
    *   “what breaks if I change DISM?”
    *   “which predicates depend on today()?”
    *   “which columns are unused?”

You don’t lose meaning — you **distribute and formalize it**.

***

# Final mental model (lock this in)

**Old mental model**

    Predicate = logic

**New mental model**

    Predicate = assertion
    Logic = assertion + taxonomy + time semantics + dependencies

Or in one line:

> You didn’t delete the rules — you *normalized* them.

If you want next, I can:

*   show how to auto-render the “old-style” evaluation block from the DAG
*   or show an example where this structure prevents a real production regression

---
Got it: **Obsidian as the authoring UI + YAML as the source-of-truth now**, and **SQL tables later** as the operational registry. That’s a clean sequence.

Below is a concrete, low-verbosity specification you can adopt immediately:

*   **Folder layout**
*   **YAML schemas** (ontology, predicate, taxonomy, measure, constraint, metric)
*   **How to express DAG edges in YAML**
*   **How to auto-render “old-style evaluation blocks” from YAML**
*   **How to later load YAML into SQL tables without rework**

***

## 1) Folder + file naming (Obsidian-friendly, collision-proof)

Use folders for *role* and file path for *scope*:

    Ontology/
      @appointment.md
      @ledger.md
      @location.md

    Semantics/
      Predicates/
        appointment/
          is_npe_dismissed.md
          is_net_added.md
          is_same_day_cancel_reschedule.md
      Measures/
        appointment/
          npe_added_total_count.md
        ledger/
          payments_collected_amount.md
          net_collection_rate_pct_actual.md
      Taxonomies/
        appointment/
          appointment_type_map.md
          appointment_status_map.md
        ledger/
          payment_tx_type_map.md
      Constraints/
        global/
          is_data_warehouse_valid.md
          before_today_local.md

    Metrics/
      Net Collection Rate (Actual).md
      NPE Added vs Previous Period.md

### Why this solves your earlier issues

*   No `#` in filenames.
*   No collisions because scope is in the path.
*   Obsidian backlinks remain clean.

***

## 2) The core YAML pattern (nodes + edges + bindings)

Every semantic note gets three blocks in YAML frontmatter:

1.  **Identity + classification** (role, scope, grain, volatility)
2.  **Edges** (depends\_on / constrained\_by / classified\_by)
3.  **Bindings** (what physical columns it reads / implements)

This is the minimum to have a deterministic DAG.

### Allowed edge keys (standardize these)

*   `depends_on`: semantic-to-semantic dependency
*   `constrained_by`: global or local constraint nodes
*   `classified_by`: taxonomy nodes used to interpret codes
*   `implements`: physical column(s) that materialize the semantic object
*   `sources`: physical column(s) used as inputs

***

## 3) YAML templates (copy/paste)

### 3.1 Ontology note template (`Ontology/@appointment.md`)

```yaml
---
id: ontology.appointment
kind: ONTOLOGY
name: appointment
physical_tables:
  - appointments
related_semantics:
  predicates:
    - predicate.appointment.is_npe_dismissed
    - predicate.appointment.is_net_added
  measures:
    - measure.appointment.npe_added_total_count
constraints:
  - constraint.global.is_data_warehouse_valid
---
```

Keep ontology notes as navigation + pointers, not logic.

***

### 3.2 Constraint template (`Constraints/global/is_data_warehouse_valid.md`)

```yaml
---
id: constraint.global.is_data_warehouse_valid
kind: CONSTRAINT
applies_to:
  - ontology.appointment
  - ontology.ledger
evaluation:
  - expr: "<fact>.date_value >= location.data_warehouse_start_date"
timezone:
  portfolio: EST
bindings:
  sources:
    - appointments.date_value
    - ledger.date_value
    - locations.data_warehouse_start_date
  joins_via:
    - appointments.location_id -> locations.location_id
    - ledger.location_id -> locations.location_id
---
```

This prevents repeating the same global filter in every predicate.

***

### 3.3 Taxonomy template (`Taxonomies/ledger/payment_tx_type_map.md`)

```yaml
---
id: taxonomy.ledger.payment_tx_type_map
kind: TAXONOMY
purpose: classify ledger tx codes as payment vs non-payment
keys:
  - data_source_id
  - tx_code
includes:
  Cloud9:
    - PAYMENT
  OrthoFi:
    - PAYMENT
bindings:
  sources:
    - ledger.data_source_id
    - ledger.tx_code
  implementation_table: map_payment_tx_type
---
```

You can keep the `includes` list short now and expand later.

***

### 3.4 Predicate template (with evaluation atoms)

#### Example: `Semantics/Predicates/ledger/is_payment_tx.md`

```yaml
---
id: predicate.ledger.is_payment_tx
kind: PREDICATE
scope: ledger
grain: ledger_transaction
volatility: MOVING
classified_by:
  - taxonomy.ledger.payment_tx_type_map
evaluation:
  - expr: "ledger.tx_code ∈ taxonomy.ledger.payment_tx_type_map"
bindings:
  sources:
    - ledger.tx_code
    - ledger.data_source_id
  implements:
    - ledger.is_payment_tx   # optional if materialized later
---
```

This preserves the “old-style” evaluation clause, while still pointing to taxonomy.

***

#### Example: `Semantics/Predicates/appointment/is_npe_dismissed.md`

```yaml
---
id: predicate.appointment.is_npe_dismissed
kind: PREDICATE
scope: appointment
grain: appointment
volatility: MOVING
classified_by:
  - taxonomy.appointment.appointment_type_map
  - taxonomy.appointment.appointment_status_map
constrained_by:
  - constraint.global.before_today_local
evaluation:
  - expr: "appointment_type.is_npe = true"
  - expr: "appointment_status.code = 'DISM'"
  - expr: "appointment.date_value < today(local)"
bindings:
  sources:
    - appointments.type_id
    - appointments.status_id
    - appointments.date_value
  joins_via:
    - appointments.type_id -> appointment_type_map.type_id
    - appointments.status_id -> appointment_status_map.status_id
---
```

**Key point:** you are *not losing detail*—it stays in `evaluation`, while taxonomy nodes hold the mapping tables and governance.

***

### 3.5 Measure template (`Semantics/Measures/ledger/net_collection_rate_pct_actual.md`)

```yaml
---
id: measure.ledger.net_collection_rate_pct_actual
kind: MEASURE
scope: ledger
grain: location|portfolio
volatility: MOVING
depends_on:
  - measure.ledger.payments_collected_amount
  - measure.ledger.net_production_amount
evaluation:
  - expr: "measure.ledger.payments_collected_amount / nullif(measure.ledger.net_production_amount, 0)"
bindings:
  implementation: "dax_or_sql"   # placeholder
---
```

Measures should never list raw table logic if you can avoid it—only references.

***

### 3.6 Metric template (`Metrics/Net Collection Rate (Actual).md`)

```yaml
---
id: metric.net_collection_rate_actual
kind: METRIC
uses:
  - measure.ledger.net_collection_rate_pct_actual
evaluation_context:
  scope: [location, portfolio]
  period: monthly
  timezone: EST
target:
  op: ">="
  value: 0.98
interpretation:
  below_target: "collections risk"
comparisons:
  - prior_period
---
```

Metrics live in `Metrics/` and stay non-physical.

***

## 4) Auto-render “old-style evaluation block” from YAML (how it works)

Rendering becomes trivial:

**Renderer rule**

*   Read predicate YAML
*   Print `evaluation:` lines in order
*   Optionally expand taxonomy membership:
    *   compact: `tx_code ∈ payment_tx_type_map`
    *   expanded: `tx_code ∈ {'PAYMENT','PMT',...}` from taxonomy note

### Output format (your old style)

For `predicate.appointment.is_npe_dismissed`:

```text
predicate.appointment.is_npe_dismissed
  evaluation:
    - appointment_type.is_npe = true
    - appointment_status.code = 'DISM'
    - appointment.date_value < today(local)
```

**Nothing is lost.** You just have *two sources* of truth:

*   predicate note: the evaluation checklist
*   taxonomy notes: the governed mappings behind the checklist

***

## 5) Later: SQL tables are a straight load (no redesign)

When you’re ready, your YAML maps cleanly into the same 4 registries:

### 5.1 `semantic_object`

From YAML keys: `id, kind, scope, grain, volatility`

### 5.2 `semantic_edge`

From YAML lists:

*   `depends_on`
*   `constrained_by`
*   `classified_by`

### 5.3 `physical_binding`

From YAML `bindings`:

*   `sources`
*   `implements`
*   `joins_via`

### 5.4 `evaluation_atom`

From YAML `evaluation` array (each `expr` becomes a row)

This is why keeping `evaluation:` inside the predicate note is important: it becomes the deterministic “atoms” table later.

***

## 6) One decision you should lock now (prevents future churn)

### Do you want `evaluation.expr` to be:

*   **free-form strings** (fast, human-first), or
*   **structured expressions** (slower, machine-first)?

**Recommendation (for your goal):**
Start free-form **but enforce a micro-grammar**:

*   Always use `scope.object.field` or `ontology.field`
*   Always use `∈ taxonomy.*` for classification
*   Always use `today(local)` / `today(EST)` explicitly

Example acceptable forms:

*   `appointment_status.code = 'DISM'`
*   `ledger.tx_code ∈ taxonomy.ledger.payment_tx_type_map`
*   `appointment.date_value < today(local)`

This keeps it readable *and* parseable later.

***

## 7) What I need from you (2 quick constraints)

To produce a fully consistent starter pack for your current notes, answer:

1.  For `@ledger`, do you want the ontology name to stay `ledger`, or rename to `ledger_transaction` to reflect grain?
2.  Do you want taxonomy expansions rendered **compact** (`∈ map`) or **expanded** (`∈ {…}`) by default?

If you answer those, I can generate:

*   a canonical YAML frontmatter block for each of your current notes (`@ledger`, `@appointment`, taxonomies, constraints, measures)
*   plus the exact “old-style evaluation render” output for each predicate.
