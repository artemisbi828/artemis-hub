---
definition: A mini web server running on your computer**
aliases:
  - Dev Server
related_to: "[[Npm]]"
---
When you run 

```
npm run dev
```

:

1. Your computer starts a **web server program**
2. That server "listens" on a specific port (like 3000)
3. It serves your website files (HTML, CSS, JS)
4. You access it at 
    
    ```
    http://localhost:3000
    ```
    

**"Serving" means:**

- Your computer is acting like a waiter at a restaurant
- When you request 
    
    ```
    localhost:3000
    ```
    
    , it "serves" you the website files
- It's doing the same job as a real web server (like Vercel), just locally