# Batch Create Markdown Files from Text File
# Prompts for a filepath, parses lines starting with "#" as filenames,
# and creates individual markdown files with content between headers

param(
    [Parameter(Mandatory=$true)]
    [string]$inputFilePath
)


# Prompt for the input file path
#$inputFilePath = Read-Host "Enter the path to the input file"

# Validate the file exists
if (-not (Test-Path $inputFilePath)) {
    Write-Host "Error: File not found at path: $inputFilePath" -ForegroundColor Red
    exit
}

# Function to clean and format filename
function Format-Filename {
    param (
        [string]$rawName
    )
    
    # Remove the leading # and any extra #'s
    $cleaned = $rawName -replace '^#+\s*', ''
    
    # Replace bad characters (/, \, :, *, ?, ", <, >, |) with space
    $cleaned = $cleaned -replace '[/\\:*?"<>|]', ' '
    
    # Trim leading and trailing spaces
    $cleaned = $cleaned.Trim()
    
    return $cleaned
}

# Get the directory of the input file
$inputDirectory = Split-Path -Parent $inputFilePath
$inputFileName = Split-Path -Leaf $inputFilePath
$outputSubDir = Join-Path $inputDirectory "output"

# Create the output subdirectory if it doesn't exist
if (-not (Test-Path $outputSubDir)) {
    New-Item -ItemType Directory -Path $outputSubDir | Out-Null
    Write-Host "Created output directory: $outputSubDir" -ForegroundColor Green
}

# Read all lines from the file
$lines = Get-Content $inputFilePath

# Variables to track current file being processed
$currentFileName = $null
$currentContent = @()
$filesCreated = 0

# Process each line
foreach ($line in $lines) {
    if ($line -match '^#') {
        # If we have a previous file to save, save it now
        if ($currentFileName) {
            $outputPath = Join-Path $outputSubDir "$currentFileName.md"
            $currentContent -join "`n" | Set-Content -Path $outputPath -Encoding UTF8
            Write-Host "Created: $currentFileName.md" -ForegroundColor Cyan
            $filesCreated++
        }
        
        # Start a new file
        $currentFileName = Format-Filename $line
        $currentContent = @()
    }
    else {
        # Add content to the current file (skip if no filename yet)
        if ($currentFileName) {
            $currentContent += $line
        }
    }
}

# Save the last file if there is one
if ($currentFileName -and $currentContent.Count -gt 0) {
    $outputPath = Join-Path $outputSubDir "$currentFileName.md"
    $currentContent -join "`n" | Set-Content -Path $outputPath -Encoding UTF8
    Write-Host "Created: $currentFileName.md" -ForegroundColor Cyan
    $filesCreated++
}

# Summary
Write-Host "`nCompleted! Created $filesCreated markdown files in: $outputSubDir" -ForegroundColor Green
