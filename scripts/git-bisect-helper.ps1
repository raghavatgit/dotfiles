# Automated Git Bisect Test Harness Driver
# Automates test script execution during regression triage.

$ErrorActionPreference = "Stop"

param (
    [string]$GoodCommit = "",
    [string]$BadCommit = "HEAD",
    [string]$TestScript = "npm test"
)

Write-Host "Initializing automated git bisect runner..." -ForegroundColor Cyan

if (-not $GoodCommit) {
    Write-Host "Please specify a known -GoodCommit SHA." -ForegroundColor Red
    exit 1
}

git bisect start $BadCommit $GoodCommit
git bisect run powershell -Command $TestScript

Write-Host "Automated bisect run completed." -ForegroundColor Green
