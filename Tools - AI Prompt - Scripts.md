```
**Concise High‑Fidelity Prompt**
**“Flatten this hierarchical list by prefixing each child with its full parent path. Use `|` as the separator. Each indented item becomes: `Parent | Child`. Preserve ordering.”**

**“For every indented line, prepend all parent labels (from nearest non‑indented ancestor) separated by `|`. Output one flattened line per leaf.”**

**Example Included (optional)**
BEFORE: 
NPS / Swell 
  NPS Responses 
  NPS Score

AFTER:
NPS / Swell | NPS Responses 
NPS / Swell | NPS Score
```

SAVEPOINT
- update prompt so that we include change log + when new imports detected, update the project map
- DAX = minimal footprint

## Philosophy
- abide by SOLID/DRY, FAST (don't repeat yourself, eliminate duplicate info)
- abide by Pragmatic Modernism, Modern Robustness, Sustainable Design; High-Integrity Architecture
- go for core features and quickest time-to-value; 
    - if there is any ambiguity -- prompt user (eg to identify which is core for MVP (minimum-viable-product))

**CRITICAL**: Verify these points before generating or committing code.

| Category       | ❌ Anti-Pattern (Reject)                             | ✅ Best Practice (Adopt)                                      |
| :------------- | :-------------------------------------------------- | :----------------------------------------------------------- |
| **Variables**  | `file_path` used for input, `path` for output       | **Distinct Naming**: `input_path` vs `output_path`.          |
| **Naming**     | User asks for `data.csv`, code outputs `file.csv`   | **Consistency**: Use USER defined variable names exactly.    |
| **Indexing**   | `df.iloc[row]` (0-based) vs input `row=5` (1-based) | **Explicit Offset**: Comment offset logic `row - 1`.         |
| **Logic**      | `if not empty` (Double negative)                    | **Positive Assertion**: `if present` or `if len > 0`.        |
| **Regex**      | `r'^col_'` (Misses `Col_`)                          | **Robustness**: `r'(?i)^col_'` (Case insensitive) + anchors. |
| **Types**      | `age > "18"` (Str/Int clash)                        | **Casting**: `int(age) > 18`.                                |
| **Edge Cases** | `avg = sum / count`                                 | **Protection**: `avg = sum / count if count > 0 else 0`.     |
| **Legacy**     | `.append()` (Pandas)                                | **Modern**: `pd.concat([])`.                                 |
| **IO**         | `df.to_csv(sep='\t')` to `.csv` file                | **Format Match**: Save tab-delimited as `.txt` or `.tsv`.    |
| **Flow**       | `func()` return value ignored                       | **Capture**: `result = func()`.                              |


# Testing-Artifcats
save scripts for diagnostic and testing all in a root.subdir == "testing-artifacts"
- build a diagnostic tool so that for any error -- we can easily identify which segment; feature; stage; component is broken
- be especially mindful of data type fidelity within the script file and as it crosses (used as dependency) script files
- 
---
## 📝 Script Documentation Standards

Every script (`.py`, `.ps1`, etc.) **must include**:

### 1. Invoke Instructions (Header Block)
Include clear usage examples at the top of each script in a comment block.

**Example for Python:**
```python
"""
SQL Query Join Cleaner
Analyzes SQL queries to identify and remove unused tables from FROM/JOIN clauses.

USAGE:
    # Analyze only (preview in terminal)
    python reduce_sql.py query.sql --analyze-only
    
    # Clean and generate output files
    python reduce_sql.py query.sql
    
    Creates:
        query_trimmed.sql  - Cleaned query with unused joins removed
        query_map.csv      - Table mapping (schema.table, alias, usage_type)
"""
```

**Example for PowerShell:**
```powershell
<#
.SYNOPSIS
    Brief description of what the script does

.USAGE
    # Example 1
    .\script_name.ps1
    
    # Example 2
    .\script_name.ps1 -Parameter "value"

.OUTPUTS
    Description of what the script produces
#>
```


### 2. Terminal Diagnostics
Create a change log prompt
**Log Output Example:**
```
2025-12-06 14:23:45 | INFO | Starting validation for csv_mapper_cleaner.py
2025-12-06 14:23:45 | DEBUG | Python: C:\vsWorkspace\shared-utils\.venv\Scripts\python.exe
2025-12-06 14:23:45 | DEBUG | Mode: development
2025-12-06 14:23:45 | INFO | ✅ venv check passed
2025-12-06 14:23:45 | DEBUG | Checking packages: pandas, openpyxl
2025-12-06 14:23:45 | INFO | ✅ All packages found
2025-12-06 14:23:45 | INFO | Validation complete in 45.2ms
```

#status/deferred/quick-paste-merge-later 
### 📊 Validation Mode Comparison Table

| Feature | Development | CI/CD | Production | Disabled |
|---------|-------------|-------|------------|----------|
| **venv Check** | ✅ Full | ✅ Full | ✅ Quick | ❌ Skip |
| **Package Scan** | ✅ Detailed | ✅ Detailed | ⚠️ Critical only | ❌ Skip |
| **Version Check** | ⚠️ Warn | ❌ Fail | ⚠️ Log only | ❌ Skip |
| **Missing Packages** | 🤝 Interactive install | ❌ Fail | ❌ Fail | ❌ Skip |
| **Auto-Update Map** | ✅ Yes | ✅ Yes (commit) | ❌ No | ❌ No |
| **Logging** | 🖥️ Console + File | 📄 File only | 📄 File only | ❌ None |
| **Performance** | ~50-100ms | ~50-100ms | ~1-5ms | ~0ms |
| **Interactive Prompts** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **Fail on Warning** | ❌ No | ✅ Yes | ❌ No | ❌ No |

---

### 🚀 Summary: Why This Architecture Works

#### Problems Solved

1. **"Works on my machine"** → venv validation ensures consistent environment
2. **Mid-execution failures** → Pre-flight checks before expensive operations
3. **Dependency drift** → Auto-update project_map.json tracks changes
4. **Cryptic errors** → Suggests exact pip install commands
5. **Debugging nightmares** → Detailed logs with timestamps
6. **Production overhead** → Fast validation mode for deployed apps
7. **Agent confusion** → Single source of truth (project_map.json)

#### Key Principles

- **Development**: Helpful, interactive, verbose - optimize for developer experience
- **Production**: Fast, silent, resilient - optimize for uptime and performance  
- **CI/CD**: Strict, fail-fast - optimize for catching issues before deployment
- **All Modes**: Log everything for post-mortem analysis

#### Next Steps

1. Implement `shared_utils/validators.py` with mode detection
2. Create `tools/verify_env.py` with --sync and --install flags
3. Generate initial `project_map.json` from workspace scan
4. Add validator one-liners to existing scripts by class
5. Test in development mode, validate auto-update works
6. Set up CI/CD with strict mode validation
---

Scripts must print progress indicators at different stages (minimum 2: beginning and end).
**Format:** Use `[step/total]` notation with descriptive messages

**Example Output:**
```
[1/4] Reading SQL file: stg_f_transactions.sql
      File size: 4,338 characters

[2/4] Parsing query structure...
[3/4] Analyzing table usage...
      Extracting table aliases... found 12 tables
      Extracting query clauses... done
      Scanning SELECT clause... 8 tables referenced
      Scanning WHERE clause... 2 tables referenced
      Scanning JOIN conditions... 12 bridge tables found
[4/4] Analysis complete!

[Analysis only mode - no files modified]

Completed in 0.01 seconds
```

**Implementation Examples:**

**Python:**
```python
import time
start_time = time.time()

print("[1/3] Loading data...")
# ... code ...

print("[2/3] Processing records...")
# ... code ...

print("[3/3] Saving results...")
# ... code ...

elapsed = time.time() - start_time
print(f"\nCompleted in {elapsed:.2f} seconds")
```

**PowerShell:**
```powershell
$startTime = Get-Date

Write-Host "[1/3] Loading data..." -ForegroundColor Cyan
# ... code ...

Write-Host "[2/3] Processing records..." -ForegroundColor Cyan
# ... code ...

Write-Host "[3/3] Saving results..." -ForegroundColor Cyan
# ... code ...

$duration = (Get-Date) - $startTime
Write-Host "`nCompleted in $($duration.TotalSeconds) seconds" -ForegroundColor Green
```
---
## 🎯 Philosophy: Dependency First

**The Problem:**
- Scripts fail mid-execution with `ModuleNotFoundError`
- Agents run code in global Python instead of project `venv`
- Package version mismatches cause silent failures
- "It worked in testing" but production uses different dependencies
- Multiple isolated venvs (one per project) prevent conflicts

**The Solution:**
- **State before Action**: Never execute code without verifying the environment state
- **Explicit over Implicit**: Do not assume packages exist; check the `project_map.json`
- **Isolation Integrity**: Code must refuse to run if it detects it is outside the designated `venv`
- **Version Lock**: Track exact versions to prevent "works on dev, breaks on prod" scenarios
- **Project Venvs Only**: Each project has its own `.venv/` directory. NO ROOT WORKSPACE VENV exists or should be created.

### Critical: No Root Workspace Venv

❌ **DO NOT CREATE**: `C:\vsWorkspace\.venv/`
✅ **USE INSTEAD**: Project-specific venvs only:
- `C:\vsWorkspace\projects_p\client-bridge\.venv/`
- `C:\vsWorkspace\projects_p\slidesms_v1\.venv/`
- `C:\vsWorkspace\projects_p\web-scraper-jira\.venv/`
- `C:\vsWorkspace\shared-utils\.venv/`

When feeding this document as context to an agent:
- Agent reads which project is being worked on
- Agent activates that project's `.venv/` (e.g., `.\.venv\Scripts\Activate.ps1` inside the project directory)
- Agent does NOT create or modify root workspace venv
- Agent works entirely within the project-specific environment

---

## 🗺️ The Source of Truth: `project_map.json`

To prevent "AI hallucinated dependencies," we maintain a JSON file that maps the file hierarchy to specific requirements.

### Required JSON Structure

```json
{
  "meta": {
    "project_name": "shared-utils",
    "python_version": "3.12",
    "venv_path": ".venv",
    "last_updated": "2025-12-06",
    "verified_by": "agent"
  },
  "dependency_tree": {
    "global_requirements": ["os", "sys", "logging", "pathlib"],
    "modules": [
      {
        "file_path": "scripts/csv_mapper_cleaner.py",
        "script_class": "data_processor",
        "imports_external": ["pandas>=2.1.0", "openpyxl"],
        "imports_internal": [],
        "status": "active",
        "last_verified": "2025-12-06"
      },
      {
        "file_path": "shared_utils/connectors/google_drive.py",
        "script_class": "api_connector",
        "imports_external": ["google-auth", "google-api-python-client"],
        "imports_internal": ["pathlib.Path"],
        "status": "active",
        "last_verified": "2025-12-06"
      },
      {
        "file_path": "scripts/reduce_sql.py",
        "script_class": "text_processor",
        "imports_external": [],
        "imports_internal": ["pathlib.Path", "typing.Set", "typing.Dict"],
        "status": "active",
        "last_verified": "2025-12-06"
      }
    ]
  },
  "dependencies": {
    "pandas": "2.1.0",
    "openpyxl": "latest",
    "google-auth": ">=2.0.0",
    "google-api-python-client": ">=2.0.0",
    "streamlit": "1.40.0",
    "streamlit-drawable-canvas": "0.9.3"
  }
}
```

### 📋 The Rule of Updates

1. **Read First**: Before editing a script, the agent reads `project_map.json`
2. **Update Map**: If a new library is added to the code, `project_map.json` **must** be updated first
3. **Verify**: Run `pip install` based on the JSON map, not the script imports alone
4. **Test**: After updates, run `verify_env.py` to ensure consistency

---

## 🤖 Agent Directives: Environment Setup & Execution

**When this document is provided as context, follow these rules strictly:**

### Never Create Root Workspace Venv
- ❌ DO NOT run: `python -m venv C:\vsWorkspace\.venv`
- ❌ DO NOT run: `python -m venv .venv` from workspace root
- ✅ If `.venv` exists in root: Ignore it entirely, it should not be there

### Activation Protocol
**Before running ANY Python code in a project:**

1. **Identify the project**: Determine which directory is the active project (client-bridge, slidesms_v1, shared-utils, etc.)
2. **Check for existing venv**: Look for `.venv/` in that project directory
3. **Activate if exists**: 
   ```powershell
   # From inside the project directory
   .\.venv\Scripts\Activate.ps1
   ```
4. **Create if missing** (only if you're setting up a new project):
   ```powershell
   cd C:\vsWorkspace\projects_p\[project_name]
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```
5. **Verify activation**: Check prompt shows `(.venv)` prefix

### Execution Checklist
- [ ] Confirm prompt shows `(.venv)` before running code
- [ ] Current directory is the project directory (not workspace root)
- [ ] `pip list` shows project-specific packages (not bloated global list)
- [ ] `sys.prefix != sys.base_prefix` returns True (in venv)
- [ ] Required packages from `project_map.json` are installed

### What NOT to Do
- ❌ Run code from workspace root without activating a project venv
- ❌ Install packages in global Python to solve import errors
- ❌ Create temporary venvs for testing (use existing project venvs instead)
- ❌ Modify `.venv` directories directly (use `pip install` instead)
- ❌ Leave venv activated after task completion (document deactivate step)

---

## 🛡️ Pre-Flight Checks: Script Classes

Different types of scripts require different validation levels. We define **script classes** to determine which checks to run.

### Script Class Definitions

| Class | Description | Critical Checks |
|-------|-------------|-----------------|
| `data_processor` | Scripts that read/write files, process CSV/Excel | venv, pandas, file I/O libraries |
| `api_connector` | Scripts that call external APIs | venv, requests/google-auth, network libs |
| `database_handler` | Scripts that connect to databases | venv, connection libs, credentials |
| `text_processor` | Scripts with only stdlib (no external deps) | venv only |
| `utility` | Helper scripts called by other scripts | venv, caller-specific imports |

## ✅ Quick Checklist

Before committing any script:
- [ ] Filename is all lowercase
- [ ] No spaces in filename (use underscores)
- [ ] No numeric prefixes (00_, 01_, etc.)
- [ ] Header block with usage instructions
- [ ] Terminal diagnostics with [step/total] format
- [ ] Completion message with elapsed time

---

### 2. Function Return Value Usage

**Issue Pattern:** Function returns a value but the code doesn't use it or uses a different value.

**Check:**
- [ ] All function returns are either used or intentionally ignored
- [ ] Return values match the variable types expected by callers
- [ ] No mixing of return values with global/class variables

**Example check:**
```python
# Function returns something
result = process_data(df)

# Does the code use 'result' or does it still use 'df'?
# Should be using 'result' from here on
```

---

### 3. Index/Offset Errors

**Issue Pattern:** Off-by-one errors in loops, array access, or range calculations.

**Check:**
- [ ] Loop ranges match expected iteration count
- [ ] Array indices account for 0-based vs 1-based indexing
- [ ] String slicing uses correct start/end positions
- [ ] Row/column numbers in diagnostics match actual data structure

**Example from Session:**
```python
# Excel rows are 1-indexed, pandas is 0-indexed
header_row = 28  # Excel row number
df = pd.read_excel(file, header=header_row - 1)  # Adjust for 0-based ← Important!
```

---

### 4. Conditional Logic Inversions

**Issue Pattern:** Logic checks the opposite of what's intended (if/else swapped).

**Check:**
- [ ] "if empty then remove" (not "if not empty then remove")
- [ ] "if similar then reuse" (not "if different then reuse")
- [ ] Threshold comparisons use correct operator (≥ vs ≤)

**Example:**
```python
# Correct
if empty_pct >= 95.0:  # If 95% or more empty
    columns_to_drop.append(col)

# Wrong (inverted)
if empty_pct < 95.0:  # Would drop columns that AREN'T empty!
    columns_to_drop.append(col)
```

---

### 5. String Matching Patterns

**Issue Pattern:** Regex or string matching doesn't cover all expected patterns.

**Check:**
- [ ] Pattern handles both underscore and non-underscore variants
- [ ] Case sensitivity is correct (should lowercase match uppercase?)
- [ ] Special characters are properly escaped in regex
- [ ] Pattern matches edge cases (empty strings, single characters)

**Example from Session:**
```python
# Original - only matched: column_1, column_2
if '_' in cleaned_col:
    parts = cleaned_col.rsplit('_', 1)
    if len(parts) == 2 and parts[1].isdigit():
        base_name = parts[0]

# Fixed - matches: column_1, column1, column_2, column2
match = re.match(r'^(.+?)(_?\d+)$', cleaned_col)
```

---

### 6. Deprecated API Usage

**Issue Pattern:** Using older pandas/library methods that trigger warnings.

**Check:**
- [ ] `applymap()` → Use `map()` (pandas 2.1+)
- [ ] `append()` → Use `concat()` (pandas 2.0+)
- [ ] Check library documentation for current API
- [ ] Review warnings during first run

**Example from Session:**
```python
# Deprecated
df = df.applymap(lambda x: clean(x))

# Current
df = df.map(lambda x: clean(x))
```

---

### 7. File Extension Assumptions

**Issue Pattern:** Code assumes file format based on extension, but application behavior differs.

**Check:**
- [ ] Verify Excel interprets file correctly (`.csv` vs `.txt` vs `.tsv`)
- [ ] Check if application auto-detects delimiter or uses extension default
- [ ] Test opening exported file in target application

**Example from Session:**
```python
# Problem: Excel treats .csv as comma-delimited even with tabs
output_path = "data_cleaned.csv"  # Excel ignores tabs!

# Solution: Use .txt for tab-delimited files
output_path = "data_cleaned.txt"  # Excel recognizes tabs
```

---

### 8. Data Type Consistency

**Issue Pattern:** Operations mix data types inappropriately (string + int, float vs int).

**Check:**
- [ ] Numeric operations use consistent types
- [ ] String concatenation doesn't mix types without conversion
- [ ] None/null handling is consistent across operations
- [ ] Boolean comparisons use correct types

**Example:**
```python
# Problem
age = "25"
if age > 18:  # TypeError: comparing string to int

# Fix
age = int("25")
if age > 18:  # Works correctly
```

---

### 9. Scope and Visibility

**Issue Pattern:** Variable used before definition or outside its scope.

**Check:**
- [ ] Variables defined before use in all code paths
- [ ] Variables in if/else blocks accessible where needed
- [ ] Function parameters passed correctly
- [ ] Global vs local variable usage is intentional

**Example:**
```python
# Problem
if condition:
    result = process()
print(result)  # Error if condition is False!

# Fix
result = None
if condition:
    result = process()
if result:
    print(result)
```

---

### 10. Edge Case Handling

**Issue Pattern:** Code works for typical cases but fails on edge cases.

**Check:**
- [ ] Empty dataset handling
- [ ] Single row/column handling
- [ ] All-null column handling
- [ ] Duplicate detection with 0 or 1 columns
- [ ] Division by zero protection

**Example from Session:**
```python
# Protected division
empty_pct = (empty_cells / total_cells) * 100 if total_cells > 0 else 0
#                                               ^^^^^^^^^^^^^^^^^^^^^^^^^
#                                               Edge case protection
```

---

## 🔍 Review Process

### Step 1: Scan for Variable References
```python
# Find all places where a variable is used
# Example: Search for "output_path" and verify all references use the same source
```

### Step 2: Trace Data Flow
```
Input → Transform 1 → Transform 2 → Output
        ↓             ↓             ↓
      Check var    Check var    Check var
```

### Step 3: Check Function Signatures
```python
def function(param1: type1, param2: type2) -> return_type:
    # Verify:
    # 1. All params used correctly
    # 2. Return matches declared type
    # 3. All code paths return something
```

### Step 4: Review Conditionals
```python
if condition:    # Does this read naturally?
    action       # Is the action correct for this condition?
else:           # Is the else case handled?
    fallback
```

---

## 📋 Testing Strategy

### 1. Dry Run Review
Before executing, mentally trace through the code with sample data:
```
Given: filename = "data.xlsx", source_type = "sales"
Output should be: "sales_cleaned.txt"
Check: Does the code use source_type or filename.stem?
```

### 2. Diagnostic Validation
Add temporary print statements before execution:
```python
print(f"DEBUG: Using variable '{source_file_type}' for output filename")
print(f"DEBUG: Output path will be: {output_path}")
```

### 3. Small Data Test First
- Test with minimal data (1-2 rows) to verify logic
- Check intermediate outputs (files, logs)
- Verify all expected files are created with correct names

---

## 🚨 Common AI Assistant Pitfalls

### Pitfall 1: Copy-Paste Inconsistency
**What happens:** AI copies code block but forgets to update variable names.

**Example:**
```python
# Section 1
df_original = load_data()

# Section 2 (copied from Section 1)
df_original = process_data()  # Should be df_processed!
```

**How to catch:** Look for duplicate variable names with different purposes.

---

### Pitfall 2: Over-Optimization
**What happens:** AI tries to combine steps and introduces bugs.

**Example:**
```python
# Clear but longer
filtered = remove_empty(df)
deduped = remove_duplicates(filtered)
cleaned = clean_values(deduped)

# "Optimized" but buggy
cleaned = clean_values(remove_duplicates(remove_empty(df)))
# Harder to debug, easy to mess up order
```

**How to catch:** If code feels dense or hard to read, break it apart.

---

### Pitfall 3: Assuming Behavior
**What happens:** AI assumes library/application will behave a certain way.

**Example:**
```python
# AI assumes Excel will detect tabs in .csv files
df.to_csv("output.csv", sep='\t')  # Excel treats as comma-delimited!
```

**How to catch:** Test actual behavior in target application.

---

### Pitfall 4: Incomplete Refactoring
**What happens:** AI changes part of code but misses related sections.

**Example:**
```python
# Changed function signature
def process(data, threshold=95):  # Added threshold parameter
    ...

# But forgot to update this call
result = process(data)  # Still works (uses default) but inconsistent
```

**How to catch:** Search for all function calls when signature changes.

---
## 🔍 Code Review Checklist

Before executing AI-generated code, verify:

### Critical Checks
1. **Variable Consistency**: Same data used consistently (e.g., user input vs derived values)
2. **File Naming**: All outputs use the same naming convention
3. **Index Alignment**: 0-based vs 1-based indexing handled correctly
4. **Pattern Matching**: Regex/conditions cover all expected variants

### Quality Checks
5. **Deprecated APIs**: No warnings for deprecated methods
6. **Edge Cases**: Empty data, nulls, single items handled
7. **Data Types**: Consistent types throughout operations
8. **Logic Flow**: Conditions read naturally and match intent

### Testing Protocol
- Add DEBUG print statements for critical variables
- Test with minimal data first (1-2 rows)
- Verify output filenames match expectations
- Check intermediate files are created correctly