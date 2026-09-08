<#
.SYNOPSIS
    Measures execution time and memory footprint of commands or build pipelines.

.PARAMETER Command
    The scriptblock or CLI command to benchmark.
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Command
)

Write-Host "Benchmarking execution: $Command" -ForegroundColor Cyan
$sw = [System.Diagnostics.Stopwatch]::StartNew()

try {
    Invoke-Expression $Command
    $exitCode = $LASTEXITCODE
} catch {
    Write-Error "Command execution failed: $_"
    $exitCode = 1
} finally {
    $sw.Stop()
    $elapsed = $sw.Elapsed
    
    Write-Host ""
    Write-Host "Benchmark Summary" -ForegroundColor Green
    Write-Host "  Duration : $([math]::Round($elapsed.TotalSeconds, 3))s ($($elapsed.TotalMilliseconds)ms)"
    Write-Host "  Exit Code: $exitCode"
}
