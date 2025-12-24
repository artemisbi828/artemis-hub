# Front-End

- Flask -- Python WebApp
- Clipboard API (Uppy) -- Drag-Drop w Ctrl+V; used in intake-form

# Back-End
- FastAPI with SQLite -- A lightweight Python API framework paired with a simple file‑based SQL database. Great for rapid development, local dev, and low‑ops internal tools.

- SqlAlchemy -- Python's ORM and SQL toolkit -->  lets you define database models as Python classes and query databases without writing raw SQL.
	- Alembic -- schema-migration engine for SQL Alchemy; generates and runs db migration scripts so your db schema stays version-controlled
- IIS reverse proxy -- IIS + URL Rewrite + ARR acts as a front‑door that forwards public HTTP requests to internal apps (e.g., FastAPI), adding security, routing, and SSL termination.

Microsoft
M365 Identity
Identity layer of Microsoft 365: user accounts, authentication, MFA, Conditional Access, and governance via Microsoft Entra ID. Manages how users sign in and access services.

Entra ID (OIDC) via MSAL
Microsoft Entra ID provides OpenID Connect authentication. MSAL handles sign‑in, tokens, refresh, SSO, and calling Microsoft APIs securely from your app.

Azure Blob Storage with SAS
Cloud object storage that issues short‑lived, permission‑scoped URLs (SAS tokens) so clients can upload/download files securely without exposing credentials.

Defender for Storage – Malware Scanning
Cloud‑native malware scanning for Azure Storage. Scans blobs on upload or on-demand using Defender AV to block malicious files.

Microsoft Graph (People Picker)
A UI control (mgt-people-picker) that searches users or groups via Microsoft Graph’s /users, /people, etc. Enables selecting organization members inside forms or apps.

Azure DevOps REST API
HTTP endpoints to automate everything in Azure DevOps — work items, pipelines, repos, artifacts, builds. Lets you script DevOps tasks and integrate DevOps from code or apps.
