<#
.SYNOPSIS
    Automated polyglot test suite runner. Detects active project stack and executes tests.
#>

$currentDir = Get-Location

Write-Host "Evaluating project test suite at: $currentDir" -ForegroundColor Cyan
Write-Host "------------------------------------------------" -ForegroundColor DarkGray

if (Test-Path "Cargo.toml") {
    Write-Host "Detected Rust Cargo project. Executing 'cargo test'..." -ForegroundColor Green
    cargo test
    $code = $LASTEXITCODE
} elseif (Test-Path "package.json") {
    Write-Host "Detected Node.js project. Executing 'npm test'..." -ForegroundColor Green
    npm test
    $code = $LASTEXITCODE
} elseif (Test-Path "pytest.ini" -Or (Test-Path "pyproject.toml") -Or (Test-Path "requirements.txt")) {
    Write-Host "Detected Python project. Executing 'pytest'..." -ForegroundColor Green
    pytest
    $code = $LASTEXITCODE
} else {
    Write-Host "No recognized test manifest found (Cargo.toml, package.json, or pytest configuration)." -ForegroundColor Yellow
    $code = 0
}

Write-Host "------------------------------------------------" -ForegroundColor DarkGray
if ($code -eq 0) {
    Write-Host "Test execution completed successfully." -ForegroundColor Green
} else {
    Write-Host "Test execution exited with error code $code." -ForegroundColor Red
}
exit $code
