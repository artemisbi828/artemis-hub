Google; Apple; GitHub; Microsoft

![[Pasted image 20260111150950.png]]

> [!abstract] TLDR
> 
> API access tokens act as stateless "delegated keys" that bypass repeated DB lookups by encoding scope and identity directly into a cryptographically signed payload. They decouple authentication (Identity Provider) from permission granting (Authorization Server) to enable secure, time-bound resource access.

---

## 🏗️ Architectural Topology

In modern OAuth2/OIDC stacks, the "Source of Truth" is split to handle scale and security. This prevents the Resource Server (API) from becoming a bottleneck.

Code snippet

```
graph TD
    User((User/Client)) -->|1. Auth Request| IdP[Identity Provider]
    IdP -->|2. Validate Identity| AS[Authorization Server]
    AS -->|3. Issue JWT Token| User
    User -->|4. Bearer Token| RS[Resource Server / API]
    RS -->|5. Local Validation| RS
    RS -->|6. Return Data| User

    subgraph "Trust Boundary"
    IdP
    AS
    end
```

### 🧩 Component Breakdown

- **Identity Provider (IdP):** The "User Directory" (e.g., LDAP, Active Directory).
    
    - _Analogy:_ The DMV checking your birth certificate to prove you are _you_.
        
- **Authorization Server (AS):** The "Policy Engine" that issues the token based on IdP success.
    
    - _Analogy:_ The DMV issuing a specific license class (Scope) that expires in 5 years (Lifetime).
        
- **The "Google" Exception:** Large providers often collapse these into a single logical entity, but they remain distinct functional layers within the same infrastructure.
    

---

## 🎫 Bearer Tokens: Access Logic

The term **Bearer** implies that possession equals permission. If you "bear" the token, you have the rights associated with it—no further proof of "who" you are is required by the API.

> [!info] Decoupled Validation
> 
> Unlike session cookies which require a SELECT * FROM sessions query, access tokens (typically JWTs) allow the API to validate access using only a Public Key.
> 
> → Logic: is_valid = decrypt(token.signature, public_key) && token.expiry > now()

### ⚖️ Token Attributes

|**Attribute**|**Technical Equivalent**|**Purpose**|
|---|---|---|
|**Scope**|`permissions` / `grants`|Defines "What" can be done (e.g., `read:users`, `write:orders`).|
|**Lifetime**|`exp` (Expiry Claim)|Limits the window of vulnerability if a token is leaked.|
|**Resource**|`aud` (Audience)|Ensures a token for "API A" cannot be used to attack "API B".|

---

## ⚙️ Engineering Trade-offs

> [!tip] Optimization: Statelessness
> 
> Use tokens to eliminate the "Double Hop." Instead of API → Database → Identity Server, the flow becomes API → CPU (Signature Check). This significantly reduces latency in microservice meshes.

> [!code] Python Logic: Scope Enforcement
> 
> Python
> 
> ```
> # Decoding without DB hit
> payload = jwt.decode(token, PUBLIC_KEY, algorithms=["RS256"])
> ```

> # SQL analogy: WHERE scope LIKE '%read:data%'
> 
> if "read:data" not in payload.get("scope", ""):
> 
> raise PermissionDenied("Insufficient scope")

---

> [!example] Bearer Token Vulnerability
> 
> Think of a Bearer token like a physical hotel key card.
> 
> 1. The front desk (AS) verifies your ID (IdP).
>     
> 2. They give you a card (Token) with access to Room 402 (Scope) for 2 days (Lifetime).
>     
> 3. The door lock (API) doesn't call the front desk; it just checks if the card is valid and unexpired.
>     
> 4. **Risk:** If you drop the card, anyone who picks it up (the Bearer) can enter Room 402.
>     

**Would you like me to map out a specific "Refresh Token" rotation strategy or a detailed JWT payload structure?**