#learning 

Below is a **tight decision framework** you can reuse every time you’re choosing **DRY vs WET**, plus a **waterfall ASCII tree** that forces a deterministic outcome.

---

# TL;DR (one-liner)

**Default to DRY** unless you have a _real constraint_ that makes DRY expensive or risky **and** the duplication is small + stable.

---

# Decision Framework: DRY vs WET (tight + reusable)

## Step 0 — Define the “shared thing”

Before choosing DRY/WET, name the shared unit:

- **Shared unit** = “normalization pipeline” (tokens, whitespace, casing, comment handling, etc.)
- **Consumers** = `#1 formatter`, `#2 extractor`

If you cannot name the shared unit cleanly, you’re not ready to DRY it—yet.

---

## Step 1 — Run the 6 Gates (binary “yes/no”)

If any gate says **YES**, it pushes you strongly toward DRY.

### Gate A — Will it change more than once?

- **YES** → DRY
- NO → WET acceptable  
    Rule: if you expect iterative tuning (you do), DRY wins.

### Gate B — Does divergence create “silent wrongness”?

- **YES** → DRY  
    Silent wrongness = extractor behaves differently than formatter and you don’t notice until later.

### Gate C — Is it used by 2+ commands now (or will be soon)?

- **YES** → DRY  
    Two consumers is already enough to justify SSOT.

### Gate D — Is it hard to test if duplicated?

- **YES** → DRY  
    Normalization is notorious for edge-cases (comments, quoted identifiers, bracketed names, dynamic SQL fragments).

### Gate E — Does it touch parsing, offsets, or semantics?

- **YES** → DRY (or DRY + contract + tests)  
    If extraction correctness depends on normalization behavior, drift is unacceptable.

### Gate F — Is the cost of DRY low-to-medium?

- **YES** → DRY  
    “Cost” includes packaging in Sublime, dependency management, and developer friction.

**Interpretation:**

- **0–1 YES** → WET is defensible
- **2–3 YES** → Lean DRY unless a hard constraint exists
- **4+ YES** → DRY, no debate

---

## Step 2 — If DRY: choose _how_ to DRY (3 levels)

You want the **lowest coupling** approach that still gives you SSOT.

### DRY Level 1 (Best): Shared pure module

- Put normalization in a separate module: `normalize(text, profile) -> normalized_text (+ metadata optionally)`
- Both commands import it
- Tests target the module, not Sublime UI glue

✅ Most robust  
✅ Easiest to test  
✅ Lowest editor-state coupling

### DRY Level 2: Shared pipeline invoked through a service object

- `Normalizer` class with config/profiles
- Useful if you track state, options, or cache tokens

✅ Good when you have multiple profiles  
✅ Still testable

### DRY Level 3: Command #2 calls command #1 (least ideal DRY)

- You literally invoke the Sublime command from another command

⚠️ Couples logic to editor UI/state  
⚠️ Harder to unit test  
✅ Quick to wire up

**Rule:** If you can do Level 1, don’t do Level 3.

---

## Step 3 — If WET: require guardrails (otherwise it’s technical debt)

If you choose WET, you must implement one of these:

### Guardrail 1: Drift detection (hash or version skew)

- On run, compare `normalizer_signature` between #1 and embedded block in #2
- If mismatch: **non-blocking warning** (continue execution)

### Guardrail 2: Generate #2 from #1 (treat duplication as a build artifact)

- #2’s embedded block is auto-copied during a build step
- Humans don’t manually maintain both

### Guardrail 3: “Compatibility layer” contract tests

- Same input corpus → same normalized output in both implementations
- Warn if parity fails

**Rule:**  
WET is only acceptable if you can **prove** it’s not drifting—or warn loudly when it does.

---

# The Scoring Model (fast + deterministic)

Score each dimension 0/1 (no/yes). Add them.

**DRY Pressure Score (0–10):**

1. Changes expected (tuning)
2. Multiple consumers
3. Silent wrongness risk
4. Hard-to-test duplication
5. Semantic sensitivity (parsing/extraction depends on it)
6. High edge-case surface area
7. Performance/caching concerns (shared cache is beneficial)
8. Need multiple normalization profiles
9. Want CLI reuse outside Sublime
10. Long-term ownership / maintainability matters

**Decision:**

- **0–3 → WET acceptable**
- **4–6 → DRY preferred**
- **7–10 → DRY required**

Given your context (formatting + object extraction + normalization drift risk), you’ll almost always land **7+** → **DRY required**.

---

# Waterfall ASCII Decision Tree (visual, deterministic)

START

|

|--[1] Is the shared logic a "core capability" (normalization/parsing)?

|        |-- NO --> WET is fine (simple helpers, small snippets)

|        |

|        '-- YES

|             |

|             |--[2] Will it evolve/tune over time (likely >1 change)?

|             |        |-- NO --> go to [3]

|             |        '-- YES --> DRY (Shared module)  ✅

|             |

|             |--[3] Does drift cause silent wrongness (extract differs)?

