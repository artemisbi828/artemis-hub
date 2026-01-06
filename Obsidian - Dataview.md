

# where concept_type is not null
```markdown

LIST
WHERE concept_type

# explicit but redundant
TABLE concept_type, concept_category
WHERE concept_type != null

TABLE file.name, entity_type, domain
WHERE concept_type
SORT concept_type ASC
```


```markdown

```dataview
TABLE rows.file.link AS "Notes"
WHERE domain
GROUP BY domain

```dataview
LIST
FROM #domain/clinical
WHERE contains(file.folder, "Concepts")

```

## Pro Tips

- **Property names are case-sensitive**: `domain` ≠ `Domain`
- **String values need quotes**: `domain = "clinical"` not `domain = clinical`
- **Tags need # prefix**: `#domain/clinical`
- **Combine FROM + WHERE**: `FROM "folder" WHERE property = "value"`



```markdown
dataview
TABLE file.name, rows.contain
WHERE contains(file.name, "📅")
SORT file.name DESC

TABLE file.name AS "Note", length(filter(file.lists.text, (t) => contains(t, "Completed:"))) AS "Count" WHERE contains(file.name, "📅") SORT file.name DESC
```
