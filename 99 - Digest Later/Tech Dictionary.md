| M365 Identity                           | Identity layer of Microsoft 365: user accounts, authentication, MFA, Conditional Access, and governance via Microsoft Entra ID. Manages how users sign in and access services. |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Azure DevOps REST API                   | HTTP endpoints to automate everything in Azure DevOps — work items, pipelines, repos, artifacts, builds. Lets you script DevOps tasks and integrate DevOps from code or apps.  |
| Nginx                                   | Traffic director (reverse proxy) Sits in front of your Streamlit app Handles the HTTPS encryption/decryption Your Streamlit app stays the same (still runs on port 8501)       |
| Microsoft Graph (People Picker)         | A UI control (mgt-people-picker) that searches users or groups via Microsoft Graph’s /users, /people, etc. Enables selecting organization members inside forms or apps.        |
| Google Apps Script                      | Google Workspace Add-on uses Google Apps Script (GAS). Google environment (Gmail, Calendar, Contacts, etc.) and is the supported way to create a simple CRM logger.            |
| IIS reverse proxy                       | IIS + URL Rewrite + ARR acts as a front‑door that forwards public HTTP requests to internal apps (e.g., FastAPI), adding security, routing, and SSL termination.               |
| Azure Blob Storage with SAS             | Cloud object storage that issues short‑lived, permission‑scoped URLs (SAS tokens) so clients can upload/download files securely without exposing credentials.                  |
| Entra ID (OIDC) via MSAL                | Microsoft Entra ID provides OpenID Connect authentication. MSAL handles sign‑in, tokens, refresh, SSO, and calling Microsoft APIs securely from your app.                      |
| FastAPI with SQLite                     | A lightweight Python API framework paired with a simple file‑based SQL database. Great for rapid development, local dev, and low‑ops internal tools.                           |
| SqlAlchemy                              | Python's ORM and SQL toolkit -->  lets you define database models as Python classes and query databases without writing raw SQL.                                               |
| Defender for Storage – Malware Scanning | Cloud‑native malware scanning for Azure Storage. Scans blobs on upload or on-demand using Defender AV to block malicious files.                                                |
| Call-Work-Queue                         | crm web app for teams to look at call-list and reduce consult-miss-rate kpi = sms notifications end score. completion velocity.                                                |
| Package Manager                         | Node.js = NPM, Python = PIP                                                                                                                                                    |
| Clipboard API (Uppy)                    | Drag-Drop w Ctrl+V; used in intake-form                                                                                                                                        |
| Speed Test                              | Good -- 10 MB to 13.3 MB Bad -- 2.5 MB                                                                                                                                         |
| Flask                                   | Python WebApp                                                                                                                                                                  |

---

## 1. The "No-Tool" Developer (Raw SQL)

Before using these libraries, a developer writes "Raw SQL" strings directly in their Python code.

- **The Story:** You are at the restaurant, but there is no menu and no waiter. To get food, you must write a precise, handwritten letter to the chef in their native language (SQL) and hand-deliver it to the kitchen window.
    
- **The Struggle:** If you make a single typo in your letter ("SLECT" instead of "SELECT"), the chef throws it away. If you decide you want 50 different dishes, you have to write 50 different letters. If the kitchen moves a stove (a database table name changes), you have to hunt down every single letter you ever wrote and update it manually.
    
- **Why it’s hard:** It is error-prone, tedious to maintain, and offers no "safety net" from Python.
    

---

## 2. SQLAlchemy Core: The "Precision Architect"

**SQLAlchemy Core** is for the developer who wants to speak "Database" but wants Python to help them stay organized.

![SQL database schema diagram, AI generated](https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcSS0E0P9xxb7IqhHBco1rjWsueuKRhSwIV4Xx-Lx-6TGbqfOqLW1M5hwipkRvEJlmUMj8wFf9eUlYIA4QBfZnVZx9HSjkaTDn958VnrWSRbF1ySj5E)

Shutterstock

Explore

- **The Story (With Core):** You are now a professional architect. Instead of writing letters to the chef, you use a set of **pre-fabricated blueprints** (Python objects that represent tables). To order food, you snap these blocks together.
    
    - _Without Core:_ You manually type `SELECT name FROM users WHERE id = 5`.
        
    - _With Core:_ You write `select(users_table).where(users_table.c.id == 5)`.
        
- **Why it’s better:** Python checks your "blocks" before they reach the database. If `users_table` doesn't have an `id` column, Python yells at you immediately before you even talk to the database.
    
- **The Developer Profile:** This developer loves efficiency and wants to see exactly how the "plumbing" of the query is built. They want to squeeze every drop of performance out of the system.
    

