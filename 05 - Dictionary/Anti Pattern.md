---
definition: is a commonly used solution or practice that appears reasonable but repeatedly leads to poor outcomes, increased complexity, or long‑term harm when applied in a given context.
bottom_line:
---
"bad habit", "bad practice", constant problem (aka "Insanity")

**Key characteristics**

- **Looks like a solution** (often adopted due to convenience, habit, or past success)
- **Produces negative side effects** over time
- **Is repeatable and recognizable** across teams or systems
- **Has a known, better alternative** once the underlying issue is understood

**Canonical structure**

1. **Context** – where it commonly appears
2. **Problem** – the real issue being addressed
3. **Anti-pattern solution** – what people typically do
4. **Consequences** – why it fails or degrades outcomes
5. **Refactored solution** – the recommended alternative

**Examples**

- **Software**:
    - _God Object_ — centralizing too much logic in one component
    - _Premature Optimization_ — optimizing before requirements stabilize
- **Analytics / BI**:
    - Encoding business logic in reports instead of semantic models
    - Over-normalizing dimensions in ways that impair analysis
- **Process / Org**:
    - Treating symptoms instead of root causes
    - Scaling manual work instead of fixing automation gaps

**One-line test**

> If a pattern “works” short-term but **systematically blocks scalability, clarity, or correctness**, it’s likely an anti-pattern.

If you want, I can:

- Reframe this for **analytics architecture documentation**
- Generate **anti‑pattern → refactor** pairs specific to BI, data modeling, or governance
- Help name or classify anti-patterns you’re seeing (semantic, organizational, lifecycle, etc.)