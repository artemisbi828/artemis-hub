
1. Daily Pipelines should never break. Things that are decided to be distinct should have dedup-filter + prioritization rules. 
```
INR where RN = 1
```
	
	Validation queries are there to ensure integrity. Warnings are prioritized (P1,P2,P3)
	
2. Sanitization on Silver Layer -- String values should be normalized on ingest: Trim() = Leading and trailing spaces should be removed 

3. Config tables should be `business-facing` and `business-governed`. Should have start and end dates of what dates they should affect.
