# Process Memory Footprint Analyzer
# Inspects working set and private bytes of top consumer processes.

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Top 10 Memory Consuming Processes:" -ForegroundColor Cyan
Write-Host "----------------------------------" -ForegroundColor Gray

Get-Process | Sort-Object -Property WorkingSet64 -Descending | Select-Object -First 10 | ForEach-Object {
    $wsMb = [math]::Round($_.WorkingSet64 / 1MB, 2)
    $pmMb = [math]::Round($_.PM / 1MB, 2)
    Write-Host ("{0,-25} PID: {1,-7} WS: {2,8} MB   Private: {3,8} MB" -f $_.Name, $_.Id, $wsMb, $pmMb)
}
