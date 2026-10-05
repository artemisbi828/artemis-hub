Ontological: System agnostic. Not dependent on any columns or flags.
Epistemic: Data vs Heuristics (Observations)
Semantics: Context and Bridges 


[[Ontology - Describing the Problem]]
[[Ontology - Analytical Ontology]]
[[Ontology - Metrics Used For]]


| [Ontology - Predicates]                | selects rows; answers "yes/ no" as-of an evaluation time<br>- TRUE, FALSE<br>- logical primary; column secondary                                                             |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Ontology - Measures]                  | aggregates rows; counts answers; is_numeric<br>- answers "how much / how many" over a set of records<br>- COUNT, SUM, AVG, ratio<br>- depends on predicates (not vice-versa) |
| [[Ontology - Metrics]                  | composes measures                                                                                                                                                            |
| [[Ontology - Attribute vs Predicates]] | descriptive property of an entity. does **not** answer anything. <br>- column.<br>- can be used by predicates.<br>- **cannot** be used by measures                           |

[[Ontology - Grain]]
[[Ontology - Cohort]]
[[Ontology - Human Error]]
[[Ontology - Taxonomy]]


[Ontology - Predicate vs Derived]


---
#status/deferred/quick-paste-merge-later 
In the realm of data information systems and philosophy, these terms form a structural hierarchy that governs how we represent reality, how we know things, and how we communicate meaning.
To see how **semantics** fits, we have to look at the flow from the "existence" of a thing to the "understanding" of a thing.
### 1. Ontology: The Layer of Being
**Ontology** is the foundation. It asks: *What exists?*
In information systems, an ontology defines the specific entities, attributes, and relationships within a domain. It is the "map of reality." If you are building a medical database, your ontology dictates that "Patients," "Doctors," and "Symptoms" are the fundamental categories that exist.
### 2. Epistemology: The Layer of Knowing
**Epistemology** is the methodology. It asks: *How do we know what we know?*
In data systems, this is the logic and the rules of evidence. It involves the validation and verification of data. If the ontology says "Patients" exist, epistemology defines the criteria for confirming a patient’s diagnosis—whether it's through a lab result (data) or a doctor's observation (heuristics).
### 3. Semantics: The Layer of Meaning (The Bridge)
**Semantics** is where the hierarchy becomes functional. It asks: *What does this data mean in context?*
Semantics fits between the raw existence (Ontology) and the structured knowledge (Epistemology). It provides the **shared vocabulary** that allows different systems to interpret the "being" and "knowing" correctly.
 * **Without Semantics:** You have a database of "Patient ID: 123."
 * **With Semantics:** You understand that "123" represents a human being in a clinical setting, and that "High" in a blood pressure column carries a specific, actionable meaning.
### The "Data Forward" Hierarchy
When moving toward modern **Semantic Web** or **Knowledge Graph** architectures, the hierarchy usually functions in this order:

| Layer | Component | Function |
|---|---|---|
| **Ontology** | Schema/Structure | Defines the "skeleton" and the rules of the world. |
| **Semantics** | Metadata/Context | Attaches meaning to the data points so they are machine-readable. |
| **Epistemology** | Logic/Inference | Uses the semantic data to derive new knowledge or "know" truths. |
### How it fits in Information Systems
In a "data forward" approach, semantics is the **middleware**. While the ontology provides the rigid structure (SQL tables, classes), semantics uses protocols like **RDF (Resource Description Framework)** or **URI (Uniform Resource Identifiers)** to ensure that "Data Point A" in System 1 means the exact same thing as "Data Point B" in System 2.
Essentially, **Ontology** gives you the objects, **Semantics** gives those objects a language, and **Epistemology** uses that language to reach a conclusion.
Are you looking to apply this hierarchy to a specific project, like building a knowledge graph or a master data management (MDM) strategy?


---

## TLDR Mental Model (EIL5)

- **Tables** = how the system _claims reality exists_
- **Columns** = properties of those claims
- **Measures** = math on columns
- **Metrics** = measures **with meaning**

```
Table → Column → Measure → Metric
```

---

## Learning / Misconception Checks

- ❌ _“This table is a metric”_ → No, tables are **Layer 4**
- ❌ _“This ratio is a KPI”_ → Not unless you add **intent + benchmark**
- ✅ If people argue about meaning → you’re in **Layer 7**
- ✅ If math is right but trust is low → mis-modeled **Layer 4–5**

If you want next:

- Add **grain annotations** per table/measure
- Overlay **RLS / entitlement vectors**
- Render a **Power BI semantic model equivalency tree**

Just say which.

---


Tables and Columns are in a separate layer

Ontology
	Concept - Metaphysical Ontology) - Concept
	Event - `Descriptors + Distinctors` / `Scope: Snapshot In Time`
