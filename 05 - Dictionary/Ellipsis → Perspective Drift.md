Ellipsis enables perspective drift. When precision qualifiers disappear (ellipsis), people unconsciously anchor the same term to _their_ context (perspective drift) — and drift becomes invisible.

- [[#Side‑by‑side distinguisher|Side‑by‑side distinguisher]]
- [[#Ellipsis|Ellipsis]]
- [[#Ellipsis#Example: Exam Outcome|Example: Exam Outcome]]
- [[#Perspective Drift|Perspective Drift]]
	- [[#Example: Exam Outcome#Core characteristic|Core characteristic]]

### Semantic Compression
Complex definitions collapse into shorthand that loses constraints and assumptions.
"How we got here" as to why ellipsis happened

Due to [[Heuristics]]

### Semantic Drift
Meanings shift over time while labels remain stable.


## **Side‑by‑side distinguisher**

| Aspect             | Ellipsis                 | Perspective Drift                |
| ------------------ | ------------------------ | -------------------------------- |
| Root cause         | Missing qualifiers       | Different reference frames       |
| Failure mode       | Under‑specified language | Overloaded meaning               |
| Speaker intent     | “This is obvious”        | “This is correct (from my view)” |
| Fix                | Decompress definitions   | Declare perspective explicitly   |
| Structural symptom | False simplicity         | False polyhierarchy              |


# Ellipsis 
**Ellipsis** is the linguistic compression of a concept where critical qualifiers are omitted, assumed, or silently dropped. It is when words silently drop meaning. 

Meaning is lost because the words got shorter, not because people disagree.

Core characteristic

The speaker believes the meaning is still intact
The listener fills in missing parts themselves
Different listeners fill in different gaps

Institutionalized Ellipsis: The organization relies on shared shorthand instead of shared definitions.

## Example: Exam Outcome

Original Full Meaning: 
“The patient status 5 days after a completed new patient exam appointment, derived from patient status events occurring after appointment_end_datetime, locked once the 5‑day window closes, and subject to PMS user entry gaps.”

People shorten it to:
“exam outcome”

Now listen to what different teams hear:

Ops hears:
“Did the exam turn into something?”

Clinical hears:
“Was the exam successful from a care perspective?”

Finance hears:
“Did this drive revenue or a contract start?”


Analysts hear:
“Some field we already have somewhere.”

Same phrase. Four different implied definitions.

### Resulting damage
- Someone tries to nest exam_outcome under appointment-types
- Someone else nests it under consult_outcome
- Someone else treats it as a dimension
- Someone else builds it as a metric

Suddenly it looks poly-hierarchical, but it isn’t.
📌 The real issue:
The ellipsis hid time window + locking semantics, so people tried to encode meaning via hierarchy instead of definition.

# Perspective Drift
**Perspective drift** occurs when **different groups anchor the same term to different frames of reference**, while still believing they are talking about the same thing.

> Meaning shifts because **the center of gravity moves**, not because words are missing.

### Core characteristic

- The word remains complete
- The **reference frame changes** (time, purpose, user)
- Each perspective is internally coherent

Perspective drift occurs when the center of truth changes depending on who is speaking, but the label stays the same.
The concept doesn’t change.
The mental anchor does.

"Appointment": One Word, Three Anchors

1. Scheduling anchor: Appointment = future time slot
2. Ops anchor: Appointment = utilization + capacity
3. Analytics anchor: Appointment = historical event

All valid. Same word.

Now watch what happens:
- Ops introduces is_historical
- Scheduling already thinks in future/past
- Analytics needs historical determinism
- PMS UI allows retroactive edits

So now:
- appointment feels unstable
- someone tries to split it conceptually
- others try to hang outcomes directly off it

📌 Perspective drift makes stable entities feel unreliable, which tempts people to create “clean” versions instead of modeling constraints explicitly.