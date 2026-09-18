# Dotfiles Synchronization Automation
# Validates repository clean state and synchronizes upstream dotfiles repository.

$ErrorActionPreference = "Stop"

Write-Host "Checking dotfiles synchronization status..." -ForegroundColor Cyan

$status = git status --porcelain
if ($status) {
    Write-Host "Uncommitted local changes detected in dotfiles repo:" -ForegroundColor Yellow
    $status | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
    Write-Host "Aborting sync to prevent overwriting working directory." -ForegroundColor Red
    exit 1
}

Write-Host "Pulling latest upstream changes..." -ForegroundColor Gray
git pull --rebase origin main

Write-Host "Dotfiles repository synchronized successfully." -ForegroundColor Green