Epistemic Reality: Anchoring to Perspective {Sender, Receiver, Observer}

| Layer | Name                            | Definition                                                          | Example (Net Production / NPE)                                                                | Key Property                                     |
| ----- | ------------------------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| **0** | **Ontological Reality**         | What exists in the real world independent of systems or observation | A patient visit occurs; clinical work is performed; value is generated                        | Exists even if never recorded or if IT sees it.  |
| **1** | **Event Ontology**              | A real‑world event occurring at a point in time                     | Appointment occurred on 2026‑03‑29 with billable services                                     | Time‑bound, system‑agnostic (system-independent) |
| **2** | **Epistemic Reality**           | What could be known in principle with access to proper observers    | Clinic systems and staff know services rendered                                               | Knowable, not yet known *by us* (or formalized)  |
| **3** | **Organizational Epistemology** | What the organization is capable of knowing given access and rules  | PMS contains appointment type, status, amounts                                                | Knowledge is bounded                             |
| **4** | **System‑of‑Record Assertion**  | Facts explicitly asserted into systems                              | Ledger rows, appointment rows persisted                                                       | Explicit recording ( ingestion & validation)     |
| **5** | **Attribute / Predicate Layer** | Descriptive facts and deterministic truth rules over assertions     | `attribute.appointment_status.code = 'DISM'`  <br>`predicate.appointment.is_net_added = true` | Classifies reality, no math                      |
| **6** | **Measure Layer**               | Quantification of asserted events filtered by predicates            | `measure-sum.net_production_amount`  <br>`measure-count.appointment.npe_added_total_count`    | Additive, grain‑bound                            |
| **7** | **Metric Layer**                | Interpreted business indicators derived from measures               | `net_production_amount`  <br>`npe_added_total_count`                                          | Contextual, evaluative                           |


### Think “Glass vs Signature”

- **Layer 3 = Glass**
    
    - You can see through it
    - You can observe reality
    - You could be wrong
    - No responsibility is *invoked*au o
- **Layer 4 = Signature**
    
    - The org signs its name
    - Now it’s on the hook
    - Auditable
    - Other parties may rely on it
    - 

```
ontology-type: ontology | taxonomy | attribute-predicate | measure-count | measure-sum | measure-avg | measure-ratio | metric

grain: location-day | portfolio
```


Below is the **merged ASCII tree**, with **table objects explicitly embedded** at the correct layers.  
Clean, minimal, semantically correct.

---

## Ontology → Metric (With Table Objects)

```
ONTOLOGY (Layers 0–4)  — Reality → System Assertion
├─ Real‑World Concept
│  └─ e.g., Appointment, Patient, Case, Payment
│
├─ Business Definition
│  └─ "A scheduled clinical visit intended to produce treatment"
│
├─ Logical Model
│  └─ Entities & Relationships
│
└─ Physical System Assertion
   └─ TABLE
      ├─ appointments
      ├─ patients
      └─ financial_transactions


ATTRIBUTE / PREDICATE (Layer 5)
└─ COLUMN
   ├─ appointment_id
   ├─ appointment_date
   ├─ completed_flag
   ├─ case_started_flag
   └─ charge_amount


MEASURE (Layer 6)
└─ AGGREGATION (Math over Columns)
   ├─ Count(appointment_id)
   ├─ Sum(charge_amount)
   ├─ Avg(wait_time_minutes)
   └─ Ratio
      └─ Case Starts Count / Completed Appointments Count


METRIC (Layer 7)
└─ Decision‑Ready Signal
   ├─ Metric Name
   │  └─ "Weekly Exam Conversion Rate"
   │
   ├─ Measure(s)
   │  └─ Ratio(Case Starts / Completed Exams)
   │
   ├─ Intent
   │  └─ Assess clinical throughput effectiveness
   │
   └─ Benchmark
      └─ ≥ 75% (Target)
```

