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