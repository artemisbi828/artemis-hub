Your Computer
├── Operating System (Windows)
│   └── PowerShell (shell - the environment)
│       ├── npm (tool - package manager)
│       │   ├── install (command)
│       │   └── run (command)
│       │       └── Your project's scripts
│       │           └── Uses libraries (React, Express, etc.)
│       ├── node (tool - engine that understands JavaScript language (javascript runtime))
│       │   ├── app (code loaded into memory)
│       │       ├── Modules / Files (How you organize the code)
│       │       │   ├── Classes (Blueprints/Templates)
│       │       │   └── Functions (Standalone Actions - Pure Logic)
│       │       │   │   └── Methods (Actions attached to a Class)
│       │       └── Variables / Data (The actual information being processed)
│       ├── git (tool - version control)
│       ├── docker (tool - containers)
│       ├── ngrok (tool - tunneling)
│       ├── node (tool)



### VM DESIGN
```
Your Computer (Work/Personal/Mac)
└── Browser (The new user interface, accessible via the public IP)
    └── Streamlit App (The interface / 'Head' we built)
        └── Python Code (The orchestrator)
            └── Subprocess Call (The command line executed by the Python code)

------------------------------------------------------------------------------------------

The Cloud VM (antigravity-box)
├── Operating System (Linux / Ubuntu)
│   └── SSH Session (shell - the environment, which is constantly open)
│       └── Python 3 Runtime (The engine that understands Python language)
│           ├── streamlit (tool - runs the web app interface)
│           └── aider (tool - the agent that performs actions) <--- **THIS IS THE AI BRAIN**
│               ├── LLM (Engine that understands instructions, generates solutions)
│               ├── Git Integration (Tool - version control)
│               ├── Codebase-aware editing (Tool - knows your /libs, /apps structure)
│               │   └── Automatic Context Gathering (Tool - reads files to understand the plan)
│               └── File System Access (Tool - writes new code and directories)
│
└── /home/jonas_pascua/workspace (The actual files being processed)
    ├── /libs (Cleaners)
    ├── /apps (Services)
    └── Git Repository (Aider makes an automatic commit for every change)
```
----

### **CLI (Command-Line Interface)**
CLI is not a tool itself - it's a **characteristic** of a tool: Git is the tool, CLI is an interface, also a feature of the tool. GitHub Desktop is an alternative feature or way to interact / interface.

- **CLI** = the way you interact with a tool (via text commands)
- **GUI** = the alternative way (graphical buttons/windows)

### **Package Managers**
React & Express are libraries pulled from managers
  
```
npm (package manager tool -- node)  
  └── Manages libraries in your project:  
      ├── react (library)  
      ├── express (library)  
      └── other libraries  
  
node (runtime tool)  
  └── Executes JavaScript code that uses:  
      ├── react (library)  
      ├── express (library)  
      └── other libraries
      
pip (package manager tool -- python)
 └── Manages libraries in your project:
     ├── pandas (data analysis library)
     ├── requests (HTTP library)
     └── shared-utils (your custom library)

python (runtime tool)
 └── Executes Python code that uses:
     ├── pandas (library)
     ├── requests (library)
     └── shared-utils (library)
```

---
## 📊 Hierarchies for PowerShell, npm, Docker

### **PowerShell (the shell)**

PowerShell (shell/environment)  
├── Get-Command (cmdlet)  
│   ├── -Name (parameter)  
│   └── -Module (parameter)  
├── Get-Process (cmdlet)  
│   ├── -Name (parameter)  
│   └── -Id (parameter)  
├── cd (alias for Set-Location)  
├── ls (alias for Get-ChildItem)  
└── Write-Host (cmdlet)  
    ├── -ForegroundColor (parameter)  
    └── -NoNewline (parameter)

### **npm (package manager tool)**

npm (the tool)  
├── install (command)  
│   ├── --save-dev (flag)  
│   ├── --global (flag)  
│   └── [package-name] (argument)  
├── run (command)  
│   └── [script-name] (argument)  
├── start (command)  
├── build (command)  
├── test (command)  
└── init (command)  
    └── -y (flag)

### **Docker (containerization tool)**

docker (the tool)  
├── run (command)  
│   ├── -d (flag: detached mode)  
│   ├── -p (flag: port mapping)  
│   ├── --name (flag: container name)  
│   └── [image-name] (argument)  
├── build (command)  
│   ├── -t (flag: tag)  
│   └── [path] (argument)  
├── ps (command)  
│   ├── -a (flag: show all)  
│   └── -q (flag: quiet mode)  
├── stop (command)  
│   └── [container-id] (argument)  
└── compose (command)  
    ├── up (subcommand)  
    ├── down (subcommand)  
    └── -f (flag: file)

### **git (version control tool)**

git (the tool)  
├── commit (command)  
│   ├── -m (flag: message)  
│   ├── -a (flag: all)  
│   └── --amend (flag)  
├── push (command)  
│   ├── origin (argument: remote)  
│   ├── main (argument: branch)  
│   └── --force (flag)  
├── pull (command)  
├── status (command)  
│   └── -s (flag: short)  
└── log (command)  
    ├── --oneline (flag)  
    └── -n (flag: number of commits)
    
**Library:**

- Code that you **import into your program**
- Example: 
    
    ```
    import React from 'react'
    ```
    
     - React is a library
- Example: 
    
    ```
    import express from 'express'
    ```
    
     - Express is a library
- Lives inside your project's 
    
    ```
    node_modules
    ```
    
     folder
- You write code that uses the library's functions

**Tool/CLI (Command-Line Interface):**

- A **standalone program** you run from the terminal
- Example: 
    
    ```
    ngrok
    ```
    
    , 
    
    ```
    git
    ```
    
    , 
    
    ```
    npm
    ```
    
    , 
    
    ```
    docker
    ```
    
- Installed globally on your system (not in your project)
- You interact with it by typing commands

**Command:**

- An instruction you give to a tool
- Example: 
    
    ```
    ngrok http 3000
    ```
    
     - "http" is the command, "3000" is an argument
- Example: 
    
    ```
    git commit
    ```
    
     - "commit" is the command

**Methods/Functions:**

- When you run 
    
    ```
    ngrok --help
    ```
    
    , it shows you **commands** (not methods)
- Methods are programming terms - they belong to objects in code
- CLI tools have **commands** and **flags/options**

**Hierarchy:**

ngrok (the tool)  
├── http (command)  
│   ├── --region (flag/option)  
│   └── --log (flag/option)  
├── tcp (command)  
└── version (command)

