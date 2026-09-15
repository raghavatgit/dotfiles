<#
.SYNOPSIS
    Scans child directories for node_modules and reports or cleans disk usage.
#>
param(
    [string]$Path = (Get-Location).Path,
    [switch]$Force
)

Write-Host "Scanning for node_modules directories under: $Path" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor DarkGray

$folders = Get-ChildItem -Path $Path -Directory -Filter "node_modules" -Recurse -Depth 4 -Force -ErrorAction SilentlyContinue

if (-not $folders) {
    Write-Host "No node_modules folders found." -ForegroundColor Green
    exit 0
}

$totalSize = 0
foreach ($folder in $folders) {
    $measure = Get-ChildItem -Path $folder.FullName -Recurse -Force -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    $mb = [math]::Round($measure.Sum / 1MB, 2)
    $totalSize += $mb
    Write-Host "  Found: $($folder.FullName) (${mb} MB)"
}

Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host "Total space occupied: ${totalSize} MB" -ForegroundColor Yellow

if ($Force) {
    Write-Host "Removing all identified node_modules..." -ForegroundColor Yellow
    foreach ($folder in $folders) {
        Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Cleanup completed." -ForegroundColor Green
} else {
    Write-Host "Pass -Force parameter to delete identified folders." -ForegroundColor DarkGray
}
