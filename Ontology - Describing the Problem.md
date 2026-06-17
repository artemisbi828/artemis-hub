related-to: [[Heuristics → Ellipsis → Perspective Drift]]

# Framing the Problem: Why Our Metrics Feel Less Stable Than Our Data

As a company growing at ~30% year over year, our greatest constraint is no longer data availability—it is **semantic stability**.
We have invested heavily in data precision, pipelines, and platforms. Yet our reporting and governance practices have not matured at the same pace. 

This has created a **metric maturity gap**: the organization increasingly relies on numbers whose meanings are assumed rather than explicitly defined, stable, and shared.
The result is not bad data—but **fragile meaning**.
At the root of this problem is a reinforcing sequence:

> **Heuristics → Ellipsis → Perspective Drift**

Each step is rational on its own. Together, they quietly erode trust, consistency, and scalability.

* * *

## Heuristics: Speed Wins—Until It Doesn’t

**Heuristics** are practical rules of thumb—experience‑based shortcuts used when exact methods are impractical, unknown, or too costly.
They favor:
*   speed over precision
*   “good enough” over optimal
*   judgment over formal proof
**Key idea:** heuristics are helpful, but **they are not guarantees**.
In a fast‑moving organization, heuristics are essential. But as the organization scales, heuristics begin to hard‑code assumptions that no longer hold uniformly across teams, time horizons, or systems.

* * *

## Ellipsis: Meaning Lost Through Compression
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

## Perspective Drift: When Everyone Is Right—and Still Misaligned

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

### Why This Matters Now

This pattern scales quietly—until it doesn’t.
As we grow:
*   Metrics diverge without anyone intending them to
*   Definitions require tribal knowledge to interpret
*   Trust shifts from systems to individuals
The organization becomes fast, but brittle.



# Describing the Problem: Ontology Blur
Shortcomings
## **Ontological Gaps**

> Boundaries between entities, attributes, and derivations become unclear.

- Sounds academic but precise
- Good for concept modeling discussions
- Signals taxonomy damage, not people failure
### Contextual Reuse
Has multiple equally valid “is‑a” parents
Removing one parent loses meaning
Very rare in operational data models

### Definition Decay
A definition weakens as it is reused without its original qualifiers.

- Very close to your instinct (“definition culture decay”)
- Clear cause → effect framing
- Easy to contrast with “definition hardening”
- Excellent pairing term for remediation work

### Conceptual Erosion
Concepts lose precision through repeated reuse without redefinition.

### Metric Maturity Gap
A mismatch between available data precision and reporting practices.


### Operational Ambiguity
Ambiguity is embedded into processes and metrics to preserve stability.

### Category Leakage

> Properties or filters leak into the category structure itself.

- Extremely accurate for your “dismissed_new_patient_exam” case
- Very memorable
- Highlights structural misuse
### Hierarchy Substitution

> Hierarchy is used to encode rules instead of ontology.

- Directly diagnoses the modeling anti-pattern
- Pairs well with “definition belongs in logic, not hierarchy”

### Semantic Rot
Data Governance Failure

✅ Semantic Compression & Perspective Drift
Our primary failure modes.

✅ Definition Decay due to Institutionalized Ellipsis
Root cause statement.

✅ Narrative Lock-In masking Analytical Maturity
Perfectly describes the conversion-rate situation.

✅ Hierarchy Substitution caused by Ontological Blur
Great for modeling retrospectives.

“Most of our issues aren’t data quality problems — they’re semantic drift caused by institutionalized ellipsis and reinforced by narrative lock‑in.”

# Ontological vs Derived Classification
---
## Ontological
Nouns. Sometimes adjectives. It just "is". These concepts desribe what exists and are intrinsic.
An **ontological concept** exists **by definition**, not by evaluation. 
They are not computed, inferred, or filtered -- they simply are, whether or not they are observed or measured.

Ontological concepts may take the form of:
*   entities (e.g., patient, contract)
*   events (e.g., appointment, ledger‑transactions) 
*   states (e.g., appointment‑status, contract‑status)
*   relationships (e.g., patient‑employee assignment)

They have clear conceptual boundaries and mutually exclusive where required. They do not need a Boolean column to explain what they are.

### Properties

No evaluation logic required. Time-variance via lifecycle is allowed. Is at *point-in-time*.
*   Independent of time windows
*   Independent of thresholds
*   Independent of data completeness
*   Not “locked” or “evaluated”

## Derived (Derived Classification)

Derived concepts evaluate facts. They are inferred using logic, thresholds, comparisons, state or combinations of them.
*   patient: child or adult
*   contracts: case start / add-on only

### Properties

If you need a verb phrase - it is _not_ ontology.
*   “derived from”
*   “measured by”
*   “classified as”
*   “filtered by”
*   “based on”

> _Predicates select rows._  
> _Measures aggregate rows._  
> _Metrics compose measures._

### If the concept…

*   **selects rows** (yes/no membership test)
    *   `concept_class` → `classification-value`
    *   `concept_role` → `predicate`
*   **aggregates rows** (count, sum, rate)
    *   `concept_class` → `measure`
    *   `concept_role` → `aggregation`

### Summary Concept Map

    ONTOLOGICAL DOMAINS
    ├─ Entities
    ├─ Events
    ├─ States
    └─ Relationships
    
    SEMANTIC LAYER (Ontological or Derived)
    ├─ Taxonomies
    └─ Classification-values
    
    DERIVED LOGIC
    ├─ Predicates (set definitions)
    └─ Measures (aggregations)
    
    METRICS
    └─ Metrics = composed measures
		 + predicates
		 + scope rules

# Mixed Assignment Patterns
--------------------------
### Taxonomies (vocabularies)
- Define allowed values
- Organize meaning

```
concept_class: taxonomy
concept_role: vocabulary
ontological_status:
  - ontological (asserts reality)
  - derived (interprets facts)
```


### Leaf values (enums)

*   Values within a taxonomy
```
concept_class: classification-value
concept_role: null
```

### Relationships

```
concept_class: bridge
concept_role: relationship
ontological_status: ontological
```


### Attributes and States

*   Descriptive or lifecycle properties
```
concept_class: state
concept_role:
  - null        → ontological
  - attribute   → ontological
  - predicate   → derived (e.g., inferred outcomes)

```

* * *

### Reinforcement

    concept_role = null

Means the concept:
*   is not directly used for filtering or aggregation
*   still plays a critical semantic role  
    (entities, events, states, vocabularies, enums)

* * *

### Mutability ≠ Derivation

Records may change without changing their ontological nature.
Examples:
*   patient‑status
*   employee‑work‑assignment
*   contract‑status
*   location assignment
**Mutability does not imply derivation.**