<#
-- allows me to input a filepath and it'll rename Dbo → dbo in filenames
-- 2026-01-09 11:42 AM -- learned that directory path != file path, directory path = folder path
-- C:\Users\jonas\Desktop\output\Centralc9.Dbo.Address.md
#>>

# Lowercase schema name in filenames between first and second period
param(
    [string]$inputFilePath
)

# Prompt for path if not provided
if (-not $inputFilePath) {
    Write-Host "Tip: Right-click to paste, or press Enter to use clipboard content" -ForegroundColor Yellow
    $inputFilePath = Read-Host "Enter the path to the input file (or press Enter to use clipboard)"
    
    # If empty, try to get from clipboard
    if ([string]::IsNullOrWhiteSpace($inputFilePath)) {
        $inputFilePath = Get-Clipboard
        Write-Host "Using clipboard: $inputFilePath" -ForegroundColor Cyan
    }
}

# Validate the file exists
if (-not (Test-Path $inputFilePath)) {
    Write-Host "Error: File not found at path: $inputFilePath" -ForegroundColor Red
    exit
}

# Function to lowercase between first and second period in filename
function Update-Filename {
    param (
        [string]$filename
    )
    
    # Find the first and second period positions
    $firstDot = $filename.IndexOf('.')
    $secondDot = $filename.IndexOf('.', $firstDot + 1)
    
    # If both periods exist
    if ($firstDot -ge 0 -and $secondDot -gt $firstDot) {
        # Extract the three parts
        $before = $filename.Substring(0, $firstDot + 1)
        $middle = $filename.Substring($firstDot + 1, $secondDot - $firstDot - 1)
        $after = $filename.Substring($secondDot)
        
        # Reconstruct with lowercase middle
        return $before + $middle.ToLower() + $after
    }
    
    # If not enough periods, return filename unchanged
    return $filename
}

# Get the directory (handle both file and directory paths)
if (Test-Path $inputFilePath -PathType Container) {
    # It's a directory
    $directory = $inputFilePath
} else {
    # It's a file, get its parent directory
    $directory = Split-Path -Parent $inputFilePath
}

# Get all markdown files in the directory
$files = Get-ChildItem -Path $directory -Filter "*.md"

$renamedCount = 0

foreach ($file in $files) {
    $newName = Update-Filename $file.Name
    
    # Use case-sensitive comparison (-cne)
    if ($newName -cne $file.Name) {
        # Rename to temp name first to force case change on Windows
        $tempName = "$($file.BaseName)_TEMP$($file.Extension)"
        $tempPath = Join-Path $directory $tempName
        
        Rename-Item -Path $file.FullName -NewName $tempName
        Rename-Item -Path $tempPath -NewName $newName
        
        Write-Host "Renamed: $($file.Name) -> $newName" -ForegroundColor Cyan
        $renamedCount++
    }
}

Write-Host "`nCompleted! Renamed $renamedCount files" -ForegroundColor Green