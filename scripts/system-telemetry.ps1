<#
.SYNOPSIS
    Captures a real-time system hardware telemetry snapshot.
#>

Write-Host "Hardware Resource Snapshot" -ForegroundColor Cyan
Write-Host "==========================" -ForegroundColor DarkGray

# CPU Utilization
$cpu = (Get-Counter '\Processor(_Total)\% Processor Time' -SampleInterval 1 -MaxSamples 1).CounterSamples.CookedValue
Write-Host ("  CPU Load       : {0:N1}%" -f $cpu)

# RAM Usage
$os = Get-CimInstance Win32_OperatingSystem
$totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeRam  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$usedRam  = [math]::Round($totalRam - $freeRam, 2)
$ramPct   = [math]::Round(($usedRam / $totalRam) * 100, 1)
Write-Host "  RAM Usage      : ${usedRam} GB / ${totalRam} GB (${ramPct}%)"

# Top 5 Memory Consuming Processes
Write-Host "`nTop Processes by Working Set:" -ForegroundColor Yellow
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 | 
    ForEach-Object {
        $mb = [math]::Round($_.WorkingSet64 / 1MB, 1)
        Write-Host ("    [{0,-6}] {1,-24} : {2,7} MB" -f $_.Id, $_.ProcessName, $mb)
    }

Write-Host "==========================" -ForegroundColor DarkGray