|             |        |-- NO --> go to [4]

|             |        '-- YES --> DRY (Shared module + tests) ✅✅

|             |

|             |--[4] Are there 2+ consumers now or planned soon?

|             |        |-- NO --> go to [5]

|             |        '-- YES --> DRY (SSOT) ✅

|             |

|             |--[5] Is DRY implementation cost LOW/MED (importable module)?

|             |        |-- YES --> DRY (Level 1/2) ✅

|             |        '-- NO

|             |              |

|             |              |--[6] Is WET duplication SMALL + STABLE + isolated?

|             |              |        |-- NO --> DRY anyway (pay the cost once) ✅

|             |              |        '-- YES

|             |              |              |

|             |              |              '-- WET allowed ONLY with guardrails:

|             |              |                     - drift detection (hash/version)

|             |              |                     - non-blocking warning

|             |              |                     - parity tests on corpus

|             |              |

|             '-- END

|

END

---

# Apply it to your specific case (quick evaluation)

## Your case signals

- Shared logic = **normalization pipeline** (core capability) → Gate A/E triggers
- Drift risk = **extractor correctness** diverges silently → Gate B triggers
- Consumers = **#1 and #2 now** → Gate C triggers
- Edge cases = comments, strings, bracketed identifiers, weird formatting → Gate D triggers
- Likely future growth (more Sublime commands, export, CLI) → Gate A/C/I triggers

**Outcome:** **DRY required**, specifically **DRY Level 1** (shared module + tests).

---

# “Warn but don’t fail” terminology (so you can sound senior)

Use these phrases when describing the WET guardrail option:

- **Non-blocking warning**
- **Soft fail**
- **Drift detection**
- **Version skew**
- **Parity check**
- **Compatibility check**
- **Degraded mode** (if it still runs but flags lower confidence)
- **Diagnostics** (warnings emitted as diagnostics)

---

# Implementation posture (no code, just the rule)

**Best approach vector:**

1. DRY into a shared normalization module
2. Both commands depend on it
3. Add a “golden corpus” of input SQL samples
4. Run parity tests on that corpus before you change normalization behavior

That gives you: **SSOT + safety net + controlled evolution**.

---

## Quick follow-up (1 question, high leverage)

Do you want **normalization to be strictly cosmetic** (formatting only), or do you allow it to change token boundaries (e.g., trimming inside strings/comments)?

- If **cosmetic only** → easy DRY module
- If **token-affecting** → you’ll want normalization to also return **token maps / offset mapping** so extractor remains deterministic

Tell me which, and I’ll tailor the “contract” (what normalization guarantees) in a tight spec you can paste into your repo as documentation.

---

You’re thinking about this exactly the right way: **shared normalization logic** is a cross‑cutting concern, and “object extraction” is downstream behavior that should consume the same canonical pre-processing step.

Below is a **modern, robust** approach (DRY), an **acceptable WET-with-guardrails** alternative, what senior engineers typically call the “warn but don’t fail” mechanism, and then a **concise re‑prompt** you can paste to sound crisp and experienced.

***

# 1) Recommendation: DRY via a Shared Normalization Library (Best Practice)

## Why DRY wins here

Your #1 command (“format like Redgate”) contains a **normalization pipeline** (tokenization, whitespace normalization, keyword casing, indentation rules, etc.).  
Your #2 command (“extract/isolate objects”) also depends on parsing and normalization to be reliable.

If they diverge, you get:

*   inconsistent results across commands
*   brittle bug fixes (fix twice)
*   “works in formatter but breaks in extractor” drift

So the senior approach is:

> **Make normalization a standalone module** with a stable interface, and have both commands import it.

### The design pattern name

*   **Single Source of Truth (SSOT)** for normalization
*   **Shared library / internal package**
*   **Pipeline / preprocessor stage**
*   **Composition over duplication**

## Concrete architecture (clean + testable)

### A) Create a `normalization.py` (or package)

*   `normalize(text, profile="tsql_redgate_like") -> NormalizedText`
*   Possibly returns structured metadata too (token map, offsets, line mapping)

### B) Command #1 becomes

*   `text -> normalize() -> format_render() -> output`

### C) Command #2 becomes

*   `text -> normalize() -> extract_objects() -> output`

This is **composition**: #2 “calls” normalization, but not by literally calling the Sublime command; it calls the **shared function** that both commands use.

### Why not call command #1 from #2?

You *can*, but it’s less robust because:

*   Sublime command invocation couples UI/command concerns to core logic
*   Harder to test outside Sublime
*   Adds dependency on editor state (selections, views, etc.)

**Better**: both commands call the same pure function(s).

***

# 2) Alternative: WET + “Sync Check” (Acceptable, but second-best)

You proposed embedding #1’s normalization logic inside #2 and having a “sync check.”

This is sometimes used when:

*   you can’t share code easily due to packaging constraints
*   you’re prototyping quickly
*   you want #2 to be self-contained (portability)

