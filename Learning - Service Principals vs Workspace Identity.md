#learning 

Below is **both deliverables**, structured and calibrated for how you typically think and communicate:

- **Part 1**: Executive‑facing summary email (tight, coherent, non‑technical but defensible).
- **Part 2**: A **clear mental model** of what is actually happening, why this keeps breaking at “prod”, and the **modern, robust patterns** (service principal vs workspace identity) — with explicit delineators and call‑outs of where your understanding is shallow _by design_, not by fault.

I will **not fluff this**, but I _will_ be explicit.

---

## 1) Executive‑Facing Summary Email (for upward escalation)

**Subject:** Past Due Scheduling Dashboard – Not Production‑Ready Due to Authentication Model

**Draft:**

> We’ve identified a structural issue with the **Past Due Scheduling Dashboard** that prevents it from being promoted to a production‑ready state.
> 
> The report currently lives in a workspace that is **not supported by IT** and is independently managed by the RCM team. It was inherited and developed outside our standard governance model. The analyst maintaining it (Jamie Helm) built the report using **her personal OAuth credentials** to access a **personal SharePoint folder** as the data source.
> 
> Because the data access is tied to an individual user’s permissions, **other users cannot refresh or reliably access the report** unless they individually have explicit permissions to that SharePoint location. This breaks production standards for authentication, security, and scalability.
> 
> To be production‑ready, this class of report must use a **non‑human identity** (e.g., **service principal or workspace identity**) with governed, read‑only access to approved data sources. At present, those mechanisms are **not configured or operationalized** for this workspace, and there is **no defined process** for the RCM team to promote reports into a compliant production model.
> 
> We are escalating this because the remediation requires **cross‑team decisions** around identity strategy, workspace governance, and supported patterns for SharePoint‑backed data sources. Without that, similar reports will continue to fail when ownership or audience expands.
> 
> **Ask:** Direction on whether we (1) formalize a supported authentication model for these reports, or (2) require migration of this report into an IT‑supported workspace with compliant identity and access patterns.

---

This frames it as:

- **Structural / systemic**, not a people problem
- **Risk‑oriented**, not technical pedantry
- A clear **decision fork** for leadership

---

## 2) Mental Model Update — What’s _Actually_ Governing This Scenario

This is the important part.

### A. The Root Problem (In Clean Terms)

> **The report is authenticated as a human, but is being treated like infrastructure.**

Power BI (and Fabric more generally) **will happily let you do this**, which is why this anti‑pattern keeps spreading.

Jamie’s report works **only because**:

- OAuth token = _Jamie_
- SharePoint permissions = _Jamie_
- Refresh context = _Jamie_

The second you try to:

- Share it broadly
- Schedule refresh centrally
- Change ownership
- Move to a controlled workspace

It breaks — **correctly**.

This is not a bug. It’s a **missing identity boundary**.

---

### B. Entities and Relationships (Your Updated Mental Map)

```
Human Identity (OAuth)
  └─ Used for: Authoring, experimentation
  └─ NOT acceptable for: Production refresh, shared consumption

Non‑Human Identity
  ├─ Service Principal (App Registration)
  └─ Workspace Identity (Managed Identity)
        ↓
   Controlled Access to Data Sources
        ↓
   Prod‑grade Refresh + Security
```

Right now this report never crosses that boundary.

---

### C. Why Permissions “Fixes” Fail Over Time

You already intuit this, but here’s the formal articulation:

|Attempted Fix|Why It Fails|
|---|---|
|“Just give others access to the SharePoint folder”|Permissions sprawl, no ownership clarity, revocation impossible|
|“Make Jamie the long‑term owner”|Human dependency risk|
|“Publish to a new workspace”|Identity doesn’t change, problem persists|
|“Have IT add refresh rights”|Still authenticating as Jamie|

The **refresh identity and the storage permissions must align** — today they are _human‑bound_.

---

## D. Service Principal vs Workspace Identity (Hard Delineation)

This is likely where your understanding is shallow _because your org hasn’t operationalized either yet_.

### 1. Service Principal (App Registration)

**Conceptually:**

- A **named, auditable, non‑human identity**
- Lives in Azure AD / Entra
- Explicit permissions everywhere

**Characteristics:**

- Explicitly granted access to:
    - SharePoint sites
    - Snowflake
    - SQL
    - APIs
- Usable across **multiple workspaces**
- Ideal when:
    - Cross‑workspace access is required
    - Central platform team controls identity
    - You want _explicit_, reviewable permissions

**Tradeoff:**

- Requires more upfront governance
- Needs IT/security alignment
- More visible security surface area

---

### 2. Workspace Identity (Managed Identity)

**Conceptually:**

- The **workspace itself becomes the identity**
- Special‑purpose managed identity
- Microsoft‑managed lifecycle

**Characteristics:**

- Permissions granted **to the workspace**, not a user
- Cleaner for:
    - SharePoint
    - OneLake
    - Fabric artifacts
- Scope is **implicitly limited** to that workspace

**Tradeoff:**

- Tightly coupled to workspace
- Harder to reuse across environments
- Less flexible for cross‑domain data access

---

### ✅ When Each One Is “Correct”

|Scenario|Preferred Pattern|
|---|---|
|Departmental reports, scoped data|**Workspace Identity**|
|Enterprise/shared data sources|**Service Principal**|
|External APIs / Snowflake|**Service Principal**|
|SharePoint lists/files tied to a workspace|**Workspace Identity**|

Your case **could** use either — but **currently uses neither**.

---

## E. The Missing Process (This Is the Real Gap)

You asked: _“What is the modern robust process?”_

Here it is, stripped down:

### ✅ The Only Scalable Pattern

1. **Data sources are owned by a platform identity**
    
    - NOT personal OneDrive / home folders
    - SharePoint site with explicit ownership
2. **Non‑human identity is granted Read access**
    
    - Service Principal **or** Workspace Identity
    - Least‑privilege model
3. **Report authors bind to that identity**
    
    - Human for development
    - Non‑human for refresh
4. **Promotion checklist exists**
    
    - Auth model validated
    - Owner documented
    - Refresh tested without author access

If step **2** doesn’t exist org‑wide, everything downstream is fragile.

---

## F. Where Your Gaps Are (Explicitly)

Based on your questions, your gaps are **not technical**, they’re **organizational‑mechanical**:

1. **Where identity ownership lives**
    
    - Platform team?
    - Workspace owner?
    - Security?
2. **Who is allowed to request non‑human identities**
    
    - Analysts?
    - Only IT?
3. **What “prod” formally means**
    
    - Auth compliance?
    - Workspace classification?
    - SLA?
4. **SharePoint as a data tier vs convenience storage**
    
    - Site vs folder vs personal drive
    - Governance model

These gaps exist because **no canonical pattern has been enforced yet**.

---

## G. One‑Sentence Truth You Can Reuse

> _If a report authenticates as a person, it is not production‑grade — regardless of how well it works today._

---

If you want, next we can:

- Draft a **1‑page Auth & Identity Pattern doc**
- Create a **promotion checklist** you can point to
- Turn this into a **standard escalation template** so you don’t have to re‑explain it every time

You’re asking the _right_ questions — this is a governance maturity issue, not a skills gap.