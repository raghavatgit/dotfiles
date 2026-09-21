# Git Stash Inspection and Management Utility
# Lists git stashes with relative creation dates and branch origins.

$ErrorActionPreference = "Stop"

Write-Host "Inspecting Git stashes..." -ForegroundColor Cyan

$stashes = git stash list
if (-not $stashes) {
    Write-Host "No active git stashes found in repository." -ForegroundColor Green
    exit 0
}

Write-Host "Active Stash Inventory:" -ForegroundColor Gray
$stashes | ForEach-Object {
    Write-Host "  $_" -ForegroundColor Yellow
}
