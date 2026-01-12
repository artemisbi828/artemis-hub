


> AccountSID  AC2a9e265bd812bb15ebd5cac887103d89
> AuthToken   cc984fd6700612c3c04f6da3ecf44de3
> 
> NGROK 
> AuthToken   35MAnctVVjixsCWZxYc0yEQz2s3_JGu14ZMMLrRF5w8uB47c
> Saves it to C:\Users\jpasc\AppData\Local/ngrok/ngrok.yml
> ngrok config add-authtoken 35MAnctVVjixsCWZxYc0yEQz2s3_JGu14ZMMLrRF5w8uB47c
> 
> $env:TWILIO_ACCOUNT_SID = "AC2a9e265bd812bb15ebd5cac887103d89"
> $env:TWILIO_AUTH_TOKEN = "cc984fd6700612c3c04f6da3ecf44de3"
> 
> python .\Twilio_Sandbox\send_sms.py
> 
> # Check WindowsApps alias location
> dir $env:LOCALAPPDATA\Microsoft\WindowsApps\ngrok* -ErrorAction SilentlyContinue
> 
> # Check local user programs folder
> dir $env:USERPROFILE\AppData\Local\Programs\ngrok* -ErrorAction SilentlyContinue
> 
> # Search your user folder quickly for ngrok.exe (may take a few seconds)
> Get-ChildItem -Path $env:USERPROFILE -Filter ngrok.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 10 | ForEach-Object { $_.FullName }
> 
> ## SET TO PATH
> [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Users\jpasc\AppData\Local\Microsoft\WinGet\Packages\Ngrok.Ngrok_Microsoft.Winget.Source_8wekyb3d8bbwe", "User")
> 
> 
> & C:\Users\jpasc\OneDrive\Documents.Work\Work.Artemis\SlideSMS\.venv\Scripts\Activate.ps1


