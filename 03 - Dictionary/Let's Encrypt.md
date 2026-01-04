Free security certificate provider

- Like a "verified business license" for your website
- Proves your site is legitimate and secure
- Completely free (normally costs $50-200/year)
- Auto-renews every 90 days

---
#quick-paste-merge-later 
**Simple Explanation: Let's Encrypt + Nginx for HTTPS**

**The Problem:**  
Your Streamlit app runs on `http://34.135.129.152:8501` (not secure). Browsers block clipboard features on HTTP.

**The Solution Components:**

**1. Let's Encrypt** = 

**2. Nginx** = 

**How It Works:**

- 
- 
- 
- 

**What You Need:**

1. **Domain name** (e.g., `bridge.artemisbi.com`) - ~$10-15/year
2. **Point domain to your VM IP** (34.135.129.152) via DNS
3. **Install Nginx** on your VM (free)
4. **Install Let's Encrypt** (Certbot tool - free)
5. **Configure Nginx** to forward traffic to Streamlit

**The Benefit:**  
Users access `https://bridge.artemisbi.com` instead of the IP address, and all browser features (including clipboard) work perfectly.

----

node.js = runtime
.NET = runtime

node.js -- functions (generic, pure logic), methods(grouped within classes)
.NET = more atomic, they have objects (instances)
	-- made up of class | struct
		-- made up of methods


You are absolutely right to feel skeptical. The list you were given describes a **massive enterprise-scale architecture** (think Netflix or Uber). For a personal workspace or a small team, having `utils/`, `helpers/`, `shared/`, and `common/` side-by-side is **redundant and confusing.**

You can absolutely stick to your argument: **"If it's a shared function, it goes in Utils."**

However, there is **one major reason** to split things out of `utils/` eventually: **Dependencies and "Heaviness."**

Here is the breakdown of why you might separate them, followed by the specific examples you asked for.

---

### The "Why": The dependency trap

Imagine you put _everything_ in `utils`.

1. **Lightweight:** `clean_email.py` (Standard Python, no libraries).
2. **Heavy:** `salesforce_uploader.py` (Requires `pip install simple-salesforce`, API keys, and network access).
    

If you keep these in the same folder, and you try to import `clean_email` into a tiny script, you might accidentally trigger errors because the script implies the existence of the Salesforce libraries.

**The Rule of Thumb:**

- **Utils:** Pure inputs and outputs. No network calls. No database connections. Fast.
- **Integrations/Services:** Talks to the outside world (APIs, DBs). Slow. Needs credentials.
    

---

### 1. Examples: Utils vs. Parsers vs. Core vs. Helpers

Here is how code actually looks different in these folders.

#### `libs/utils/` (The "Dumb" Tools)

_Concept: Universal, stateless, pure functions. Input -> Output._

Python

```
# libs/utils/string_tools.py

def to_snake_case(text):
    """Converts 'Client Name' to 'client_name'"""
    return text.lower().replace(" ", "_")

def is_valid_guid(id_string):
    """Returns True if string is a valid UUID"""
    # ... logic here ...
```

#### `libs/parsers/` (The Translators)

_Concept: Complex logic dedicated to reading a specific messy format and making it structured. This is distinct from utils because it usually involves specific business logic about how **your** files are formatted._

Python

```
# libs/parsers/bank_pdf_parser.py

def extract_transactions_from_pdf(pdf_path):
    """
    Specifically looks for the 'Wells Fargo' formatted table 
    in a PDF and returns a list of dictionaries.
    """
    # Logic to find the table coordinates
    # Logic to ignore the footer text
    return transaction_list
```

#### `libs/core/` (The Definitions / The Truth)

_Concept: Things that don't "do" anything but define what things "are." Configs, Constants, and Data Classes._

Python

```
# libs/core/config.py
DATABASE_TIMEOUT = 30
DEFAULT_CURRENCY = "USD"

# libs/core/models.py
from dataclasses import dataclass

@dataclass
class Client:
    id: int
    name: str
    region: str
```

#### `libs/helpers/` (The Redundant One)

Honest advice: Kill this folder.

In 90% of projects, helpers is just a vague name for utils. Don't use both. Pick one. You seem to prefer utils, so stick with that.

---

### 2. Deep Dive: Services vs. Integrations

You mentioned not understanding these. This is the most valuable distinction to learn for DevOps and Scripting.

#### `libs/integrations/` (The "Pipe")

This is the raw code that knows how to talk to a 3rd party tool (Slack, Azure, SQL Server). It doesn't know _why_ it's sending data, only _how_.

- **Example:** `libs/integrations/slack_client.py`
- **Code:** A class that has a method `send_message(channel, text)`. It handles the API Token and the HTTP Request.
    

#### `libs/services/` (The "Brain")

This is the business logic that uses the integration to do a job.

- **Example:** `libs/services/alerting.py`
- **Code:** A function `notify_team_of_failure(error_msg)`.
- **Logic:**
    
    1. Import `libs/core/config` to see which Slack channel to use.
    2. Format the `error_msg` using `libs/utils`.
    3. Call `libs/integrations/slack_client` to actually send it.
        

Why separate them?

If you switch from Slack to Microsoft Teams later, you only change the Integration. The Service (the business logic of alerting the team) stays the same.

---

### 3. A Recommended Structure for You

Based on your preferences (keeping data local to projects, disliking redundancy), here is a cleaner "Happy Medium" for `artemis-hub`.

It separates the "Pure/Fast" code from the "External/Slow" code, without over-engineering.

Plaintext

```
/artemis-hub
│
├── /libs                 <-- Shared code only
│   │
│   ├── /utils            <-- "Pure" functions (strings, dates, math).
│   │   ├── __init__.py
│   │   ├── cleaner.py    <-- Your contact/email cleaners go here
│   │   └── files.py      <-- Generic file helpers (get_extension, etc)
│   │
│   ├── /connectors       <-- (Or "integrations"). External stuff.
│   │   ├── sql_db.py     <-- Your shared SQL connection logic
│   │   └── azure_blob.py <-- Shared code to upload files
│   │
│   └── /core             <-- Constants/Configs shared across apps
│       ├── constants.py  <-- e.g. DATE_FORMAT = "YYYY-MM-DD"
│       └── exceptions.py <-- Custom error types
│
├── /projects_or_apps
│   ├── /client-bridge
│   │   ├── /data         <-- Keep data here (as you requested)
│   │   ├── app.py
│   │   └── Dockerfile
```

**Why this works for you:**

1. **Utils** stays your junk drawer for handy tools.
2. **Connectors** handles the "heavy" SQL/Cloud stuff so it doesn't pollute your light scripts.
3. **Core** is there if you need shared variables.
4. **No `helpers`, `parsers`, or `services` folders** unless you specifically find a need for them later.