But WET is only survivable if you add real guardrails.

## What “sync check” is called in full-stack engineering

Common names:

*   **Drift detection**
*   **Consistency check**
*   **Parity check**
*   **Version skew check**
*   **Staleness warning**
*   **Integrity check**
*   **Compatibility check**
*   **Out-of-sync warning**

The overall idea is:

> “Proceed, but emit a warning when embedded logic diverges from canonical.”

That behavior (“warn but do not stop execution”) is typically:

*   **Non-blocking warning**
*   **Soft-fail**
*   **Degraded mode**
*   **Warning-only validation**
*   **Advisory check**
*   **Lint warning** (if it’s static)

## The robust way to do WET-with-guardrails

If you must embed:

### Option B1: Embed with a version stamp

*   Put a constant like `NORMALIZER_VERSION = "2026.04.16"`
*   \#1 has the same constant
*   \#2 compares; if mismatch: warn

Pros: simple  
Cons: humans forget to bump versions

### Option B2: Embed with a hash fingerprint (better)

*   Compute a hash of the canonical normalizer block in #1
*   Store expected hash in #2
*   At runtime, recompute and compare → warn on mismatch

Pros: automatic drift detection  
Cons: a bit more machinery

### Option B3: Generate #2 from #1 (best WET approach)

*   Treat #2 as “built artifact”
*   A small build step copies normalizer block into #2
*   CI or a local script regenerates it

Pros: ensures sync  
Cons: more workflow overhead

***

# 3) My senior recommendation (pragmatic + robust)

## Prefer DRY, but do it in the right layer

✅ **Extract normalization into a pure module**  
✅ Both Sublime commands import and use it  
✅ Add unit tests for normalization + extraction to lock behavior

### Add “profiles” so you don’t paint yourself into a corner

Instead of hardcoding “Redgate-like”, support:

*   `profile="redgate_like"`
*   `profile="extractor_strict"`
*   `profile="minimal"`

This keeps your extractor stable if you ever tweak formatting preferences.

### Contract boundary suggestion

*   Normalization should guarantee:
    *   stable whitespace rules
    *   predictable keyword casing
    *   comment preservation rules
    *   no semantic changes

Then extraction can assume normalized input.

***

# 4) Where your “warn but don’t fail” idea fits (and how to phrase it)

Even with DRY, you may still want warnings for:

*   unsupported syntax
*   ambiguous parsing
*   suspicious constructs (`SELECT *`, temp tables, dynamic SQL, etc.)
*   extraction confidence score

That’s a real, mature pattern:

*   Hard errors only when correctness is impossible
*   Warnings when correctness is uncertain

This is often described as:

*   **Best-effort mode**
*   **Graceful degradation**
*   **Non-fatal diagnostics**
*   **Observability-first tooling**

***

# 5) Decision table (fast)

## Use DRY when…

*   both commands will evolve
*   you want reliability
*   you want tests
*   you want one place to fix bugs

## Use WET + drift detection when…

*   you need self-contained scripts
*   distribution constraints are real
*   you’re bridging legacy structure temporarily

If you’re building this as a durable internal toolchain: **DRY is the right call**.

***

# 6) “Senior prompt engineer” rewrite (copy/paste)

Here are a few concise ways to rephrase your ask so it reads like a seasoned engineer:

## Version A (most professional)

> I have two Sublime commands: (1) a T-SQL formatter with a Redgate-like normalization pipeline and (2) an object-extractor that currently has its own normalization. I want to eliminate behavioral drift. Should I refactor normalization into a shared library (single source of truth) consumed by both commands, or keep duplication and add drift detection with non-blocking warnings? Please recommend an architecture that’s testable, modular, and minimizes coupling to editor state.

## Version B (short + punchy)

> I’m trying to prevent normalization drift between two Sublime Python commands (formatter + extractor). Should I centralize normalization as a shared module and have both commands call it, or duplicate and implement drift detection (hash/version parity check) with soft warnings? Recommend the most robust approach.

## Version C (names the patterns explicitly)

> I want a SSOT normalization layer used by both my formatting and extraction commands (composition over duplication). If duplication is unavoidable, I’d like drift detection (parity check) that warns but doesn’t fail. What’s the cleanest design and terminology for this?

***

# 7) Quick clarifying questions (only the ones that matter)

To pick the cleanest implementation approach:

1.  Do you want these commands to work **outside Sublime** too (CLI usage)?
    *   If yes: DRY module + CLI wrapper is ideal.

2.  Does #2 rely on **original character offsets/positions** for extraction?
    *   If yes: normalization should return a **mapping** (original → normalized offsets).

3.  Is “Redgate-like” purely cosmetic formatting, or does it change token boundaries (e.g., collapsing whitespace inside strings, comments)?
    *   If it ever touches strings/comments, extraction needs stricter guarantees.

Answer those and I’ll give you the final architecture blueprint (module boundaries + minimal interface contract) in a way that matches how you already structure Sublime commands.
