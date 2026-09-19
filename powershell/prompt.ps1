# Custom High-Performance PowerShell Prompt
# Embeds Git branch, dirty status, and return code status.

function prompt {
    $lastExit = $LASTEXITCODE
    $currDir = Split-Path -Leaf (Get-Location)

    $gitBranch = ""
    $gitStatus = git status --porcelain 2>$null
    $branchName = git rev-parse --abbrev-ref HEAD 2>$null

    if ($branchName) {
        $dirty = if ($gitStatus) { "*" } else { "" }
        $gitBranch = " [$branchName$dirty]"
    }

    $statusColor = if ($lastExit -eq 0) { "Green" } else { "Red" }
    Write-Host ("$currDir") -NoNewline -ForegroundColor Cyan
    Write-Host ("$gitBranch") -NoNewline -ForegroundColor Yellow
    Write-Host (" > ") -NoNewline -ForegroundColor $statusColor

    return " "
}
