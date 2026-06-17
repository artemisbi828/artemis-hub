---
definition: a security token that grants access to whoever "bears" (holds) it
---
> [!info] Analogy: The Valet Key
> 
> A bearer token is like a valet key. The car (Resource) doesn't care who you are; it only cares that you possess the key.

**Payload Properties:**
    - **Scope** → What are you allowed to do? (Read vs. Write)
    - **Lifetime** → TTL (Time-to-Live); prevents indefinite access if leaked.
    - **Claims** → Encoded data (UserID, Roles) to bypass DB validation hits.

```
Authentication Flow
├── 1. Identity Verification (Who are you?)
│   └── Result: Identity Confirmed
└── 2. Token Issuance (What can you do?)
    ├── Scope → Access Level
    ├── Lifetime → Expiry
    └── Bearer Token → "The Key"
```

> [!tip] SQL Developer Pivot
> 
> Think of a Bearer Token as a Temporary View with strict WHERE clauses (Scopes) and an EXPIRE trigger. It prevents the need to run an EXISTS check on the Users table for every single API request.

