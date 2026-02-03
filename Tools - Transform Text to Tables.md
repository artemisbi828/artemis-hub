**Concise High‑Fidelity Prompt**
**“Flatten this hierarchical list by prefixing each child with its full parent path. Use `|` as the separator. Each indented item becomes: `Parent | Child`. Preserve ordering.”**

**If you want it even more explicit**
**“For every indented line, prepend all parent labels (from nearest non‑indented ancestor) separated by `|`. Output one flattened line per leaf.”**

**Example Included (optional)**
BEFORE: 
NPS / Swell 
  NPS Responses 
  NPS Score

AFTER:
NPS / Swell | NPS Responses 
NPS / Swell | NPS Score