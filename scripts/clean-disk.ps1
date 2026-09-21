# Developer Temporary Workspace Disk Cleaner
# Safely prunes user temp directories and development cache trees.

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Scanning temporary file caches..." -ForegroundColor Cyan

$paths = @(
    "$env:TEMP",
    "$env:LOCALAPPDATA\Temp"
)

$freedBytes = 0

foreach ($p in $paths) {
    if (Test-Path $p) {
        $files = Get-ChildItem -Path $p -File -Recurse -Force 2>$null | Where-Object {
            $_.LastWriteTime -lt (Get-Date).AddDays(-3)
        }
        foreach ($f in $files) {
            $freedBytes += $f.Length
            Remove-Item $f.FullName -Force -ErrorAction SilentlyContinue
        }
    }
}

$freedMb = [math]::Round($freedBytes / 1MB, 2)
Write-Host "Disk cleanup complete: Cleaned approximately $freedMb MB." -ForegroundColor Green
