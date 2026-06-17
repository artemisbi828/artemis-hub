Use **stage** when:

- There is an **expected lifecycle**
- Values imply **directional advancement**
- Regressions are exceptional and meaningful events

Example:

- Ingested → Validated → Published → Real‑Time

Freshness usually **does not qualify**, because:

- Data can move backward (e.g., Compliant → Delayed)
- There is no “completion”
- It’s evaluated continuously, not transitioned through

If you call freshness a stage, you’re implicitly asserting:

> there is a pipeline or lifecycle you advance through

That is usually **false**.

---

## Canonical Positioning (What I’d Document)

> **Freshness is a semantic dimension representing the observed latency state of data at evaluation time.**

Not:

- A process stage
- A pipeline step
- A maturity level

---

## When Both Exist (Advanced but Clean)

You _can_ have both — **but don’t conflate them**.

|Concept|Example|Type|
|---|---|---|
|Ingestion Lifecycle|Extracted → Loaded → Validated|**Stage**|
|Observed Freshness|Delayed / Compliant / Live|**Dimension**|

This separation prevents exactly the confusion you’ve been circling lately.

---

## One‑Line Rule You Can Reuse

> If it describes **what something is**, it’s a **dimension**.  
> If it describes **where something is going**, it’s a **stage**.