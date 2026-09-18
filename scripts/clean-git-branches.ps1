# Automated Git Branch Cleaner
# Prunes local branches that have already been merged into the default branch.

$ErrorActionPreference = "Stop"

Write-Host "Fetching remote branch status..." -ForegroundColor Cyan
git fetch --prune

$defaultBranch = (git symbolic-ref refs/remotes/origin/HEAD | Split-Path -Leaf)
if (-not $defaultBranch) {
    $defaultBranch = "main"
}

Write-Host "Default upstream branch is: $defaultBranch" -ForegroundColor Gray

$mergedBranches = (git branch --merged $defaultBranch) | ForEach-Object { $_.Trim() } | Where-Object {
    $_ -ne $defaultBranch -and $_ -notmatch "^\*" -and $_ -ne "master" -and $_ -ne "main"
}

if ($mergedBranches.Count -eq 0) {
    Write-Host "No stale merged branches detected." -ForegroundColor Green
    exit 0
}

Write-Host "Found $($mergedBranches.Count) stale branches to prune:" -ForegroundColor Yellow
$mergedBranches | ForEach-Object {
    Write-Host "  Deleting: $_" -ForegroundColor Gray
    git branch -d $_
}

Write-Host "Branch cleanup completed successfully." -ForegroundColor Green