---

Validation Checklist — _Is This Ontological?_

Use this **before approving any new metric or predicate**.

### Ontology Checks

- [ ]  Does the underlying event exist in the real world without our systems?
- [ ]  Would this event still exist if the data pipeline failed?
- [ ]  Is this not merely a mathematical construction?

### Predicate Checks

- [ ]  Does the predicate only **classify** facts (true/false)?
- [ ]  No aggregation or math inside predicate logic?
- [ ]  Evaluation depends only on attributes or other predicates?

### Measure Checks

- [ ]  Does the measure perform **quantification only**?
- [ ]  Is the grain explicitly defined and valid?
- [ ]  Would two analysts compute the same result?

### Metric Checks

- [ ]  Does the metric interpret (not compute) business meaning?
- [ ]  Is business intent clearly stated?
- [ ]  Are comparability boundaries declared?

### Anti‑Pattern Warnings

- [ ]  ❌ If removed from systems, would the “thing” cease to exist? → _Not ontological_
- [ ]  ❌ Can it only exist as the result of math? → _Derived, not ontological_
- [ ]  ❌ Is logic duplicated across metrics? → _Predicate belongs lower_

---

## One‑Line Rule

> _Ontology defines existence, predicates define truth, measures define quantity, metrics define meaning._





[[Heuristics]] → [[Heuristics → Ellipsis → Perspective Drift]]

- [[#Analytical Ontology|Analytical Ontology]]
		- [[#Good Books|Good Books]]
- [[#**Describing the Problem: Ontology Blur**|**Describing the Problem: Ontology Blur**]]
		- [[#**Ontological Gaps**|**Ontological Gaps**]]
		- [[#Contextual Reuse|Contextual Reuse]]
		- [[#Definition Decay|Definition Decay]]
		- [[#Conceptual Erosion|Conceptual Erosion]]
		- [[#Metric Maturity Gap|Metric Maturity Gap]]
		- [[#Operational Ambiguity|Operational Ambiguity]]
		- [[#**Category Leakage**|**Category Leakage**]]
		- [[#Semantic Rot|Semantic Rot]]
- [[#Definitions|Definitions]]
	- [[#Definitions#Ontological|Ontological]]
		- [[#Ontological#Properties|Properties]]
	- [[#Definitions#Derived (Derived Classification)|Derived (Derived Classification)]]
	- [[#Definitions#How to Assign: Derived Concepts|How to Assign: Derived Concepts]]
		- [[#How to Assign: Derived Concepts#If the concept…|If the concept…]]
- [[#Mixed Assignment Patterns|Mixed Assignment Patterns]]
		- [[#How to Assign: Derived Concepts#Taxonomies (vocabularies)|Taxonomies (vocabularies)]]
		- [[#How to Assign: Derived Concepts#Leaf values (enums)|Leaf values (enums)]]
		- [[#How to Assign: Derived Concepts#Relationships|Relationships]]
		- [[#How to Assign: Derived Concepts#Attributes and States|Attributes and States]]
		- [[#How to Assign: Derived Concepts#Reinforcement|Reinforcement]]
		- [[#How to Assign: Derived Concepts#Mutability ≠ Derivation|Mutability ≠ Derivation]]
- [[#Concept Map|Concept Map]]


---

# Definitions
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

If you need a verb phrase - it is _not_ ontology.
*   “derived from”
*   “measured by”
*   “classified as”
*   “filtered by”
*   “based on”

> _Predicates select rows._  
> _Measures aggregate rows._  
> _Metrics compose measures._

# How to Assign: Derived Concepts
--------------------------
 

All derived concepts have:

    ontological_status = derived
    
### If the concept…
*   **selects rows** (yes/no membership test)
    *   `concept_class` → `classification-value`
    *   `concept_role` → `predicate`
*   **aggregates rows** (count, sum, rate)
    *   `concept_class` → `measure`
    *   `concept_role` → `aggregation`


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

* * *

Concept Map
-----------

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
* * *