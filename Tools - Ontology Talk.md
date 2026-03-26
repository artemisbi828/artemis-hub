[[Heuristics]] → [[Ellipsis → Perspective Drift]]

This **discipline** is called: **Analytical Ontology** or **IS (Information System) Ontology**
- Semantic modeling
- Metrics engineering
- Information architecture (technical, not UX) → Technical Data Architecture
- ISO 704 / ISO 1087

We want notes in this discipline that are consistent with:
- accounting‑grade event modeling
- ontology discipline
- analytics safety
- future auditability

We are preventing:
- semantic overload
- definition entanglement
- conceptual conflation

We are instead:
- semantic normalization
- ontological separation of concerns
- explicit predicate/aggregation layering

We are promoting:
- consistency checking
- ontology hygiene
- metric drift prevention
- efficient LLM collaboration

We want documentation to be:
- teachable
- reviewable
- extensible
- non-intimidating



### Good Books
Core ontology / semantics
- Nicola Guarino – Formal Ontology in Information Systems
- ISO 704 / ISO 1087 – Terminology principles
- Gruber (1993) – What is an Ontology?

Analytics / metrics semantics
- Ralph Kimball – useful but incomplete (dimensions vs facts, not predicates vs measures)
- Agnes Molnar – Analytics governance (talks about definition drift)
- dbt Semantic Layer docs – modern applied version of what you’re building

Conceptual modeling
- Peter Chen – Entity–Relationship modeling (theoretical roots)
- Date & Darwen – The Third Manifesto (strong separation of relvars, predicates, and operators)

[[DAG Tooling]]

---
# **Describing the Problem: Ontology Blur**
Shortcomings
### **Ontological Gaps**

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

### **Category Leakage**

> Properties or filters leak into the category structure itself.

- Extremely accurate for your “dismissed_new_patient_exam” case
- Very memorable
- Highlights structural misuse
#### **Hierarchy Substitution**

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