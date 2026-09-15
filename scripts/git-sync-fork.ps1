<#
.SYNOPSIS
    Fetches upstream remote changes and rebases the current branch.
#>
param(
    [string]$UpstreamBranch = "main"
)

Write-Host "Syncing fork with upstream remote..." -ForegroundColor Cyan

# Check for upstream remote
$hasUpstream = (git remote -v) -match "upstream"
if (-not $hasUpstream) {
    Write-Host "Error: No 'upstream' remote configured. Use: git remote add upstream <url>" -ForegroundColor Red
    exit 1
}

git fetch upstream
$currentBranch = (git branch --show-current).Trim()
Write-Host "Rebasing $currentBranch onto upstream/$UpstreamBranch..." -ForegroundColor Yellow
git rebase "upstream/$UpstreamBranch"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Fork synchronization successful." -ForegroundColor Green
} else {
    Write-Host "Rebase conflict detected. Resolve conflicts and run 'git rebase --continue'." -ForegroundColor Red
}
