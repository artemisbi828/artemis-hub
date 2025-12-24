***IP Address*** -- Building Street Address
**Port** -- Room/Apartment Number
- **0-1023**: System/well-known ports (HTTP=80, HTTPS=443, SSH=22)
- **1024-49151**: Registered ports (apps can register these) 
- **49152-65535**: Dynamic/private ports

**WEB PORTS**
- 80: HTTP -- unencrypted web traffic
	- clipboard API requires HTTPS; inert otherwise
- 443: HTTPS -- need key (SSL Certificate); requires browser instance to have handshake
- 993: Email

**CONTROL PORTS**
- 22: SSH -- staff only entrance, admins
- 3389: RDP -- "Windows" entrance for Remote Desktop Protocol

DEV PORTS
80 and 443 require permissions, so we test using these: 
- 8080 -- Port 80 alternative, regular user not admin
- 8501 -- Streamlit
- 5000 -- Default for Flask (Python web apps)
- 3000 -- Default for React/Node.js



**SUMMARY TABLE**
Airports block 8501 so connecting even to my own computer will not work
I can test by using Streamlit to use Port 80 but I'll need SUDO to use it
`sudo python3 -m streamlit run app.py --server.port 80`

| **Name**      | **Port Range**    | **Requires sudo?** | **Examples**                                                           |
| ------------- | ----------------- | ------------------ | ---------------------------------------------------------------------- |
| System Ports  | **0 - 1023**      | **YES**            | 80 (Web), 443 (SSL), 22 (SSH)                                          |
| User Ports    | **1024 - 49151**  | **NO**             | 8501 (Streamlit), 5000 (Flask), 8080 (Alt Web)                         |
| Dynamic Ports | **49152 - 65535** | **NO**             | Temporary connections (like the "return address" for your browser tab) |

So, when you want to run on Port 80 to beat the airport Wi-Fi, you cross that invisible 1024 line, and Linux demands to see your badge (`sudo`).

Public Internet (WAN - Wide Area Network)
├── Your ISP assigns: e.g., 203.45.67.89
└── This is your "public" IP (visible to the internet)

Your Home Network (LAN - Local Area Network)
├── Router assigns: 192.168.x.x or 10.x.x.x
└── These are "private" IPs (only visible inside your home)