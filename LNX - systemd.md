system == PID1 (the king)
unit file == windows `.ini` file
linux's `nano` == window's `notepad`

## ⚙️ Understanding `systemd`

You are correct that **`systemd`** is the system and service manager for most modern Linux distributions (including your GCP VM).

### Your Observation (The Unit File)

> _"...it recognizes the commands such as [Service] and by specifying paths and commands (venv/bin/streamlit -- by passing in the command "run app.py"), then it knows what to run as if I was there manually."_

This is exactly right. The file you created (`client-bridge.service`) is called a **Unit File**.

- **Service Definition:** The unit file is inspired by Windows `.ini` files. It defines a **Unit** (a system resource). In our case, the unit type is a **`service`**.
    
- **The Sections:**
    
    - `[Unit]` defines the description and dependencies (like `After=network.target`, meaning "start only after the network is ready").
        
    - `[Service]` defines **how** to run the app. The `ExecStart` line contains the _exact, absolute path_ to the Python executable and the commands to run, just as if you typed it manually in the terminal.
        
    - `[Install]` defines **when** to run the app (like starting it on system boot/resume).
        
- **PID 1 (The King):** `systemd` runs as the very first process when the VM starts (it has **Process ID 1**, or PID 1). It is responsible for starting, monitoring, and shutting down all other processes on the system.
    

---

## 📁 What is the `/etc` directory?

Your understanding that `nano` is the "Linux notepad" is essentially correct—it's a simple, command-line text editor.

The `/etc` directory is one of the most important directories in the Linux file system:

### `/etc` = Et Cetera (Configuration)

|**Directory Name**|**Purpose**|**What We Did**|
|---|---|---|
|**`/etc`**|**Configuration Files** (Historically "et cetera," but now exclusively for system-wide configuration). This directory is the **brain** or **nerve center** of the Linux system.|We edited a file in `/etc/systemd/system/`.|
|**`/etc/systemd/system`**|**Custom Service Definitions**|This specific subdirectory is the standard location for system administrators (like you) to place **custom unit files** that override or extend the system's default services.|

**In short:** If you want to change how the system itself behaves (network settings, user authentication, services, etc.), you edit a file in `/etc`. Because these files are so critical, you need **root privileges** (using `sudo`) to modify them.