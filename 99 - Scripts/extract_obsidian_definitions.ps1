<#
.SYNOPSIS
Extracts plain-text notes from Markdown files into a 2-column TSV.

.DESCRIPTION
Scans a folder for .md files, removes YAML-delimited blocks, converts Markdown
into readable plain text, sanitizes output into single-line notes, and writes a
UTF-8 TSV with columns: file_name, notes.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$RootPath,

    [Parameter()]
    [switch]$Recurse,

    [Parameter()]
    [string]$OutFile
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-MarkdownFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BasePath,
        [Parameter(Mandatory = $true)]
        [bool]$ScanRecursively
    )

    $result = New-Object System.Collections.Generic.List[System.IO.FileInfo]

    if (-not $ScanRecursively) {
        $topFiles = Get-ChildItem -LiteralPath $BasePath -File -Filter '*.md' -ErrorAction SilentlyContinue
        foreach ($f in $topFiles) {
            $result.Add($f)
        }
        return $result
    }

    $dirStack = New-Object System.Collections.Generic.Stack[System.IO.DirectoryInfo]
    $dirStack.Push((Get-Item -LiteralPath $BasePath))

    while ($dirStack.Count -gt 0) {
        $currentDir = $dirStack.Pop()

        try {
            $files = Get-ChildItem -LiteralPath $currentDir.FullName -File -Filter '*.md' -Force -ErrorAction Stop |
                Where-Object {
                    -not ($_.Attributes -band [System.IO.FileAttributes]::Hidden) -and
                    -not ($_.Attributes -band [System.IO.FileAttributes]::System)
                }

            foreach ($f in $files) {
                $result.Add($f)
            }
        } catch {
            # Skip unreadable directories/files and continue scanning.
        }

        try {
            $subDirs = Get-ChildItem -LiteralPath $currentDir.FullName -Directory -Force -ErrorAction Stop |
                Where-Object {
                    -not ($_.Attributes -band [System.IO.FileAttributes]::Hidden) -and
                    -not ($_.Attributes -band [System.IO.FileAttributes]::System)
                }

            foreach ($d in $subDirs) {
                $dirStack.Push($d)
            }
        } catch {
            # Skip unreadable directories and continue scanning.
        }
    }

    return $result
}

function Remove-YamlDelimitedBlocks {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $lines = [System.Text.RegularExpressions.Regex]::Split($Text, "`r`n|`n|`r")
    $kept = New-Object System.Collections.Generic.List[string]
    $insideYamlBlock = $false

    foreach ($line in $lines) {
        if ($line -match '^\s*---\s*$') {
            $insideYamlBlock = -not $insideYamlBlock
            continue
        }

        if (-not $insideYamlBlock) {
            $kept.Add($line)
        }
    }

    return ($kept -join "`n")
}

function Convert-MarkdownToPlainText {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $plain = $Text

    # Drop fenced code block markers while preserving inner text.
    $plain = $plain -replace '(?m)^\s*```+.*$', ''

    # Images: ![alt](url) -> alt
    $plain = $plain -replace '!\[([^\]]*)\]\((?:[^)]+)\)', '$1'

    # Links: [text](url) -> text
    $plain = $plain -replace '\[([^\]]+)\]\((?:[^)]+)\)', '$1'

    # Remove heading markers (#), blockquotes (>), and list markers.
    $plain = $plain -replace '(?m)^\s{0,3}#{1,6}\s*', ''
    $plain = $plain -replace '(?m)^\s{0,3}>\s?', ''
    $plain = $plain -replace '(?m)^\s*[-*+]\s+', ''
    $plain = $plain -replace '(?m)^\s*\d+\.\s+', ''

    # Remove emphasis markers and inline code backticks.
    $plain = $plain -replace '[*_`]', ''

    # Remove horizontal rule lines.
    $plain = $plain -replace '(?m)^\s*(?:-{3,}|\*{3,}|_{3,})\s*$', ''

    return $plain
}

function Format-NotesText {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $lines = [System.Text.RegularExpressions.Regex]::Split($Text, "`r`n|`n|`r")
    $cleanLines = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $trimmed = $line.Trim()
        if (-not [string]::IsNullOrWhiteSpace($trimmed)) {
            $cleanLines.Add($trimmed)
        }
    }

    return (($cleanLines -join ' ').Trim())
}

function ConvertTo-TsvSafeField {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    $escaped = $Value -replace "`t", ' '
    $escaped = $escaped -replace "`r`n|`n|`r", ' '
    return $escaped
}

$resolvedRoot = Resolve-Path -LiteralPath $RootPath -ErrorAction SilentlyContinue
if (-not $resolvedRoot) {
    throw "RootPath not found: $RootPath"
}

$rootItem = Get-Item -LiteralPath $resolvedRoot.Path
if (-not $rootItem.PSIsContainer) {
    throw "RootPath is not a directory: $($resolvedRoot.Path)"
}

if ([string]::IsNullOrWhiteSpace($OutFile)) {
    $OutFile = Join-Path -Path $resolvedRoot.Path -ChildPath 'extracted_notes.tsv'
}

$mdFiles = Get-MarkdownFiles -BasePath $resolvedRoot.Path -ScanRecursively:$Recurse.IsPresent

$outDir = Split-Path -Path $OutFile -Parent
if (-not [string]::IsNullOrWhiteSpace($outDir) -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$writer = New-Object System.IO.StreamWriter($OutFile, $false, $utf8NoBom)

try {
    $writer.WriteLine("file_name`tnotes")

    foreach ($file in $mdFiles) {
        try {
            $raw = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction Stop
            $withoutYaml = Remove-YamlDelimitedBlocks -Text $raw
            $plain = Convert-MarkdownToPlainText -Text $withoutYaml
            $notes = Format-NotesText -Text $plain

            if ([string]::IsNullOrWhiteSpace($notes)) {
                continue
            }

            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $safeFileName = ConvertTo-TsvSafeField -Value $fileName
            $safeNotes = ConvertTo-TsvSafeField -Value $notes

            $row = "{0}`t{1}" -f $safeFileName, $safeNotes
            $writer.WriteLine($row)
        } catch {
            # Per-file failure rule: skip row on read/parse errors.
            Write-Verbose ("Skipping file '{0}': {1}" -f $file.FullName, $_.Exception.Message)
            continue
        }
    }
}
finally {
    $writer.Dispose()
}

Write-Host "TSV written: $OutFile" -ForegroundColor Green
