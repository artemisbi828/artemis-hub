> **Stop narrating how the data came to be.  
> Start defining what this thing _is_, why it exists, and how it should be used.**

Your originals weren’t _wrong_ — they were **human explanations**.  
I reformulated them into **system definitions**.

### 🔍 **Troubleshooting Preview**

If you see: `ModuleNotFoundError: No module named 'docling'`  
→ Ensure venv activated: [Activate.ps1](vscode-file://vscode-app/c:/Users/jonas-adam.pascua/AppData/Local/Programs/Microsoft%20VS%20Code/ce099c1ed2/resources/app/out/vs/code/electron-browser/workbench/workbench.html)

If you see: `ImportError: DLL load failed` (Windows)  
→ Install [Visual C++ Redistributable]

# Explaining A Tool

## **Why Docling Failed**

**Root Cause:** Windows symlink permissions error (`OSError: [WinError 1314]`)

**Details:**

- Docling uses HuggingFace Hub to download ML models (~200 MB)
- HuggingFace cache defaults to creating **symlinks** for efficient storage
- Windows requires **Administrator privileges** to create symlinks
- Your user account lacks these rights → installation/execution failed

**Why We Switched to PyMuPDF:**

- ✅ No symlinks/admin rights needed
- ✅ Lighter weight (~70 MB vs ~200 MB)
- ✅ No ML model downloads
- ❌ Less intelligent structure detection (but we're now parsing raw text)

---

- **The Problem it Solves:** traditionally, web pages only update when you refresh them (HTTP requests). If you want a live chat, you don't want to hit "refresh" every second to see new messages.
    
- **The Solution:** SignalR creates a persistent connection between the client (browser) and the server. This allows the server to **push** content to clients instantly as it happens.
    
- **How it works:** It uses "WebSockets" under the hood (the gold standard for real-time), but if WebSockets aren't available (e.g., on an old browser), it automatically falls back to older techniques like "Long Polling" so the app still works.

---
# Debugging
```
Symptom: You installed Streamlit (pip install streamlit), but typing streamlit run resulted in command not found.

Cause: pip installed the executable into a hidden folder (~/.local/bin) that wasn't in your system's "address book" (the $PATH variable). Linux didn't know where to look.

The Fix (Workaround): We used python3 -m streamlit. This tells Python to find the module itself, bypassing the system PATH lookup.
```

```
Symptom: You had the server running, but couldn't connect via the browser (http://IP:8501).

Cause: Public Wi-Fi (like at ATL airport) creates a "Firewall Sandwich":

1. **Google Firewall:** We opened this correctly using `gcloud compute firewall-rules`.
2. Airport Firewall: This was likely blocking outgoing traffic on "weird" ports like 8501. It usually only permits Port 80 (Web) and 443 (SSL).

    Solution: Wait for a non-restricted network (Home/Cellular) or use a standard port (requires sudo privileges).
```

```
Symptom: Constraint constraints/compute.vmExternalIpAccess violated.

Cause: Google Cloud protects new projects by forbidding Public IPs to prevent accidental exposure.

Fix: We created a policy.yaml file to explicitly override this rule and applied it via gcloud resource-manager.
```

# Tickets
Extracted from freshbooks
```
**Root Cause:**
The referral detail report for R27 does not populate any data due to the absence of pre-conversion data in the dashboard and the specific dashboard start dates for the offices.

**Actions Taken:**
The agent advised to remove any filters and explained the limitations on Cloud9, including the logic based on the most recent referral edit on record. The agent also clarified that no pre-conversion data is included in the dashboard and provided examples of dashboard start dates to illustrate the issue.

**Resolution:**
The requester acknowledged the explanation and mentioned that the issue might be related to the PAN form in Dayforce for the new region. The ticket was closed with the option to reopen if needed.
```