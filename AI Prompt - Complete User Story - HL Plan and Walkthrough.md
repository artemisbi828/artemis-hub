2026-07-02 01:03 PM -- pasted so that I can reuse for SCD2 tables

Below is a reusable, concise prompt template with all inputs centralized up top.

````markdown
# Prompt: User Story Execution Plan + Repo/Wiki Cross-Check

## 0. Inputs

### User Story Text
```text
PASTE USER STORY / ACCEPTANCE CRITERIA HERE
````

### Business / Technical Context

```text
PASTE ANY RELEVANT CONTEXT HERE

Example:
- Source system:
- Target environment:
- Current state:
- Target state:
- Known access / credential notes:
- Constraints:
```

### Primary Reference Paths / Docs

#### Project Wiki Root

```text
C:\Repos\sd-edw\project-ascend\project-wiki
```

#### Codebase Root

```text
C:\Repos\sd-edw\project-ascend\data-platform
```

#### Focus Reference Docs

```text
- PROJECT STANDARDS: <path-or-url>
- SOURCE SYSTEM DOCS: <path-or-url>
- RELATED PRIOR STORY / DESIGN DOC: <path-or-url>
```

### Sample Data / Tables, if applicable

```text
TABLE SAMPLE: <table_name>

<paste sample rows here>
```

### Desired Output File

```text
C:\Repos\sd-edw\ai-context\plans\hl-plan-<short-topic>.md
```

***

## 1. Objective

Review the supplied user story, project wiki, focus reference docs, and current codebase patterns to produce a high-level execution plan that helps me complete the story efficiently while conforming to project standards.

Prioritize sources in this order:

1. Focus reference docs
2. Project wiki
3. Existing codebase implementations for similar sources/pipelines
4. Adjacent or related internal docs
5. External/web references only if needed to resolve gaps or validate assumptions

***

## 2. Tasks

### A. Reiterate and Validate the Ask

First, restate the objective in clear terms.

Then identify only materially blocking gaps that would prevent a practical MVP execution plan.

Use this format:

```markdown
## Clarifying Questions

### Blocking
1. ...

### Non-Blocking / Can Proceed With Assumptions
1. ...
```

If there are no blocking gaps, proceed using explicit assumptions.

***

### B. Cross-Check Against Standards and Existing Patterns

Review the focus docs, wiki, and codebase for:

* Existing ingestion config patterns
* Existing source connection patterns
* Key Vault / secret naming patterns
* Bronze table DDL conventions
* Schema, naming, and data type standards
* Folder / repo placement standards
* PR / peer review expectations
* Similar implemented data sources that can be reused as templates

Call out inconsistencies, collisions, or standards gaps.

Use this format:

```markdown
## Standards / Pattern Findings

| Area | Observed Pattern | Source / Filepath | Relevance | Risk if Ignored |
|---|---|---|---|---|
| ... | ... | ... | ... | ... |
```

***

### C. Generate High-Level Execution Plan

Create a markdown file at the requested output filepath.

The plan should be named:

```text
hl-plan-<short-topic>.md
```

Start with desired deliverables, then chunk the work into testable sections.

Required sections:

```markdown
# High-Level Plan: <Topic>

## 1. Desired Deliverables

| Deliverable | Description | Acceptance Signal |
|---|---|---|
| ... | ... | ... |

## 2. Recommended Execution Sequence

| Step | Workstream | Action | Validation / Done Criteria |
|---|---|---|---|
| 1 | Discovery | ... | ... |
| 2 | Connection / Secrets | ... | ... |
| 3 | Config | ... | ... |
| 4 | Bronze DDL | ... | ... |
| 5 | Testing | ... | ... |
| 6 | PR / Review | ... | ... |

## 3. Implementation Approach

### 3.1 Connection / Credential Setup
- ...

### 3.2 Ingestion Config
- ...

### 3.3 Bronze Table Schema / DDL
- ...

### 3.4 Testing / Validation
- ...

### 3.5 PR Preparation
- ...

## 4. Pitfalls and Collision Risks

| Risk | Why It Matters | Mitigation |
|---|---|---|
| ... | ... | ... |

## 5. Assumptions

| Assumption | Reason | Needs Validation? |
|---|---|---|
| ... | ... | ... |

## 6. Recommended Next Concrete Walkthrough

