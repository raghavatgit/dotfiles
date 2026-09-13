<#
.SYNOPSIS
    Prunes local git branches that have already been merged into main or master.
#>

$mainBranch = (git branch --list main master).Trim().Replace("*", "").Trim()
if (-not $mainBranch) {
    Write-Host "Neither 'main' nor 'master' branch found." -ForegroundColor Red
    exit 1
}

Write-Host "Targeting primary branch: $mainBranch" -ForegroundColor Cyan

# Fetch pruned remote references
git fetch --prune

# List merged branches excluding main/master
$mergedBranches = git branch --merged $mainBranch | 
    Where-Object { $_ -notmatch "^\*|main|master" } | 
    ForEach-Object { $_.Trim() }

if ($mergedBranches) {
    Write-Host "Found $($mergedBranches.Count) merged branches to delete:" -ForegroundColor Yellow
    foreach ($branch in $mergedBranches) {
        Write-Host "  Deleting $branch..." -ForegroundColor DarkGray
        git branch -d $branch
    }
    Write-Host "Branch cleanup complete." -ForegroundColor Green
} else {
    Write-Host "No merged branches to prune. Local repository is clean." -ForegroundColor Green
}
