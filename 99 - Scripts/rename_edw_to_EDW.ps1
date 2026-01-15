# rename_edw_to_EDW.ps1
# Renames files in a directory: "Edw" -> "EDW" (case-sensitive), non-recursive

param(
    [string]$directoryPath = "."
)

# Validate directory
if (-not (Test-Path $directoryPath -PathType Container)) {
    Write-Host "Error: Directory not found: $directoryPath" -ForegroundColor Red
    exit 1
}

$files = Get-ChildItem -Path $directoryPath -File
$renamed = 0
$skipped = 0

foreach ($f in $files) {
    # Case-sensitive replace
    $newName = $f.Name -creplace 'Edw', 'EDW'

    # Only proceed if name actually changes (case-sensitive)
    if ($newName -cne $f.Name) {
        $target = Join-Path $f.DirectoryName $newName
        $caseOnly = ($f.Name.ToLowerInvariant() -eq $newName.ToLowerInvariant())

        # If a different file with the target name already exists, skip
        if (Test-Path $target -PathType Leaf -and ($f.FullName -ine $target)) {
            Write-Host "Skip (conflict): $($f.Name) -> $newName" -ForegroundColor Yellow
            $skipped++
            continue
        }

        try {
            if ($caseOnly) {
                # Force case-change on Windows via temporary hop
                $tmp = Join-Path $f.DirectoryName ("{0}_TMP_{1}{2}" -f $f.BaseName, (Get-Random), $f.Extension)
                Rename-Item -LiteralPath $f.FullName -NewName $tmp -ErrorAction Stop
                Rename-Item -LiteralPath $tmp -NewName $newName -ErrorAction Stop
            } else {
                Rename-Item -LiteralPath $f.FullName -NewName $newName -ErrorAction Stop
            }

            Write-Host "Renamed: $($f.Name) -> $newName" -ForegroundColor Cyan
            $renamed++
        }
        catch {
            Write-Host "Error renaming $($f.Name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "Completed. Renamed: $renamed, Skipped (conflicts): $skipped" -ForegroundColor Green