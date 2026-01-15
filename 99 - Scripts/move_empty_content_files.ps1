# move_empty_content_files.ps1
# Moves files with no content after the second "---" to a TMP subdirectory
# Usage: .\move_empty_content_files.ps1 -directoryPath "C:\path\to\directory" 

param(
    [string]$directoryPath
)

# Prompt for directory if not provided
if (-not $directoryPath) {
    Write-Host "Enter directory path to process" -ForegroundColor Yellow
    $directoryPath = Read-Host "Directory path"
    
    if ([string]::IsNullOrWhiteSpace($directoryPath)) {
        $directoryPath = Get-Clipboard
        Write-Host "Using clipboard: $directoryPath" -ForegroundColor Cyan
    }
}

# Validate directory exists
if (-not (Test-Path $directoryPath -PathType Container)) {
    Write-Host "Error: Directory not found: $directoryPath" -ForegroundColor Red
    exit
}

# Create TMP subdirectory if it doesn't exist
$tmpDir = Join-Path $directoryPath "TMP"
if (-not (Test-Path $tmpDir)) {
    New-Item -ItemType Directory -Path $tmpDir | Out-Null
    Write-Host "Created TMP directory: $tmpDir" -ForegroundColor Green
}

# Get all markdown files
$files = Get-ChildItem -Path $directoryPath -Filter "*.md" -File

$movedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Find the second occurrence of "---"
    $firstDash = $content.IndexOf('---')
    if ($firstDash -ge 0) {
        $secondDash = $content.IndexOf('---', $firstDash + 3)
        
        if ($secondDash -ge 0) {
            # Get content after the second "---"
            $afterSecondDash = $content.Substring($secondDash + 3).Trim()
            
            # If empty or whitespace only, move the file
            if ([string]::IsNullOrWhiteSpace($afterSecondDash)) {
                Move-Item -Path $file.FullName -Destination $tmpDir -Force
                Write-Host "Moved: $($file.Name)" -ForegroundColor Cyan
                $movedCount++
            }
        }
    }
}

Write-Host "`nCompleted! Moved $movedCount file(s) to TMP\" -ForegroundColor Green