List the next detailed walkthrough I should ask for after reviewing this plan.
```

***

## 3. Output Requirements

* Be concise, direct, and execution-oriented.
* Avoid generic advice.
* Prefer project-specific references and filepaths.
* Surface newbie pitfalls explicitly.
* Separate blocking issues from non-blocking assumptions.
* Do not over-engineer the plan.
* Optimize for getting to a valid MVP, then hardening.
* If you find conflicting standards, flag them instead of silently choosing one.
* If you create or modify files, summarize:
  * filepath created/modified
  * purpose
  * remaining manual steps

***

## 4. Final Response Format

After generating the file, respond with only:

```markdown
## Result

Created:

- `<output-filepath>`

## Key Findings

- ...
- ...

## Blocking Questions, if any

1. ...

## Recommended Next Prompt

"Give me the concrete walkthrough for Step 1: <step name>."
```

````

## Cleaner filled-in version for your Swell use case

```markdown
# Prompt: Swell Ingestion User Story Execution Plan

## 0. Inputs

### User Story Text
```text
USER STORY 24826: Swell — provision Bronze table schema
As a Data Engineer, I want the target Bronze tables and schema defined and provisioned in Snowflake so that incoming Swell data has a structured landing zone ready for pipeline deployment.

Given the ingestion config, when Bronze tables are provisioned, then schema matches the defined Swell field mapping with correct data types and grain.

Acceptance Criteria:
- Target Bronze tables and schema created in ANALYTICS_DEV
- DDL committed to repo and peer reviewed

USER STORY 24765: Swell ingestion — connection setup & config
As a Data Engineer, I want the Swell source connection confirmed and the ingestion config file created so that the pipeline build has a validated foundation to build from.

Given the Swell API, when credentials are configured, then connection is confirmed and credentials are stored in Key Vault.
Given the standard ingestion template, when applied to Swell, then a config file is created and committed to repo.

Acceptance Criteria:
- Credentials stored in Key Vault; access verified by a second engineer
- Config file committed to repo, peer reviewed, following standard template structure
````

### Business / Technical Context

```text
Source system: Swell API
Target state: Project Ascend ingestion framework
Target database/environment: Snowflake ANALYTICS_DEV
Target layer: Bronze
Current state: I have access to existing Swell Key Vault credentials for SD.
Need: Move or recreate Swell secrets into the Project Ascend target Key Vault pattern.
```

### Primary Reference Paths / Docs

#### Project Wiki Root

```text
C:\Repos\sd-edw\project-ascend\project-wiki
```

#### Codebase Root

```text
C:\Repos\sd-edw\project-ascend\data-platform
```

#### Focus Reference Docs

```text
- PROJECT STANDARDS: https://dev.azure.com/SmileDoctorsIT/Project%20Ascend/_wiki/wikis/Project%20Ascend%20Wiki/354/Azure-Container-Instance-Reference
- SWELL DOCUMENTATION: https://dev.azure.com/SmileDoctorsIT/Project%20Ascend/_wiki/wikis/Project%20Ascend%20Wiki/497/23466-Validate-NPS-and-Experience-Feedback-Source-Fields
```

### Sample Data / Tables

```text
TABLE SAMPLE: reviews

columns:
- id
- locationId
- reviewDate
- reviewUpdatedDate
- rating
- normalizedRating

sample grain candidate:
- one row per Swell review id
```

```text
TABLE SAMPLE: answers

columns:
- name
- externalId
- answer
- date
- locationId
- teamId
- id

sample grain candidate:
- one row per Swell answer id
```

### Desired Output File

```text
C:\Repos\sd-edw\ai-context\plans\hl-plan-ingest-swell-api.md
```

***

## 1. Objective

Review the supplied Swell user stories, project wiki, focus reference docs, and current data-platform repo patterns to produce a high-level execution plan for completing:

1. Swell source connection and ingestion config setup
2. Swell Bronze table schema and DDL provisioning in Snowflake ANALYTICS\_DEV

Prioritize sources in this order:

1. Focus reference docs
2. Project wiki
3. Existing codebase implementations for similar API-based sources
4. Adjacent or related internal docs
5. External/web references only if needed

***

## 2. Tasks

### A. Reiterate and Validate the Ask

Restate the objective.

Then identify materially blocking gaps only.

Use this format:

```markdown
## Clarifying Questions

### Blocking
1. ...

### Non-Blocking / Can Proceed With Assumptions
1. ...
```

If there are no blocking gaps, proceed using explicit assumptions.

***

### B. Cross-Check Against Standards and Existing Patterns

Review the focus docs, wiki, and codebase for:

* API ingestion config templates
* Existing source config examples
* Key Vault naming and secret reference standards
* Snowflake Bronze DDL conventions
* Schema naming conventions
* Data type conventions
* Grain expectations
* Repo folder placement
* PR / peer review requirements

Use this format:

```markdown
## Standards / Pattern Findings

