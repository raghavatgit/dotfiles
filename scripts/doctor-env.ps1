# Comprehensive Developer Toolchain Diagnostic Doctor
# Evaluates compiler versions, package managers, and Git configurations.

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Running Antigravity Developer Toolchain Doctor..." -ForegroundColor Cyan

$diagnostics = @(
    @{ Name = "Git VCS"; Cmd = "git --version" },
    @{ Name = "GitHub CLI"; Cmd = "gh --version" },
    @{ Name = "Rust Toolchain"; Cmd = "rustc --version" },
    @{ Name = "Cargo Package"; Cmd = "cargo --version" },
    @{ Name = "Node.js Engine"; Cmd = "node --version" },
    @{ Name = "Python 3 Engine"; Cmd = "python --version" }
)

$passed = 0
foreach ($d in $diagnostics) {
    $out = Invoke-Expression $d.Cmd 2>$null
    if ($out) {
        $firstLine = ($out -split "`n")[0].Trim()
        Write-Host "  [PASS] {0,-18}: {1}" -f $d.Name, $firstLine -ForegroundColor Green
        $passed++
    } else {
        Write-Host "  [FAIL] {0,-18}: Not resolved in environment PATH" -f $d.Name -ForegroundColor Red
    }
}

Write-Host "`nDoctor completed: $passed / $($diagnostics.Count) toolchains healthy." -ForegroundColor Cyan
