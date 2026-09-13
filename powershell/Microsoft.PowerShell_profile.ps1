# PowerShell Profile: Raghav Goyal
# Optimized for quick navigation and git operations

# Quick Navigation
function .. { Set-Location .. }
function ... { Set-Location ..\.. }

# Git Shortcuts
function gs { git status --short }
function gl { git log --oneline --graph -n 15 }
function gd { git diff }
function gaa { git add --all }
function gco { param($branch) git checkout $branch }
function gcb { param($branch) git checkout -b $branch }

# Fast Directory Jump
function cdw { Set-Location "$HOME\Documents\work" }
function cdd { Set-Location "$HOME\Desktop" }

# Clean screen
Set-Alias -Name c -Value Clear-Host

# Port Inspection and Management Utilities
function Find-Port {
    param([Parameter(Mandatory=$true)][int]$Port)
    Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue | 
        Select-Object LocalAddress, LocalPort, OwningProcess, State
}

function Kill-Port {
    param([Parameter(Mandatory=$true)][int]$Port)
    $processes = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue | 
        Select-Object -ExpandProperty OwningProcess -Unique
    if ($processes) {
        foreach ($pid in $processes) {
            Write-Host "Stopping process $pid listening on port $Port..." -ForegroundColor Yellow
            Stop-Process -Id $pid -Force
        }
    } else {
        Write-Host "No active processes found listening on port $Port." -ForegroundColor Green
    }
}
