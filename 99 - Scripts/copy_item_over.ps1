# PowerShell Script to copy the plugin file to Sublime Text Packages\User directory
$from = "C:\vsWorkspace_SD\sublime_sql_accelerator\sql_accelerator.py"
$to = "C:\Users\jonas-adam.pascua\AppData\Roaming\Sublime Text\Packages\User\sql_accelerator.py"

Write-Host "Moving file $($from)" -ForegroundColor Green
Copy-Item -Path $from -Destination $to -Force
Write-Host "Moved to $($to)" -ForegroundColor Green