---

## 3. SQLAlchemy ORM: The "Business Manager"

**SQLAlchemy ORM (Object-Relational Mapping)** is for the developer who doesn't want to think about "tables" at all—they only want to think about "Concepts" (Users, Orders, Products).

- **The Story (With ORM):** You are a high-level manager. You don't care about "tables" or "rows." You have a **Smart Assistant** (the ORM).
    
    - You tell the assistant: _"Find me the User named 'Alice' and change her email."_ * In the background, the assistant finds the right table, finds the right row, generates the SQL `UPDATE`, and handles the "paperwork" (Transaction) for you.
        
- **How the Developer works:** You treat your data like a standard Python object. To change an email, you just type `alice.email = 'new@email.com'` and then `session.commit()`. You never even see the SQL.
    
- **Why it’s better:** It is incredibly fast for building features. You can focus entirely on the "logic" of your app (e.g., "If a user is a VIP, give them a discount") without worrying about how that data is stored in a grid.
    
- **The Risk:** If you ask the assistant for 1,000 users' emails, the assistant might go back and forth to the kitchen 1,000 times (the "N+1 problem") instead of bringing one big tray.
    

---

## Summary Comparison

|**Tool**|**The "Vibe"**|**The Mental Image**|**Best For**|
|---|---|---|---|
|**Raw SQL**|Manual Labor|Hand-writing letters to a chef.|Very simple scripts or extreme edge cases.|
|**Core**|Structural|Building a query with high-quality Lego blocks.|Data pipelines, complex reports, and speed.|
|**ORM**|Automated|Treating the database like a collection of Python objects.|Websites, Apps, and fast feature building.|

---

To help you visualize how these two approaches actually "feel" in your code, let's look at a common scenario: **Updating a patient's status and logging the change.**

### 1. The SQLAlchemy Core Way (The Blueprint Approach)

In Core, you think in terms of **actions** performed on **tables**. You are explicitly telling the database to "Go to this table and change this specific value."

Python

```
# CORE: Explicit and Table-Focused
from sqlalchemy import update, insert

# 1. Update the patient record
stmt = (
    update(patients_table)
    .where(patients_table.c.id == 5)
    .values(status='Active')
)
connection.execute(stmt)

# 2. Manually create a log entry in another table
log_stmt = insert(audit_logs_table).values(
    patient_id=5, 
    action='Status Update'
)
connection.execute(log_stmt)
```

**Why a developer uses this:**

- **Performance:** You send exactly two commands to the database. No more, no less.
    
- **Clarity:** If you look at this code six months from now, you know exactly which tables were touched.
    
- **Control:** Ideal for the "Data Pipeline" parts of your project where you are moving thousands of rows at once.
    

---

### 2. The SQLAlchemy ORM Way (The "Smart Assistant" Approach)

In ORM, you think in terms of **objects**. You don't "update a table"; you "talk to a Patient" and let the Assistant (SQLAlchemy) handle the chores.

Python

```
# ORM: Conceptual and Object-Focused
# 1. Ask the assistant to find the patient
patient = session.query(Patient).get(5)

# 2. Just change the property like a normal Python variable
patient.status = 'Active'

# 3. If you have a relationship set up, the log can be added automatically
patient.logs.append(AuditLog(action='Status Update'))

# 4. Tell the assistant to "Save all my changes"
session.commit()
```

**Why a developer uses this:**

- **Speed of Thought:** You don't have to remember table names or join logic; you just follow the "dots" (e.g., `patient.logs`).
    
- **Safety:** The ORM handles the "Unit of Work." If the status update succeeds but the log fails, the ORM can roll back both so your data doesn't get "half-updated."
    
- **Readability:** The code looks like plain English, making it easier for a team to maintain.
    

---

### Comparison for your Metrics Project

Based on the **Metric List Draft** you provided:

|**Scenario**|**Recommended Tool**|**Why?**|
|---|---|---|
|**Calculating "Net Collection Rate" (ID 25)**|**Core**|This involves math across many rows (`Total collections / Net production`). Core is faster for these heavy calculations.|
|**Editing a Metric Definition (e.g., ID 3)**|**ORM**|You are just changing one "Metric" object's text. ORM is much cleaner for this "User Interface" style work.|
|**Generating the 152-row TSV**|**Core**|You want a flat, predictable structure for your output file. Core maps directly to the rows you need.|

---

**Would you like me to confirm the "Tech Stack" for your extraction script now (Docling + PyMuPDF), or should we refine the logic for those last two tricky rows (IDs 151 and 152) first?**