| Area | Observed Pattern | Source / Filepath | Relevance | Risk if Ignored |
|---|---|---|---|---|
| ... | ... | ... | ... | ... |
```

***

### C. Generate High-Level Plan

Create:

```text
C:\Repos\sd-edw\ai-context\plans\hl-plan-ingest-swell-api.md
```

Required structure:

```markdown
# High-Level Plan: Swell API Ingestion

## 1. Desired Deliverables

| Deliverable | Description | Acceptance Signal |
|---|---|---|
| Source connection validated | Swell API credentials work from Project Ascend pattern | Connection test succeeds |
| Key Vault secrets configured | Swell credentials are stored using approved target-state naming | Second engineer verifies access |
| Ingestion config created | Config follows standard ingestion template | Config committed and peer reviewed |
| Bronze DDL created | Reviews and answers Bronze tables are defined in Snowflake | DDL executes in ANALYTICS_DEV |
| Validation checks completed | Schema, grain, and data types match mapping docs | Row-level/sample validation passes |
| PR prepared | Repo changes are staged with clear summary | PR is ready for review |

## 2. Recommended Execution Sequence

| Step | Workstream | Action | Validation / Done Criteria |
|---|---|---|---|
| 1 | Discovery | Identify existing API ingestion examples and Swell-specific docs | Template source selected |
| 2 | Secrets | Confirm target Key Vault pattern and Swell secret names | Access verified by second engineer |
| 3 | Connection | Test Swell API connectivity using target-state credentials | Successful response returned |
| 4 | Config | Create Swell ingestion config from standard template | Config passes repo pattern review |
| 5 | Bronze DDL | Create Snowflake Bronze DDL for Swell reviews and answers | DDL executes in ANALYTICS_DEV |
| 6 | Validation | Compare table schema to field mapping and sample data | Data types and grain validated |
| 7 | PR | Commit DDL/config/docs and prepare PR notes | PR ready for peer review |

## 3. Implementation Approach

### 3.1 Discovery
- ...

### 3.2 Connection / Credential Setup
- ...

### 3.3 Ingestion Config
- ...

### 3.4 Bronze Table DDL
- ...

### 3.5 Testing / Validation
- ...

### 3.6 PR Preparation
- ...

## 4. Pitfalls and Collision Risks

| Risk | Why It Matters | Mitigation |
|---|---|---|
| Existing SD secret names do not match Project Ascend pattern | Pipeline may fail at runtime | Mirror approved Project Ascend naming pattern |
| Ambiguous Swell grain between reviews and answers | Duplicate or incorrect Bronze tables | Define one grain per table before DDL |
| Timestamp precision mismatch | Data loss or comparison failures | Use project-standard timestamp type |
| API field names differ from Snowflake naming standards | Config/schema collisions | Apply canonical snake_case mapping if standard requires it |
| Moving secrets instead of copying/recreating | Existing workloads may break | Do not remove current-state secrets until target-state validation passes |

## 5. Assumptions

| Assumption | Reason | Needs Validation? |
|---|---|---|
| Reviews grain is one row per review id | Sample data includes unique review id | Yes |
| Answers grain is one row per answer id | Sample data includes UUID-like id | Yes |
| Bronze tables should preserve source-level fields with minimal transformation | Standard Bronze landing pattern | Yes |
| Target database is ANALYTICS_DEV | User story states this explicitly | No |

## 6. Recommended Next Concrete Walkthrough

After this plan is reviewed, ask:

"Give me the concrete walkthrough for Step 1: Discovery — identify the existing ingestion template and Swell-specific repo paths."
```

***

## 3. Output Requirements

* Keep the plan concise and execution-oriented.
* Use project-specific filepaths wherever found.
* Do not invent standards if the repo/wiki does not prove them.
* Flag inconsistencies explicitly.
* Separate blocking gaps from assumptions.
* Optimize for MVP completion first, then hardening.
* Highlight newbie pitfalls clearly.
* If files are created or modified, summarize exactly which paths changed.

***

## 4. Final Response Format

```markdown
## Result

Created:

- `C:\Repos\sd-edw\ai-context\plans\hl-plan-ingest-swell-api.md`

## Key Findings

- ...
- ...

## Blocking Questions, if any

1. ...

## Recommended Next Prompt

"Give me the concrete walkthrough for Step 1: Discovery — identify the existing ingestion template and Swell-specific repo paths."
```

```

Small wording fix I’d recommend in your original: replace **“move the keys over”** with **“recreate or register equivalent secrets in the Project Ascend target Key Vault pattern without disrupting current-state Swell secrets.”** This avoids implying you should delete/move existing production secrets.
```
