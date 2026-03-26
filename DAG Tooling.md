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