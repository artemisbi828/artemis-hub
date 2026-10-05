```table-of-contents
```
# Obsidian or Text Cleanup Tool  
- titles
	- consistent casing for prefix patterns `git --> GIT` 
	- trim all titles
- tighten text
	- `for UX in dropdown` --> `for dropdown UX`


# AI Prompts
### ASCII Trees Distallation
I like this format where they break out a high level ascii tree and then a detailed breakout. Easier to consume cognitively.

```
SD-EDW
├── DuckDB
├── SQL
├── Documentation
├── AI Context
└── Reference Material


sd-edw/
├── data/
│   └── sd_edw.duckdb
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── docs/
│   ├── glossary/
│   ├── metrics/
│   └── governance/
│
├── ai-context/
│   ├── business-rules.md
│   ├── semantic-model.md
│   └── project-overview.md
│
└── .vscode/
```