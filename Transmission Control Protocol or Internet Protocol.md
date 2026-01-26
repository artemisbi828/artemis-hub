---
aliases:
  - TCP/IP
---
In the context of databases, **TCP/IP** (Transmission Control Protocol/Internet Protocol) is the standard "language" used for computers to talk to each other over a network.

When you enabled it for SQL Server, you were essentially telling the database to stop whispering to itself and start listening for external requests.

---

### 1. The Breakdown

To understand it simply, think of it as a **Mailing System**:

- **IP (The Address):** This is the "where." It identifies your computer on the network (e.g., `127.0.0.1` or `localhost`). It ensures the data packet reaches the right house.
    
- **TCP (The Delivery Confirmation):** This is the "how." It ensures that once the data arrives, it is in the right order and nothing was lost. If a piece of your query goes missing, TCP notices and asks the sender to "resend that part."
    

### 2. Why Databases Need It

Most modern tools (like **DataGrip**, **Power BI**, or a **Python** script) don't have direct access to your computer's internal memory. Instead, they act like a "client" that sends a request to a "server."

Even if the client and server are on the same physical laptop, they communicate through a **Port** (for SQL Server, the default "door" is **1433**). TCP/IP is the hallway that connects your IDE to that door.

### 3. Why was it disabled?

Microsoft disables TCP/IP by default in many SQL Server installations for two reasons:

1. **Security:** If the "door" (port) isn't open, hackers on your Wi-Fi can't even try to guess your password.
    
2. **Resources:** It saves a tiny bit of system memory not to have the network listener running.
    

### 4. How it relates to your move to DuckDB

This is one of the biggest "quality of life" upgrades you are about to experience:

- **SQL Server:** Requires TCP/IP protocols, ports (1433), and complex network configurations just to see your own data.
    
- **DuckDB:** Has **no network protocol**. Because it is "in-process," DataGrip reads the file directly from your hard drive like a Word document. There are no ports to open and no services to start.
    

---

**Now that the "pipe" is open and DataGrip is talking to SQL Server, would you like to try moving that 10k row table into a DuckDB file to see the speed difference?**