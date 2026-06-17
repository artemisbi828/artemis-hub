### HTTP Status Codes — TLDR Cheat Sheet

**Mental model**

```
1xx = Info     (request received)
2xx = Success  (request worked)
3xx = Redirect (go somewhere else)
4xx = Client   (you did something wrong)
5xx = Server   (server did something wrong)
```

---

## ✅ 2xx — Success

- **200 OK** — Standard success
- **201 Created** — New resource created (POST/PUT)
- **202 Accepted** — Accepted, still processing
- **204 No Content** — Success, nothing returned

---

## 🔀 3xx — Redirects

- **301 Moved Permanently** — Permanent redirect (update URLs)
- **302 Found** — Temporary redirect
- **304 Not Modified** — Use cached version

---

## ⚠️ 4xx — Client Errors (your issue)

- **400 Bad Request** — Malformed request (syntax, validation)
- **401 Unauthorized** — Not authenticated (missing/invalid login)
- **403 Forbidden** — Authenticated but **no permission**
- **404 Not Found** — Resource doesn’t exist
- **405 Method Not Allowed** — Wrong HTTP method (GET vs POST)
- **408 Request Timeout** — Client took too long
- **409 Conflict** — State conflict (e.g., duplicate)
- **413 Payload Too Large** — Request size too big
- **415 Unsupported Media Type** — Wrong content type
- **429 Too Many Requests** — Rate limited

👉 **Key distinction**

```
401 = Who are you?
403 = I know who you are, you’re not allowed
```

---

## 💥 5xx — Server Errors (their issue)

- **500 Internal Server Error** — Generic failure
- **501 Not Implemented** — Feature not supported
- **502 Bad Gateway** — Upstream service failed
- **503 Service Unavailable** — Server down/overloaded
- **504 Gateway Timeout** — Upstream took too long

---

## 🧠 Practical Debug Heuristics

```
If 4xx → check request (auth, payload, endpoint)
If 5xx → check server logs / dependencies
If 403 → RBAC / permissions / firewall
If 404 → URL or routing mismatch
If 429 → backoff / retry with delay
If 502/504 → downstream service issue
```

---

## 📌 Common Patterns in BI / APIs / Data Pipelines (your context)

- **403** → RBAC / workspace / dataset permission mismatch
- **401** → expired token / service principal issue
- **404** → wrong endpoint, dataset ID, or route
- **409** → duplicate writes / idempotency issues
- **429** → API throttling (Power BI, Fabric, Azure)
- **502/504** → downstream systems (SQL, API, gateway) failing

---

## 🔥 Ultra-TLDR

```
200 = OK
201 = Created
301 = Permanent redirect
400 = Bad input
401 = Not logged in
403 = No access
404 = Not found
429 = Rate limited
500 = Server broke
502/504 = Upstream broke
503 = Server overloaded/down
```

---

If you want, I can map these directly to **Power BI / Fabric / Azure error scenarios** (much more actionable for your workflows).