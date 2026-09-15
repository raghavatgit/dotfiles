<#
.SYNOPSIS
    Extended Git shortcuts and interactive rebasing helper functions for PowerShell.
#>

# Pretty git log graph with branch topologies
function glg {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20
}

# Inspect commit divergence against upstream main
function gdiv {
    param([string]$Base = "main")
    Write-Host "Commits on HEAD not in $Base:" -ForegroundColor Cyan
    git log "$Base..HEAD" --oneline
}

# Quick stash with descriptive timestamp
function gss {
    param([string]$Message = "wip")
    $ts = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    git stash push -m "[$ts] $Message"
}

# Pop latest stash
function gsp {
    git stash pop
}
