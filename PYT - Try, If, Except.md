try this, if
- yes → print
- no → error handle

```python
try:
	if spark.catalog.tableExists(AUDIT_TABLE):
		print(f"Table {AUDIT_TABLE} already exists.")
	except Exception as e:
		print("Error checking table existence:", e)
```