#learning

### Definition

- Terraform Cloud acts as an **OIDC identity provider**.
- Cloud provider (Azure / AWS / GCP) trusts Terraform Cloud.
- Terraform exchanges its **run identity** for **cloud-native credentials**.

### What problem it solves

|Old Model|OIDC Model|
|---|---|
|Static secrets|Ephemeral tokens|
|Secret rotation|Automatic expiry|
|High blast radius|Scoped trust|

### Terraform Cloud OIDC Flow

```
terraform apply
     |
     v
Terraform Cloud
     |
     |  OIDC ID Token
     v
Cloud IAM (Azure/GCP/AWS)
     |
     |  Temporary Credentials
     v
Provision Resources
```

### Azure-specific mental model

```
Terraform Cloud
   └── OIDC Issuer
        └── Federated Credential
              └── Entra ID App
                    └── Azure RBAC
```

### GCP analog (your stated goal)

```
Terraform Cloud
   └── OIDC Provider
        └── Workload Identity Pool
              └── Service Account
                    └── IAM Roles
```

---

## 5. Cross-Concept Map (Poly-hierarchical)

```
Identity & Access
├── Protocols
│   └── OIDC
│
├── SDKs
│   └── MSAL
│
├── Patterns
│   └── Federated Token Exchange
│
└── Implementations
    └── Terraform Cloud OIDC
```

**Orthogonal edges**

- MSAL ⟂ Terraform (different layers)
- OIDC ⟂ Cloud provider (protocol vs platform)
- Token Exchange ⟂ Vendor (pattern, not product)

---

## 6. Mental Model Cheatsheet

|Question|Answer|
|---|---|
|Who are you?|OIDC|
|How do I get tokens?|MSAL|
|How do systems trust each other?|Federation|
|How does Terraform avoid secrets?|OIDC + Federation|

---

## 7. Executive-Grade Summary (1 breath)

> Terraform Cloud uses **OIDC-based federated token exchange** to authenticate as a trusted workload in cloud IAM systems, eliminating static secrets; MSAL is a client SDK for similar OAuth/OIDC flows in application code, while OIDC itself is the protocol anchoring identity assertions.

---

If you want next:

- **Azure vs GCP federation comparison**
- **Concrete Terraform + GCP example**
- **Where MSAL fits (and doesn’t) in IaC pipelines**

Just say which edge you want to deepen.