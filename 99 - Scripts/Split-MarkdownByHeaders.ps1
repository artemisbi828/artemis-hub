param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

# Validate input file exists
if (-not (Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

# Get the directory of the input file and create output subdirectory
$inputDir = Split-Path $InputFile -Parent
$outputDir = Join-Path $inputDir "output"

# Create output directory if it doesn't exist
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
    Write-Host "Created output directory: $outputDir" -ForegroundColor Green
}

# Read the input file
$content = Get-Content $InputFile

# Variables to track current file
$currentTitle = $null
$currentContent = @()
$fileCount = 0

# Function to save current file
function Save-CurrentFile {
    param($title, $content)
    
    if ($null -eq $title) { return }
    
    # Clean the title for use as filename (remove # and trim)
    $cleanTitle = $title -replace '^#+\s*', '' -replace '[\\/:*?"<>|]', '-'
    $cleanTitle = $cleanTitle.Trim()
    
    if ([string]::IsNullOrWhiteSpace($cleanTitle)) { return }
    
    # Create filename
    $fileName = "$cleanTitle.md"
    $filePath = Join-Path $outputDir $fileName
    
    # Prepare content (remove empty lines at start and end)
    $contentToSave = $content | Where-Object { $_ -ne $null }
    while ($contentToSave.Count -gt 0 -and [string]::IsNullOrWhiteSpace($contentToSave[0])) {
        $contentToSave = $contentToSave[1..($contentToSave.Count - 1)]
    }
    while ($contentToSave.Count -gt 0 -and [string]::IsNullOrWhiteSpace($contentToSave[-1])) {
        $contentToSave = $contentToSave[0..($contentToSave.Count - 2)]
    }
    
    # Save the file
    $contentToSave | Set-Content -Path $filePath -Encoding UTF8
    Write-Host "Created: $fileName" -ForegroundColor Cyan
    
    return 1
}

# Process each line
foreach ($line in $content) {
    if ($line -match '^#') {
        # Found a new header - save the previous file if exists
        if ($null -ne $currentTitle) {
            $fileCount += Save-CurrentFile -title $currentTitle -content $currentContent
        }
        
        # Start new file
        $currentTitle = $line
        $currentContent = @()
    }
    else {
        # Add line to current content
        if ($null -ne $currentTitle) {
            $currentContent += $line
        }
    }
}

# Save the last file
if ($null -ne $currentTitle) {
    $fileCount += Save-CurrentFile -title $currentTitle -content $currentContent
}

# Summary
Write-Host "`nComplete! Created $fileCount markdown files in: $outputDir" -ForegroundColor Green
