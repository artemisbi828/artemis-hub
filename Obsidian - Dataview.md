```

```dataview
list
from #quick-paste-merge-later 
```


# Show backlinks referencing this note
```dataview
LIST
FROM [[#]]
WHERE file.name != this.file.name

```


# Show all files in the same folder
```markdown

```dataview
TABLE file.mtime as "Last Modified"         # can change this ln → LIST and it will just show filenames
FROM ""
WHERE file.folder = this.file.folder
SORT file.name

#same folder with a tag
LIST
FROM #project
WHERE file.folder = this.file.folder

FROM ""
WHERE startswith(file.folder, this.file.folder)

```

# Missing YAML tag w specific tag
2026-01-15 09:27 AM
Search bar: ["concept_type"]

```
```dataview

TABLE file.link, concept_type
WHERE contains(file.tags, "source/heartbeat-infobox")
AND (
  !concept_type
  OR concept_type = null
  OR concept_type = ""
)
SORT file.name ASC

```


# Show all files where YAML tag is null
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

# show all files in the same folder

```dataview
TABLE rows.file.link AS "Notes"
WHERE domain
GROUP BY domain
```

```
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

