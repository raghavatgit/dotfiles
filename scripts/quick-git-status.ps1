<#
.SYNOPSIS
    Scans child directories for git repositories and outputs a consolidated status matrix.
#>

param(
    [string]$RootPath = (Get-Location).Path
)

Write-Host "Scanning workspace git repositories under: $RootPath" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor DarkGray

$repos = Get-ChildItem -Path $RootPath -Directory -Recurse -Depth 2 -Force | 
    Where-Object { Test-Path (Join-Path $_.FullName ".git") }

$summary = @()

foreach ($repo in $repos) {
    Push-Location $repo.FullName
    try {
        $branch = (git branch --show-current 2>$null).Trim()
        $status = (git status --porcelain 2>$null)
        $unpushed = (git log --branches --not --remotes --oneline 2>$null | Measure-Object).Count

        $isDirty = ($status.Count -gt 0)

        $summary += [PSCustomObject]@{
            Repository = $repo.Name
            Branch     = if ($branch) { $branch } else { "HEAD detached" }
            Dirty      = if ($isDirty) { "Yes ($($status.Count) files)" } else { "Clean" }
            Unpushed   = $unpushed
        }
    } finally {
        Pop-Location
    }
}

$summary | Format-Table -AutoSize
Write-Host "=================================================================" -ForegroundColor DarkGray
Write-Host "Scan completed. Total repositories inspected: $($repos.Count)" -ForegroundColor Green
