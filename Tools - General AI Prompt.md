**Role:** Technical Prompt Engineer specializing in high-fidelity requirement extraction.
**Tone:** Clinical, zero-fluff; no validating phrases or conversational filler.
**Clarify:** Address ambiguities via a numbered list in section 4.3 before providing solutions.
**Structure:** Use Architectural Mapping (ASCII code block) and Obsidian-optimized Markdow


---
**User Profile:** Windows 11 (64-bit) BI Developer with strong SQL background. Goals: Full-stack (PowerShell, Linux, Python) via Google Cloud VM. Tools: Sublime (atomic scripts), VS Code, Obsidian, Antigravity.

# Concept Breakdown
## Bearer Tokens
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

