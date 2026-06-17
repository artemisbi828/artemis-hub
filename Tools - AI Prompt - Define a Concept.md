**Role:** Senior analytics systems architect with deep experience in healthcare PMS/ERP platforms, semantic modeling, and executive-facing data governance.

**Task:** Define these concepts. Illustrate semantic edges via ascii trees so I can mature my mental model. Output in a structured Markdown template designed for Obsidian.md.

```
- **Partial pulls**: rate limits, timeouts, paging bugs, retries that stop early
- **Incremental drift**: watermark bugs, clock skew, updates arriving late
- **Duplication**: replay without idempotency, “at least once” delivery, merge key mistakes
- **Semantic mismatch**: grain confusion (line vs header), wrong join keys, missing dimensions
- **Source-side shape changes**: new enums, new fields, renamed fields, nullability changes
```

**Guidelines:** 
- Open w TLDR, describe in EIL5, identify clear conceptual boundaries and delineation markers
- Definitions: clinical, concise 1-3 high fidelity descriptions
- Prefer tables, ASCII trees vs verbose text
	- flow diagrams and lifecycle stages 
	- mono-hierarchal or poly-hierarchal relationships 
	- hierarchal vs orthogonal semantic edges
- Generate Examples: 1-3 (max) per application or context

---
**Optional:** 
- To sharpen conceptual boundaries and delineators, feel free to use acid tests. 

> [!warning] Acid Test
> A measure has grain **X** if it is meaningful and stable when evaluated for **one instance of X without aggregation**. The value is **semantically complete, comparable, and interpretable** for **any single instance of X** at the evaluation time — _without hidden lifecycle context_.

**Output:** 20260415_Summary.md
**Output-Location:** Root

---
**Role 2**: Technical Systems Architect & Logic Specialist.
Use the sample output below as a template: 



---
**Task:** create a mental model 1-pager. clearly identify if this is a single-concept, multi-concept. 
**Concepts:**
```
git, azure, terraform, sql mesh, snowflake, atlan -- tooling we have for our data platform and pipeline project

highlighted areas that need to be downloaded to my mental model
- Git Monorepo vs Polyrepo
- Azure RM and how Terraform has no problem if thjat's the case
- Atlan and access precursors
	- private link vs public link to snowflake
	- azure vnet containers
	- private vs public endpoints
- infra directory on Azure
- infra vs intra vs extra
```

**Role:** Senior analytics systems architect with deep experience in healthcare PMS/ERP platforms, semantic modeling, and executive-facing data governance.

**Guidelines:** 
- Open w TLDR, describe in EIL5, identify clear conceptual boundaries and delineation markers
- Definitions: clinical, concise 1-3 high fidelity descriptions
- Prefer tables, ASCII trees vs verbose text
	- flow diagrams and lifecycle stages 
	- mono-hierarchal or poly-hierarchal relationships 
	- hierarchal vs orthogonal semantic edges
- Generate Examples: 1-3 (max) per application or context
- To sharpen conceptual boundaries and delineators, feel free to use acid tests. 





---
