# Delete files from source if they exist in target with matching content
# Compares first and last few lines to verify files are the same

param(
    [string]$srcPath,
    [string]$tgtPath
)

# Prompt for paths if not provided
if (-not $srcPath) {
    Write-Host "Enter SOURCE directory path (files will be deleted from here if they exist in target)" -ForegroundColor Yellow
    Write-Host "Tip: Right-click to paste, or press Enter to use clipboard content" -ForegroundColor Gray
    $srcPath = Read-Host "Source path"
    
    if ([string]::IsNullOrWhiteSpace($srcPath)) {
        $srcPath = Get-Clipboard.
        Write-Host "Using clipboard: $srcPath" -ForegroundColor Cyan
    }
}

if (-not $tgtPath) {
    Write-Host "`nEnter TARGET directory path (comparison folder)" -ForegroundColor Yellow
    Write-Host "Tip: Right-click to paste, or press Enter to use clipboard content" -ForegroundColor Gray
    $tgtPath = Read-Host "Target path"
    
    if ([string]::IsNullOrWhiteSpace($tgtPath)) {
        $tgtPath = Get-Clipboard
        Write-Host "Using clipboard: $tgtPath" -ForegroundColor Cyan
    }
}

# Validate paths exist
if (-not (Test-Path $srcPath -PathType Container)) {
    Write-Host "Error: Source directory not found: $srcPath" -ForegroundColor Red
    exit
}

if (-not (Test-Path $tgtPath -PathType Container)) {
    Write-Host "Error: Target directory not found: $tgtPath" -ForegroundColor Red
    exit
}

# Function to compare file content (first and last few lines)
function Test-FileContentMatch {
    param (
        [string]$file1Path,
        [string]$file2Path,
        [int]$linesToCompare = 5
    )
    
    # Read files
    $content1 = Get-Content $file1Path -ErrorAction SilentlyContinue
    $content2 = Get-Content $file2Path -ErrorAction SilentlyContinue
    
    # If either file is empty or can't be read, consider them different
    if (-not $content1 -or -not $content2) {
        return $false
    }
    
    # Get total lines
    $lines1 = $content1.Count
    $lines2 = $content2.Count
    
    # If line counts differ, files are different
    if ($lines1 -ne $lines2) {
        return $false
    }
    
    # Compare first N lines
    $firstLinesToCheck = [Math]::Min($linesToCompare, $lines1)
    for ($i = 0; $i -lt $firstLinesToCheck; $i++) {
        if ($content1[$i] -cne $content2[$i]) {
            return $false
        }
    }
    
    # Compare last N lines
    $lastLinesToCheck = [Math]::Min($linesToCompare, $lines1)
    for ($i = 1; $i -le $lastLinesToCheck; $i++) {
        if ($content1[-$i] -cne $content2[-$i]) {
            return $false
        }
    }
    
    return $true
}

Write-Host "`nComparing files..." -ForegroundColor Cyan
Write-Host "Source: $srcPath" -ForegroundColor Gray
Write-Host "Target: $tgtPath" -ForegroundColor Gray
Write-Host ""

# Get all files from source
$srcFiles = Get-ChildItem -Path $srcPath -File

$deletedCount = 0
$skippedCount = 0
$notFoundCount = 0

foreach ($srcFile in $srcFiles) {
    $tgtFilePath = Join-Path $tgtPath $srcFile.Name
    
    # Check if file exists in target
    if (Test-Path $tgtFilePath) {
        # Compare content
        if (Test-FileContentMatch $srcFile.FullName $tgtFilePath) {
            # Files match, delete from source
            Remove-Item -Path $srcFile.FullName -Force
            Write-Host "Deleted: $($srcFile.Name)" -ForegroundColor Green
            $deletedCount++
        }
        else {
            # Files differ, skip
            Write-Host "Skipped (content differs): $($srcFile.Name)" -ForegroundColor Yellow
            $skippedCount++
        }
    }
    else {
        # File doesn't exist in target
        $notFoundCount++
    }
}

# Summary
Write-Host "`n--- Summary ---" -ForegroundColor Cyan
Write-Host "Deleted: $deletedCount files" -ForegroundColor Green
Write-Host "Skipped (content differs): $skippedCount files" -ForegroundColor Yellow
Write-Host "Not in target: $notFoundCount files" -ForegroundColor Gray
Write-Host "`nCompleted!" -ForegroundColor Cyan
