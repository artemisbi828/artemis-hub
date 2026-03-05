---
related_to: "[[Tools - Terminal Linux]]"
---
#status/deferred/quick-paste-merge-later 

An **OIDC token** is a security token used in the **OpenID Connect (OIDC)** protocol, which is an identity layer built on top of the OAuth 2.0 framework.1

In simple terms, an OIDC token serves as proof of a user's (or service account's) **identity and authentication**.2

Here is a breakdown of what the OIDC token does, especially in the context of Google Cloud and your Cloud Scheduler setup:

---

## 🔑 Key Features of an OIDC Token

1. **Identity Verification (The "What"):**
    
    - The main purpose of OIDC is to allow clients (like your Cloud Scheduler job) to **verify the identity of the end-user**.3
    - The token asserts "I am the Google Compute Engine service account for the project `client-portal-bridge`."
        
2. **Built on JSON Web Token (JWT) Standard:**
    
    - The OIDC token itself is typically a **JSON Web Token (JWT)**.4 A JWT is a digitally signed, URL-safe string containing claims (information) about the user.5
        
3. **Authentication to a Service:**
    
    - In your Cloud Scheduler setup, the OIDC token acts as a credential.6 When the job sends the **POST** request to the Compute Engine API endpoint (`.../antigravity-box/start`), the token is included in the **Authorization Header**.
    - The Compute Engine API server then reads the token to confirm:
        - **Validity:** Is the token authentic and unexpired?
        - **Permission:** Does the entity represented by the token (the service account) have permission to perform the requested action (start/stop a VM) in that specific project?
            

---

## OIDC in Your Cloud Scheduler Setup

When you selected "Add OIDC token" in Cloud Scheduler, you correctly configured the following:

- **Service Account:** You told Cloud Scheduler _who_ the caller is (the Compute Engine default service account).
- **Audience:** You told Cloud Scheduler _where_ the token is going (the specific API URL).7
    

The Cloud Scheduler then **automatically generates a unique OIDC token** for that specific job execution and adds it to the HTTP request, allowing the Google Compute Engine API to trust and authorize the automated action.

The token is crucial because without it, the API would reject the HTTP request, classifying it as an unauthorized attempt to manage your VM.8