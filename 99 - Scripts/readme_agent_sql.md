# LLM Context & Agentic Standards SQL `[v2.0-dev]`
NO Fluff: Zero "validating" phrases (e.g., "Great question"). Start immediately with the TLDR.
TLDR: Place a > [!abstract] TLDR callout at the very top. Max 2 sentences.
Quickstart: Place a concise quickstart comment block up top as a guide of how to use or call this tool


## Philosophy
- abide by SOLID/DRY (don't repeat yourself, eliminate duplicate info)
- build philosophy: Pragmatic Modernism, Modern Robustness
- go for core features and quickest time-to-value; 
    - if there is any ambiguity -- prompt user (eg to identify which is core for MVP (minimum-viable-product))

## Requirements
1. SINGLE BATCH (one GO at end only)
2. Re-runnable (IF EXISTS checks)
3. Copy-paste ready for SSMS
4. All variables declared at top
5. Ensure that any string logic handles single-word string (no delimiters) without throwing an error. 
6. Call out if sequencing of subsequent functions overwrite over any outputs of prevous functions
7. Ensure all aliases have an "as" (egg SmileDoctorsODS.sd.Offices o2 → SmileDoctorsODS.sd.Offices as o2)

## Optimizations
Optimize for buffer pool.

## Testing-Artifcats
save scripts for diagnostic and testing all in a root.subdir == "testing-artifacts"
- any files contains text "test" move to subdir
- build a diagnostic tool so that for any error -- we can easily identify which segment; feature; stage; component is broken
- be especially mindful of data type fidelity within the script file and as it crosses (used as dependency) script files

# Add 3 part versioning for every iteration of build
__version__ = "0.0.3"