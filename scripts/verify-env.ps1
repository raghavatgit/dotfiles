# Developer Toolchain and Environment Diagnostic
# Verifies installation, toolchain versions, and PATH bindings.

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Verifying developer toolchains..." -ForegroundColor Cyan

function Check-Tool ($name, $command) {
    $ver = Invoke-Expression $command 2>$null
    if ($ver) {
        Write-Host "  [OK] {0,-15}: {1}" -f $name, ($ver -split "`n")[0].Trim() -ForegroundColor Green
    } else {
        Write-Host "  [--] {0,-15}: Not installed or not in PATH" -f $name -ForegroundColor Yellow
    }
}

Check-Tool "Rust compiler" "rustc --version"
Check-Tool "Cargo package" "cargo --version"
Check-Tool "Node.js runtime" "node --version"
Check-Tool "npm package" "npm --version"
Check-Tool "Python runtime" "python --version"
Check-Tool "Git VCS" "git --version"
Check-Tool "GitHub CLI" "gh --version"

Write-Host "`nEnvironment diagnostics verified." -ForegroundColor Cyan
