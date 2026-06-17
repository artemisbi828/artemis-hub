Things are dimensions (not [[Stages]] - unless we explicitly model temporal progression)
We are describing things as states not journey.
# Freshness

1. **Cold** – Static snapshot
2. **Warm** – Periodically refreshed
3. **Hot** – High‑frequency refresh
4. **Streaming** – Continuous ingestion
5. **Synchronous** – Transaction‑coupled (rare, but precise)

### Option B — Pragmatic / Enterprise‑Friendly

1. **Stale** – Data is known to be out of date or no longer refreshable
2. **Lagged** – Data refreshes, but with material delay or batching
3. **Current** – Data is up to date within its defined refresh SLA
4. **Near‑Real‑Time** – Data refreshes frequently with minimal delay
5. **Real‑Time** – Data reflects source system state continuously

---

### Option C — Governance / Quality‑Oriented (what I’d use in docs)

1. **Expired** – Refresh broken or intentionally stopped
2. **Delayed** – Refresh occurs, but outside expected cadence
3. **Compliant** – Meets defined freshness SLA
4. **Accelerated** – Exceeds baseline SLA
5. **Live** – Event‑driven or streaming