Anonymization approach (what changed)

*   **patient\_id** → stable pseudonym (`PAT-001`, `PAT-002`, …) so duplicates still group correctly
*   **first\_name / last\_name** → fake names (consistent per patient)
*   **date\_of\_birth** → **year-only** (`YYYY-**-**`)
*   **dates** (status\_start\_date, estimated\_completion\_date, new\_patient\_exam\_date, ciLastModified) → **day redacted** (`YYYY-MM-**`)
*   **Street / City / Zip** → generalized (state retained; zip reduced to prefix)
*   **Phone / Email** → masked (still preserves type and rough format)
*   **GUIDs** → stable tokens (`GUID-A01`, `PATGUID-01`, etc.) to preserve joinability without exposing real GUIDs