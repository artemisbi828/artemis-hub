---
concept_type:
aliases:
definition: speed dial to programs for commands (eg code or python)
related_object:
---


You are correct that the Google Cloud CLI installer often defaults to installing the files in a location like:

`C:\Users\jpasc\AppData\Local\Google\Cloud SDK\...`

**PowerShell**
You can verify that the installer successfully added the path by running a simple command in PowerShell:

```powershell
$env:Path -split ';' | Select-String 'gcloud'
```

- **Expected Output:** This command searches your environment paths. It should return a line showing the full directory path to the GCloud SDK's `bin` folder (e.g., `C:\Users\jpasc\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin`).
    

**Conclusion:** Even though the files are in a "hidden" AppData folder, the installation process correctly linked that location to your command line environment, allowing you to execute `gcloud` commands from anywhere in your PowerShell session. You do not need to move the installation.

# Why You Were Still Able to Run `gcloud init`

You were able to run `gcloud init` successfully because the **installer took a critical step for you**:

1. **It Modified the PATH:** When you installed the GCloud CLI, you ensured the option to **"Configure the environment"** was checked. This step automatically adds the necessary path to the executables (usually the `bin` subdirectory inside the SDK folder) to your Windows user's `PATH` environment variable.
2. **User vs. System PATH:** Windows has two primary PATH variables:
    
    - **System PATH:** Applies to all users.
    - User PATH: Applies only to your user (jpasc).

        The installer typically modifies your User PATH to include the AppData location.
        