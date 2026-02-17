Login via google: jpascua@gmail.com

Setup
![[Pasted image 20260215123312.png]]
The One Big Fix: Proxy Status
Your instructions explicitly state to set the Proxy to DNS only (gray cloud).

Current State: In your screenshot, the toggle is orange (Proxied).

Action Needed: Click that toggle so it becomes gray. When Cloudflare is "Proxied," it masks your IP and uses its own SSL certificates. Since your instructions mention handling SSL separately (likely on your Google VM), keeping it orange could cause a "Redirect Loop" or SSL mismatch error.