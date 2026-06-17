#learning 

2026-04-14 01:50 PM -- results 

Optimizing tool selection...I’m reviewing the style JSON and the input/output SQL pair first to validate whether there’s enough information to build a Sublime Text Python formatter command, then I’ll map feasibility for SQL dialect normalization with sqlglot and list the design choices that need your input.

Ran terminal command: Set-Location "c:\vsWorkspace_SD\3 - sublime_py_accelerators\sql_redgate_stylesheet"; Compare-Object (Get-Content case1-input.txt) (Get-Content case1-output.txt)

Read [](file:///c%3A/vsWorkspace_SD/3%20-%20sublime_py_accelerators/sql_redgate_stylesheet)

Quick finding: your sample input and expected output are currently identical, so they don’t yet reveal which concrete transformations should happen. Next I’ll evaluate which settings in the JSON can be implemented directly versus approximated, and what third-party parser support looks like for T-SQL vs Snowflake.Yes, enough to build a working Sublime Python formatter command, with one major caveat: full Redgate parity is not realistic in a first version.

Primary findings:
1. Your baseline style spec is clear and machine-readable in redgate.json.
2. Your sample transformation pair does not currently demonstrate any changes: case1-input.txt and case1-output.txt are line-identical.
3. The SQL sample mixes dialect features (for example Snowflake-like and T-SQL-like constructs in one query), which affects parser choice and dialect enforcement behavior.

Feasibility summary:
1. Sublime command integration: High feasibility.
2. JSON-driven style application: Medium-high feasibility for many rules, medium for advanced alignment/collapse behavior.
3. sqlglot dialect normalization (mssql <-> snowflake): Medium feasibility, with potential lossy rewrites and parser edge cases on mixed-dialect input.
4. Exact Redgate-format clone: Low-medium feasibility without a significant custom formatter engine.

What can be implemented reliably in v1:
1. Command callable from Context.sublime-menu and Default.sublime-commands.
2. Keyword/function/data-type casing rules.
3. Line wrapping target, list placement, simple join/on indentation.
4. CASE and parenthesis formatting heuristics.
5. Idempotent formatting pipeline with fail-fast parse handling.
6. Optional dialect pass using sqlglot before style formatting.

Where ambiguity/risk exists right now:
1. No observable expected diff from your sample pair, so behavior priorities are unclear.
2. Mixed dialect SQL in a single statement: should this be preserved, normalized, or rejected?
3. Redgate options like collapse thresholds and alignment can conflict in edge cases; tie-break precedence is not specified.
4. Some options in redgate.json are abstract without concrete examples (for example multiline comment alignment patterns).

Pre-cursor requirements:
1. Confirm Sublime Text version target (ST4 assumed) and plugin location strategy.
2. Python dependency policy inside Sublime plugin:
   3. Pure Python only
   4. Vendored dependencies
   5. External environment bridge
6. Golden test corpus:
   7. At least 10-20 input/output SQL snapshots
   8. Include long CASE, joins, CTEs, DDL, variables, comments
9. Dialect policy:
   10. Strict mssql
   11. Strict snowflake
   12. Auto-detect
   13. Mixed allowed with warnings
14. Failure policy:
   15. Parse failure returns unchanged SQL + error panel
   16. Fallback regex/token formatter
   17. Hard fail

Recommended architecture:
1. Stage 1 parser/normalizer:
   2. sqlglot parse/transpile when dialect is set
   3. Preserve unknown functions where possible
4. Stage 2 style formatter:
   5. Token-based custom rules mapped from redgate.json
6. Stage 3 verification:
   7. Snapshot tests against expected outputs
   8. Idempotence check (format twice, no second diff)

Design decisions I need from you before I generate the script:
1. Dialect mode default:
   2. mssql
   3. snowflake
   4. auto
5. On mixed-dialect query:
   6. normalize to chosen dialect
   7. keep as-is, style only
   8. reject with warning
9. Dependency approach:
   10. sqlglot included
   11. no external deps (custom tokenizer/formatter only)
   12. hybrid (sqlglot optional)
13. First milestone scope:
   14. style-only formatter
   15. dialect+style formatter
16. Keyword case in final output:
   17. keep lowercase from redgate.json
   18. uppercase for T-SQL convention
19. Max line length:
   20. keep 240
   21. change to ____ (your value)

If you choose the 6 decisions above, I can generate:
1. A Sublime plugin Python file.
2. Matching Context.sublime-menu command entry.
3. Matching Default.sublime-commands entry.
4. A minimal test harness using your sample files plus additional edge cases.