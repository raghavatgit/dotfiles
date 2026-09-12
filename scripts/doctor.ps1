<#
.SYNOPSIS
    Diagnoses local developer environment and toolchain installations.
#>

Write-Host "Developer Environment Diagnostic" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor DarkGray

$tools = @(
    @{ Name = "Git"; Command = "git --version" },
    @{ Name = "GitHub CLI"; Command = "gh --version" },
    @{ Name = "Node.js"; Command = "node --version" },
    @{ Name = "npm"; Command = "npm --version" },
    @{ Name = "Rust (rustc)"; Command = "rustc --version" },
    @{ Name = "Cargo"; Command = "cargo --version" },
    @{ Name = "Python"; Command = "python --version" }
)

foreach ($tool in $tools) {
    try {
        $output = Invoke-Expression $tool.Command 2>$null
        if ($output) {
            $versionLine = ($output -split "`n")[0].Trim()
            Write-Host "  [OK] $($tool.Name): $versionLine" -ForegroundColor Green
        } else {
            Write-Host "  [MISSING] $($tool.Name)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "  [NOT FOUND] $($tool.Name)" -ForegroundColor Red
    }
}

Write-Host "================================" -ForegroundColor DarkGray
Write-Host "Diagnostic complete." -ForegroundColor Cyan
