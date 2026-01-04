#quick-paste-merge-later 
# 1. The Physical & Virtual Hardware Layer

Your computer has multiple "Network Interface Cards" (NICs). Some are real physical chips, others are virtual software emulations.

### **A. Physical Adapters (Real Hardware)**
These are actual chips on your motherboard.

- **
    ```
	Wireless LAN adapter Wi-Fi
    ```

    **: This is your real WiFi card.
    - **Status**: **Connected** (It has an IP: 

        ```
        192.168.1.112
        ```

        ).
    - **Role**: This is your main pipe to the world. This is the IP Rosa will use.
- **

    ```
    Ethernet adapter Ethernet
    ```

    **: The physical port for a LAN cable.
    - **Status**: **Media disconnected** (No cable plugged in).
- **

    ```
    Ethernet adapter Bluetooth Network Connection
    ```

    **: The Bluetooth chip.
    - **Status**: **Media disconnected**.
    - **Why?** Bluetooth has different "profiles." Your headphones use the **Audio Profile**. This adapter is for the **PAN (Personal Area Network) Profile**, which is used for _internet tethering_ (e.g., using your phone's data on your PC via Bluetooth). Since you aren't tethering, the "Network" part of the chip is disconnected, even if the "Audio" part is blasting music.
    - **Can you transfer files?** Yes, but modern file transfer (like AirDrop or Windows Nearby Share) usually negotiates via Bluetooth but does the heavy lifting over WiFi (faster) or creates a temporary ad-hoc WiFi connection. Pure Bluetooth file transfer is very slow (old school).

### **B. Virtual Adapters (Software)**

These look like hardware to Windows, but they are just software drivers created by apps.

    ```
    Unknown adapter NordLynx
    ```

    **: Created by NordVPN.
    - **Status**: **Active!** (It has an IP: 

        ```
        10.5.0.2
        ```

        ).
    - **Wait, why?** Even if the Nord app is closed, the _background service_ often keeps this virtual adapter "up" so it's ready to tunnel traffic instantly when you click connect. It's like a tunnel that is dug but has the gate closed.
- **

    ```
    Unknown adapter OpenVPN...
    ```

    **: Another virtual cable for a different VPN protocol (OpenVPN).
    - **Status**: Disconnected.

---

# 2. The Addressing Layer (IPv4 vs IPv6)
Once you have a connection, you need an address so mail can find you.

### **IPv4 (The Standard)**

- **Example**: 
    ```
    192.168.1.112
    ```
    
- **What is it?**: The classic address format. It's 32-bit (4 numbers, 0-255).
- **The Problem**: We ran out of these addresses years ago. That's why your router gives you a "private" internal IP (

    ```
    192.168...
    ```

    ) and shares one single "public" IP for your whole house.

### **IPv6 (The Future/Advanced)**

- **Example**: 
    ```
    fe80::49d9:3d9a:2704:53fa
    ```
    
- **What is it?**: 128-bit address. It's hexadecimal (uses letters a-f).
- **Why use it?**:
    - **Infinite Space**: Every atom on Earth could have its own IP.
    - **No NAT**: Devices can talk directly to each other across the internet without complex router translation (NAT).
    - **Security**: It was built with security (IPSec) in mind, though IPv4 has patched that in too.
- **When is it used?**: Mostly by your ISP and mobile networks internally. Your local home network usually prefers IPv4 because it's easier for humans to read and manage.

---

# 3. The Navigation Layer (Subnet & Gateway)
Now you have an address, but how do you know where to send traffic?

### **Subnet Mask**

- **Your Value**: 

    ```
    255.255.255.0
    ```
    
- **Definition**: It defines the **size of your local neighborhood**.
- **How to read it**:
    - ```
        255
        ```

         means "This part must match exactly."
    - ```
        0
        ```

         means "This part can be different."
- **Translation**: "Any device starting with 

    ```
    192.168.1
    ```

     is my neighbor (Local). I can shout directly to them. Anything else is a stranger (Internet)."
- **For Rosa**: Since she is on 

    ```
    192.168.1.x
    ```

     (likely), your computer sees her as a "neighbor" and talks directly.

### **Default Gateway**

- **Your Value**: 
```
192.168.1.254
```
 
- **Definition**: This is your **Router**.
- **Role**: It's the exit door. If you try to reach a website (like 

```
google.com
```

    ) that _doesn't_ start with 

  ```
  192.168.1
  ```

    , your computer says, "I don't know where that is, I'll just throw this packet at the Gateway (Router) and let it handle it."