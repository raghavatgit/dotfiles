<#
.SYNOPSIS
    Scans workspaces for Rust 'target' build folders and cleans them to reclaim disk space.
#>
param(
    [string]$Root = (Get-Location).Path,
    [switch]$Clean
)

Write-Host "Scanning for Rust Cargo target directories under: $Root" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor DarkGray

$cargoFiles = Get-ChildItem -Path $Root -Filter "Cargo.toml" -Recurse -Depth 4 -ErrorAction SilentlyContinue

$totalTargetMb = 0
foreach ($cargo in $cargoFiles) {
    $targetDir = Join-Path $cargo.Directory.FullName "target"
    if (Test-Path $targetDir) {
        $measure = Get-ChildItem -Path $targetDir -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
        $mb = [math]::Round($measure.Sum / 1MB, 2)
        $totalTargetMb += $mb
        Write-Host "  Found target in: $($cargo.Directory.Name) (${mb} MB)"
        
        if ($Clean) {
            Push-Location $cargo.Directory.FullName
            try {
                Write-Host "    Executing cargo clean..." -ForegroundColor Yellow
                cargo clean 2>$null
            } finally {
                Pop-Location
            }
        }
    }
}

Write-Host "========================================================" -ForegroundColor DarkGray
Write-Host "Total target space: ${totalTargetMb} MB" -ForegroundColor Green
if (-not $Clean) {
    Write-Host "Pass -Clean parameter to invoke 'cargo clean' across all identified projects." -ForegroundColor DarkGray
}
