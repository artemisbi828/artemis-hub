#learning

Below is an **EIL5 (Explain‑It‑Like‑I’m‑5)** mental model, but **structured for an architect’s brain**, not a child’s. Think **concept stack + why it exists + how Snowflake / Fabric / GitHub fit**.

---

## 0. One‑Sentence Mental Anchor

> **An App Registration is the _identity blueprint_.  
> A Service Principal is the _living instance_ of that identity inside a tenant.**

Everything else is just permission wiring.

---

## 1. The Cast of Characters (EIL5)

### 🧠 App Registration — _“The Mold”_

- A **global definition** of an application:
    - Name
    - Client ID
    - Auth method (secret, cert)
    - What APIs it _might_ request access to
- Exists in **Entra ID (Azure AD)** as a **template**
- Not allowed to do anything by itself

> Think: _“I am defining what this app **is**.”_

---

### 🧍 Service Principal — _“The Employee Badge”_

- A **tenant‑local instantiation** of an App Registration
- This is what:
    - Gets roles
    - Gets permissions
    - Is granted access to resources
- One App Registration ⇒ **0..N service principals** (across tenants)

> Think: _“This specific tenant has hired this app.”_

---

### 🔐 Permissions / RBAC — _“Where the badge works”_

- Assigned **to the Service Principal**
- Not assigned to the App Registration
- Determines:
    - What data it can access
    - What actions it can perform

---

## 2. Why Microsoft Split It This Way (Important)

**Separation of concerns**:

|Concept|Purpose|
|---|---|
|App Registration|Identity _design_|
|Service Principal|Identity _execution_|
|RBAC / API permissions|Identity _authority_|

This allows:

- One app → many tenants
- Central definitions + local control
- Least privilege per tenant

---

## 3. The 30‑Second Flow (Auth Lifecycle)

External system

   ↓ presents client_id + secret/cert

Azure Entra ID

   ↓ authenticates via App Registration

Issues token

   ↓ token contains Service Principal identity + roles

Target service (Snowflake / Fabric / GitHub)

   ↓ authorizes based on SP assignments

> Auth = **App Registration**
> 
> Authorization = **Service Principal + RBAC**

---

## 4. Concrete Examples (This Is Where It Clicks)

---

### ❄️ Snowflake (OIDC / External OAuth)

**What happens**

- You create an **App Registration** in Azure
- Snowflake trusts Azure as an IdP
- Azure creates a **Service Principal**
- That SP is:
    - Used by Snowflake
    - Mapped to Snowflake roles

**Mental mapping**

- App Registration = **Snowflake login contract**
- Service Principal = **Snowflake workload identity**
- Snowflake roles ≠ Azure roles (separate planes)

✅ Snowflake never sees the App Registration  
✅ It only sees **tokens issued for the SP**

---

### 🧵 Fabric / Power BI / OneLake

**Common pattern**

- App Registration created for:
    - Pipelines
    - Notebooks
    - Automation
- A Service Principal appears automatically
- That SP is granted:
    - Workspace access
    - Dataset permissions
    - OneLake access

**Key mental note**

> Fabric only trusts **Service Principals**, never App Registrations

If you delete the SP (or tenant access):

- Fabric access breaks
- Even though the App Registration still exists

---

### 🐙 GitHub → Azure (Federated Credentials)

**Modern pattern (no secrets)**

- App Registration defines:
    - Trust policy (GitHub repo / org)
- Service Principal represents:
    - “This repo when it runs CI”
- Token issued at runtime:
    - Short‑lived
    - Mapped to SP
- SP has RBAC on Azure resources

**Mental model**

- App Registration = **trust rule**
- Service Principal = **runtime identity**
- GitHub Action = **temporary impersonator**

---

## 5. Common Confusions (and the Fix)

### ❌ “I granted permissions to the App Registration”

✅ You granted permissions **that will be used by its Service Principal**

---

### ❌ “Why do I see multiple service principals?”

✅ Same app, **different tenants / contexts**

---

### ❌ “Why does deleting the App Registration break prod?”

✅ Because all Service Principals were derived from it

---

### ❌ “Why does RBAC live outside the app?”

✅ Because **authorization ≠ identity**

---

## 6. Mental Model Ladder (Use This)

Identity Definition

  ↓

App Registration

  ↓ instantiates per tenant

Service Principal

  ↓ granted authority

RBAC / API Permissions

  ↓ produces claims

Access Token

  ↓ consumed by

Snowflake / Fabric / Azure / GitHub

---

## 7. One‑Line Rule of Thumb

> **If you’re thinking about “who can do what” — think _Service Principal_.  
> If you’re thinking about “how does it authenticate” — think _App Registration_.**

---

## 8. Want This Extended?

I can:

- Map this to **Managed Identities**
- Give a **Snowflake ↔ Azure trust pattern diagram**
- Show **anti‑patterns** (over‑scoped apps, tenant‑wide SP abuse)
- Tie this into **RLS / data‑plane identity governance**

Tell me which layer you want to zoom into.