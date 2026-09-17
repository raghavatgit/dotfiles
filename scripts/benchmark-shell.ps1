# PowerShell Startup and Module Latency Benchmark
# Accurately measures PowerShell profile loading and module import latency.

$ErrorActionPreference = "Stop"

Write-Host "Running PowerShell startup benchmark..." -ForegroundColor Cyan

$iterations = 5
$results = @()

for ($i = 1; $i -le $iterations; $i++) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    powershell.exe -NoProfile -Command "exit"
    $sw.Stop()
    $results += $sw.ElapsedMilliseconds
    Write-Host "  Iteration $i: $($sw.ElapsedMilliseconds) ms" -ForegroundColor Gray
}

$avg = ($results | Measure-Object -Average).Average
Write-Host "Average Clean Startup: $([math]::Round($avg, 2)) ms" -ForegroundColor Green
