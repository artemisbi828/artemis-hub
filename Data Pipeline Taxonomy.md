# Data Credential Connection Type
- authentication: keypair, okta sso, microsoft entra id, basic
- username, encrypted private key, 
- private key password
- role, warehouse

# Source Delivery Frequency Type
Frequency can describe 
- data source pull frequency
- data product delivery (push)
- dataset refresh cadence (pull from gold)

**Standards**
Hourly 
Daily (Nightly)
Weekly
Monthly

**Variable**
Near‑real‑time
On-Demand (eg, Paginated Reports Refresh)

# Data Quality Validation Requirements
☐ Row count / volume validation
☐ Primary key uniqueness
☐ Nullability constraints
☐ Referential integrity
☐ Freshness / timeliness

# Late Data Handling
Different ways to handle data that comes late after cutoff

☐ Accepted and backfilled
☐ Rejected
☐ Requires manual approval

# Data Security Typo
Data Classification: ☐ Public ☐ Internal ☐ Confidential ☐ Restricted
PII / PHI Present: ☐ Yes ☐ No
Masking / Tokenization Required: ☐ Yes ☐ No
