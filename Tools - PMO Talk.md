ADO STRUCTURE
- 1.1.0.0 - Epics: 3-6 months
- 1.1.1.0 - Feature: 1-3 months
- 1.1.1.1 - Story: 1/2 month
- Task: 2-3 days

STANDUP
- *Round-robin* 
- What did you complete yesterday?
- What will you complete today? 
- Do you have any blockers? 
# Spike
target-outcome: Documented recommendation or decision
part of User Stories
time-boxed (typically 1-3 days)
learning vs building


Clean, high‑signal breakdown that cuts through the jargon and gives you the diagnostic clarity you’re looking for. I’ll keep it concise but vivid, with a short story for each so you can _feel_ the difference in how the work actually flows.

Smile Doctors is Kanban; but really Ad-hoc
- Ad-hoc -- No process. Who yells loudest, what's on fire, what someone remembers
	- Interruptions welcome; Everything half-done; No planning
- Kanban -- Fluid FIFO but PRIORITY-based not Time-based; 2 priority limit per week
	- Work when capacity frees up; 
- Waterfall -- Start only after reqM gathered; reqM don't change midstream
	- clear reqM → design → build → test → deploy
- SCRUM -- Highly structured + planned, 2 week commitments, evaluate for next sprint. 


---

# 🧭 The Four Work Styles — Material Differences + Mini‑Stories

## **1. SCRUM — “Time‑boxed, team‑committed, iterative”**

**Core idea:**  
Work happens in fixed-length sprints (usually 2 weeks). The team commits to a defined scope, works in cross-functional collaboration, and inspects/adapts at regular ceremonies.

**How it feels:**  
Predictable cadence, structured rituals, sprint goals, and a shared commitment to finishing what was planned.

**Mini‑story:**  
A BI team starts a 2‑week sprint. They commit to building a new KPI, fixing two data quality issues, and updating a dashboard. Mid-sprint, a VP asks for a “quick” new metric. The team says, “We’ll evaluate it for next sprint.” Work is protected; scope is stable.

**Diagnostic signal:**  
If your team constantly changes priorities mid-sprint, or doesn’t actually commit to a sprint goal, you’re _not_ doing Scrum—regardless of what Azure DevOps board you use.

---

## **2. Kanban — “Continuous flow, pull-based, WIP-limited”**

**Core idea:**  
No sprints. Work flows continuously. The team pulls new work only when capacity frees up. WIP limits prevent overload.

**How it feels:**  
Smooth, steady, low-drama. Priorities can shift at any time because nothing is “locked” into a sprint.

**Mini‑story:**  
A data engineering team has a Kanban board with WIP limits: only 2 items in “In Progress.” A new urgent data fix comes in. They finish one item, then pull the urgent one next. No sprint commitments to break, no ceremonies to reschedule.

**Diagnostic signal:**  
If your team says “we do Scrum” but actually works on whatever comes in next, with no sprint boundaries, you’re doing Kanban.

---

## **3. Waterfall — “Sequential, gated, plan-first”**

**Core idea:**  
Work moves through predefined phases: requirements → design → build → test → deploy. You don’t go backward unless something breaks.

**How it feels:**  
Heavy upfront planning, long timelines, and a strong expectation that requirements won’t change midstream.

**Mini‑story:**  
A reporting project begins with a 4‑week requirements phase. Only after sign-off does the team design the semantic model. Only after that do they build. When the business changes a requirement halfway through, the PM says, “That will be a change request.”

**Diagnostic signal:**  
If your team insists on full requirements before starting, or treats changes as disruptions rather than normal, you’re closer to Waterfall.

---

## **4. Ad Hoc — “Reactive, unstructured, interrupt-driven”**

**Core idea:**  
No process. Work is done based on who yells loudest, what’s on fire, or what someone remembers.

**How it feels:**  
Chaotic. No prioritization, no WIP limits, no commitments, no predictability.

**Mini‑story:**  
A clinician emails a BI analyst directly asking for a new metric. The analyst starts working on it immediately. Halfway through, someone Slacks them about a broken dashboard, so they switch. Then a director calls about a data export. Everything is half-done, nothing is planned.

**Diagnostic signal:**  
If your team’s work is driven by interruptions, not a board or a plan, you’re in Ad Hoc territory—even if you _say_ you’re doing Scrum.

---

# 🧩 Quick Comparison Table

|Method|Cadence|How Work Starts|How Change Is Handled|Team Experience|
|---|---|---|---|---|
|**Scrum**|Fixed sprints|Planned & committed|Next sprint|Predictable, structured|
|**Kanban**|Continuous|Pulled when capacity frees|Anytime|Smooth, flexible|
|**Waterfall**|Sequential phases|After full requirements|Change request|Rigid, plan-heavy|
|**Ad Hoc**|None|Whoever asks loudest|Constantly|Chaotic, stressful|

---

# 🧠 How to Diagnose Your Team (fast)

Ask yourself:

- **Do we commit to a sprint goal and protect it?**  
    → If no, you’re not doing Scrum.
    
- **Do we limit WIP and pull work only when ready?**  
    → If no, you’re not doing Kanban.
    
- **Do we require full requirements before starting?**  
    → If yes, you’re doing Waterfall.
    
- **Do we switch tasks constantly based on interruptions?**  
    → If yes, you’re doing Ad Hoc.
    

Given what you’ve described in past conversations—interrupt-driven work, shifting priorities, and lack of protected sprint scope—your team likely _says_ Scrum but _operates_ as a hybrid of **Kanban + Ad Hoc**, with occasional Waterfall tendencies when leadership wants “full requirements.”

If you want, I can help you map your actual workflow to these models and show where the friction comes from.

# PMO AUDIENCE AND ROLES 
As a ...
## Data Engineering
Data Movement; Robust Frameworks
Applications; High-Volumne

## Data Analyst
Pre-Conformed Data; Mining for Insights
Interpreting Data into 

## DATA SCIENTIST
Experimentation on Causality (Regressions)
Correct Heuristics on Correlations
Impact Analysis: Initiative + AB Testing (Before or After Snapshots)

- Data Architect
- Data Product Owner {Steward, }
- Data Consumer
