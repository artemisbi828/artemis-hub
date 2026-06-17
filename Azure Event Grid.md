---
definition: A managed publish/subscribe event routing service that delivers discrete event notifications from producers to multiple subscribers with low latency and at‑least‑once delivery.
vendor: MSFT
---
Below is a **mental‑model primer** for **Azure Event Grid** framed specifically as a **pub/sub backbone for data pipelines**, optimized for **Obsidian.md** and for someone with your **BI + systems architecture** background.

---

Event Grid is **Azure’s nervous system for events**.  
Think: _“Something happened”_ → _notify everyone who cares_, **fast**, **cheap**, and **without tight coupling**.  
It is **not** for moving large data; it’s for **signaling state change** so pipelines can react.

---

## Concept Boundary (EIL5)

> **If Event Hubs is a firehose and Service Bus is a mailbox, Event Grid is a doorbell.**

- You **don’t send data**
- You **announce facts**
- Subscribers **decide what to do next**

---

## Clinical Definition (1–3 high‑fidelity)

**Azure Event Grid**  
A **managed publish/subscribe event routing service** that delivers **discrete event notifications** from producers to multiple subscribers with **low latency** and **at‑least‑once delivery**.

**Key constraint**  
Payloads are **small, descriptive**, and **immutable** → _events, not messages or records_.

---

## Core Semantics (Hard Boundaries)

|Axis|Event Grid|Not Event Grid|
|---|---|---|
|Purpose|State change notification|Data transport|
|Payload size|Small (< ~64 KB)|Large blobs, streams|
|Ordering|Not guaranteed|Ordered streams|
|Retention|Minimal|Long-term|
|Coupling|Loose|Tight|

---

## Canonical Pub/Sub Shape

```
[ Event Source ]
       |
       |  (publish)
       v
+----------------+
|  Event Topic  |
+----------------+
       |
       |  (fan-out)
       v
+----------------------------+
|        Subscriptions       |
|  - Filter                  |
|  - Destination             |
+----------------------------+
       |
       v
[ Handlers / Pipelines ]
```

---

## Event Grid Object Model (Mono‑Hierarchal)

```
Event Grid
├── Topic
│   ├── System Topic
│   │   └── Azure-native sources
│   └── Custom Topic
│       └── App / pipeline events
├── Event
│   ├── Metadata
│   └── Data (lightweight)
├── Subscription
│   ├── Filters
│   └── Dead-lettering
└── Handler
    ├── Azure Function
    ├── Logic App
    ├── Webhook
    └── Service Bus / Event Hub
```

---

## Event Anatomy (What Actually Flows)

```
Event
├── id
├── eventType        (semantic signal)
├── subject          (entity scope)
├── eventTime
├── data             (context, not payload)
└── dataVersion
```

**Rule of thumb**

> If the consumer needs to query more data → you modeled it correctly.

---

## Semantic Edges (Orthogonal vs Hierarchical)

### Hierarchical (ownership)

```
Storage Account
└── System Topic
    └── BlobCreated Event
```

### Orthogonal (reaction)

```
BlobCreated
├── Trigger ingestion
├── Trigger validation
└── Trigger audit logging
```

---

## Data Pipeline Lens (What BI / Analytics Cares About)

### Where Event Grid Fits

```
[ Source System ]
       |
       |  (event)
       v
[ Event Grid ]
       |
       +--> Ingest (ADF / Databricks)
       +--> Validate (Function)
       +--> Notify (Teams / Email)
       +--> Audit (Log Analytics)
```

**Event Grid = pipeline orchestration glue**, not the pipeline itself.

---

## Common Analytics Events (Good Fit)

|Event|Why it Works|
|---|---|
|File landed in blob|Atomic state change|
|Ingest completed|Downstream fan‑out|
|Data quality failed|Alert + rollback|
|Snapshot published|Consumers pull|

---

## Example 1 – Lakehouse Ingestion

```
BlobCreated
└── subject: /raw/claims/2026/05/06/*.parquet
```

Subscribers:

- Azure Function → schema check
- ADF → bronze → silver load
- Teams webhook → ingestion success

✅ Loose coupling  
✅ Parallel reactions  
❌ No row-level data

---

## Example 2 – ELT Control Plane

```
Event: PipelineStageCompleted
├── stage: bronze
├── entity: claims
└── watermark: 2026-05-06T14:00Z
```

Subscribers:

- Trigger next stage
- Update metadata DB
- Emit KPI metrics

---

## Example 3 – Governance / Audit

```
Event: DatasetPublished
├── domain: finance
├── sensitivity: PHI
└── owner: analytics
```

Subscribers:

- Purview scan
- Access review workflow
- Compliance logging

---

## What Event Grid Is _Not_ (Important Delineation)

```
Event Grid
≠ Event Hubs     (streaming, telemetry)
≠ Service Bus    (commands, workflows)
≠ Kafka          (ordered logs)
```

### Decision Table

|Need|Use|
|---|---|
|“Something happened”|Event Grid|
|“Here is data”|Event Hubs|
|“Do this exactly once”|Service Bus|
|“Replay forever”|Kafka|

---

## Failure & Reliability Model (Mental Shortcut)

```
Publish
  ↓
Route
  ↓
Retry (exponential)
  ↓
Dead-letter
```

- **At-least-once**
- **Idempotent consumers required**
- Dead-lettering = observability, not recovery

---

## Anti‑Patterns (Red Flags)

- ❌ Embedding datasets in events
- ❌ Using Event Grid as a queue
- ❌ Expecting ordering guarantees
- ❌ Business logic in filters

---

## Executive Summary (for governance decks)

> Event Grid provides **event‑driven decoupling** across data platforms, enabling **reactive pipelines**, **parallel processing**, and **governed fan‑out** without turning data movement into control logic.

---

If you want next:

- **Event Grid vs Event Hubs deep dive (analytics‑centric)**
- **Reference architecture for healthcare claims pipelines**
- **Semantic event naming conventions**
- **Cost / throughput modeling**

Just say the word.