<#
.SYNOPSIS
    Cleans up local Git branches that have been merged into the default upstream branch.
.DESCRIPTION
    Safely prunes remote tracking references, compares local branches against origin/main or origin/master,
    and prompts for deletion confirmation.
#>

[CmdletBinding()]
param(
    [string]$TargetBranch = "main"
)

Write-Host "Fetching and pruning remote refs..." -ForegroundColor Cyan
git fetch --prune origin

$current = (git rev-parse --abbrev-ref HEAD).Trim()
Write-Host "Current branch: $current" -ForegroundColor Green

$mergedBranches = git branch --merged "origin/$TargetBranch" | ForEach-Object { $_.Trim() } | Where-Object {
    $_ -ne $current -and $_ -ne $TargetBranch -and $_ -ne "master" -and -not $_.StartsWith("*")
}

if (-not $mergedBranches) {
    Write-Host "No stale merged branches found to clean." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($mergedBranches.Count) merged branches eligible for deletion:" -ForegroundColor Yellow
$mergedBranches | ForEach-Object { Write-Host " - $_" -ForegroundColor DarkGray }

$confirm = Read-Host "Proceed with deleting these branches? (y/N)"
if ($confirm -eq 'y' -or $confirm -eq 'Y') {
    foreach ($branch in $mergedBranches) {
        git branch -d $branch
        Write-Host "Deleted branch: $branch" -ForegroundColor Green
    }
} else {
    Write-Host "Operation cancelled." -ForegroundColor Yellow
}
