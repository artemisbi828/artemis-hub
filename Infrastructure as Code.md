---
aliases:
  - IaS
---
Below is a **concept definition pack** you can drop directly into **Obsidian.md**.  
Style: _mental-model first_, semantic edges explicit, minimal prose, high signal.

---

## Infrastructure as Code (IaC)

**In simple terms:**  
Infrastructure as Code means **you describe infrastructure the same way you describe software**—as files that are versioned, reviewed, tested, and repeatable. Instead of clicking in a cloud console, you _declare intent_ and let tools converge reality to match it.

**Boundary marker:**  
IaC governs **infrastructure state**, _not_ application business logic.  
If it provisions networks, compute, identity, or managed services → IaC.  
If it implements workflows, rules, or domain behavior → application code.

---

## Clinical Definition

|Aspect|Definition|
|---|---|
|Core|A practice where infrastructure resources are **defined, provisioned, and managed via machine-readable code**|
|Control Plane|IaC tools act as **state reconcilers** between declared intent and actual infrastructure|
|Outcome|Deterministic, auditable, reproducible environments|

---

## Conceptual Placement (Mental Model)

```
Software Delivery
├── Application Code
│   ├── Business logic
│   ├── APIs
│   └── UI
└── Platform Code
    ├── Infrastructure as Code (IaC)
    │   ├── Networks
    │   ├── Compute
    │   ├── Storage
    │   └── IAM
    └── Configuration Management
        ├── OS packages
        ├── Services
        └── Runtime tuning
```

**Key delineation:**

- **IaC** → _What exists_
- **Config Management** → _How it runs_

---

## Declarative vs Imperative (Critical Axis)

```
IaC Control Styles
├── Declarative (preferred)
│   ├── "This is the desired end state"
│   ├── Tool computes diff
│   └── Tool applies convergence
│
└── Imperative
    ├── "Run these steps"
    ├── Order-sensitive
    └── Higher drift risk
```

|Model|Example Tools|Drift Handling|
|---|---|---|
|Declarative|Terraform, ARM, Bicep|Automatic detection|
|Imperative|Bash, PowerShell|Manual|

---

## Core Lifecycle

```
IaC Lifecycle
1. Author
   └── Code expresses intent
2. Plan
   └── Diff: desired vs actual
3. Apply
   └── Reconcile state
4. Observe
   └── Drift / metrics
5. Refactor
   └── Iterate safely
```

**Semantic note:**  
The _Plan_ phase is the governance hinge—this is where risk is surfaced _before_ execution.

---

## State (The Most Misunderstood Concept)

```
IaC State Model
├── Desired State
│   └── Code (git)
├── Actual State
│   └── Cloud reality
└── State Store
    ├── Local / Remote
    ├── Locking
    └── Drift detection
```

**Clinical rule:**

> If state is corrupted, IaC becomes _dangerous automation_.

---

## Tooling Landscape (Orthogonal Axes)

### Provisioning vs Configuration

```
Infrastructure Tooling
├── Provisioning (IaC)
│   ├── Terraform
│   ├── ARM / Bicep
│   └── CloudFormation
│
└── Configuration
    ├── Ansible
    ├── Chef
    └── DSC
```

### Cloud Scope

|Scope|Meaning|
|---|---|
|Cloud-agnostic|Same code, many clouds|
|Cloud-native|Deep integration, vendor lock-in|

---

## Example: Healthcare-Oriented Stack (Concrete)

```
IaC for Healthcare Platform
├── Network
│   ├── VPC / VNet
│   └── Private endpoints
├── Security
│   ├── IAM roles
│   ├── Key vaults
│   └── Audit logs
├── Data
│   ├── SQL / Managed DB
│   └── Backup policies
└── Compute
    ├── App services
    └── Batch jobs
```

**Why IaC matters here:**

- Regulatory traceability (HIPAA audits)
- Environment parity (prod = non-prod)
- Fast disaster recovery

---

## IaC vs Adjacent Concepts (Hard Boundaries)

|Concept|Not IaC Because…|
|---|---|
|CI/CD pipelines|They _execute_ code; they don’t define infrastructure|
|Monitoring dashboards|They observe state, don’t declare it|
|SQL schema migrations|They change data shape, not infrastructure|

---

## Failure Modes (Executive-Relevant)

```
IaC Anti-Patterns
├── ClickOps drift
├── Unreviewed applies
├── Shared state without locking
└── Environment-specific forks
```

**Translation:**  
IaC without discipline increases blast radius instead of reducing it.

---

## Why IaC Exists (One Sentence)

> IaC converts infrastructure from **tribal knowledge** into **governed, testable assets**.

---

## Mental Compression (One-Liner)

```
IaC = Declarative intent + version control + state reconciliation
```

---

If you want, I can next:

- Map **Terraform concepts → SQL analogies** (for BI intuition)
- Contrast **IaC vs Platform Engineering**
- Show a **minimal GCP IaC spine** aligned to your full‑stack goal (PowerShell + Linux + Python)

Just tell me which direction to go.