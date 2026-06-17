Below is a **conceptual scaffold** you can drop straight into **Obsidian.md**.  
I’m treating this as **mental-model maturation**, not vendor docs.

---

## OIDC · MSAL · Federated Token Exchange · Terraform Cloud (OIDC)

In plain language:

> **OIDC** defines _how identities prove who they are_.  
> **MSAL** is a _client library_ that speaks OIDC/OAuth correctly.  
> **Federated token exchange** lets one system _swap_ a trusted token for another.  
> **Terraform Cloud OIDC** uses federation so Terraform never stores long‑lived secrets.

**Boundary marker:**

- OIDC = _protocol_
- MSAL = _implementation / SDK_
- Token Exchange = _pattern_
- Terraform Cloud OIDC = _applied architecture_

---

## 1. OpenID Connect (OIDC)

### Definition (clinical)

- An **identity layer** built on OAuth 2.0 that issues **ID Tokens** asserting _who_ the user or workload is.
- Uses **JWTs**, **scopes**, **claims**, and **well-known endpoints**.
- Answers: **“Who are you?”** (authentication)

### What it is NOT

- ❌ Authorization policy engine
- ❌ Identity store (that’s Entra ID / Google / Okta)

### Core artifacts

|Artifact|Purpose|
|---|---|
|ID Token (JWT)|Identity assertion|
|Access Token|API authorization|
|Refresh Token|Session continuity|
|Claims|Attributes about subject|

### Minimal OIDC Flow

```
User / Workload
      |
      v
[ Client App ]
      |
      v
[ OIDC Provider ]
      |
      v
  ID Token (JWT)
```

### Conceptual placement

```
Identity Stack
├── Authentication (OIDC)
├── Authorization (OAuth scopes / RBAC)
└── Policy (IAM, Conditional Access)
```

---

## 2. MSAL (Microsoft Authentication Library)

### Definition

- A **client-side SDK** that implements OAuth 2.0 + OIDC flows _correctly_ against Microsoft Entra ID.
- Abstracts token caching, renewal, and flow selection.
- Exists for **.NET, JS, Python, Java, Go**.

### Boundary

- MSAL **does not authenticate users**
- MSAL **does not define identity**
- MSAL **requests tokens**

### Why MSAL exists

```
Without MSAL:
App → Hand-rolled OAuth → Bugs → Security risk

With MSAL:
App → MSAL → Entra ID → Tokens (correct)
```

### Token acquisition modes

```
MSAL
├── Interactive (user login)
├── Silent (cached token)
├── Client Credentials (app/workload)
└── On-Behalf-Of (token exchange)
```

### Example contexts (max 3)

1. Power BI embedding with Entra auth
2. Internal API calling downstream APIs
3. CLI tooling authenticating as workload

---

## 3. Federated Token Exchange (Pattern)

### Definition

- A **trust-based token swap** where a token from **Issuer A** is exchanged for a token from **Issuer B** _without shared secrets_.
- Relies on **claims + audience + issuer trust**.

### Key insight (EIL5)

> “If I trust who issued your badge, I’ll give you _my_ badge.”

### Why it matters

- No secrets
- Short-lived tokens
- Cloud-native
- Auditable trust chains

### Abstract flow

```
[ External Identity ]
        |
        |  (OIDC JWT)
        v
[ Trusted STS ]
        |
        |  (New Token)
        v
[ Cloud Resource ]
```

### Semantic edges

```
Federated Token Exchange
├── Requires: OIDC / OAuth
├── Enables: Secretless auth
├── Used by: Terraform, GitHub Actions, GCP Workload Identity
└── Implemented via: IAM trust policies
```
