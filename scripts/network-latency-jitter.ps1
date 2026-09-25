<#
.SYNOPSIS
    Measures network round-trip latency, packet loss, and jitter dispersion.
.PARAMETER Hostname
    Target remote host or gateway IP address.
.PARAMETER Samples
    Number of ICMP echo requests to send.
#>

[CmdletBinding()]
param(
    [string]$Hostname = "1.1.1.1",
    [int]$Samples = 20
)

Write-Host "Pinging $Hostname with $Samples samples..." -ForegroundColor Cyan

$rtts = @()
for ($i = 1; $i -le $Samples; $i++) {
    $ping = Test-Connection -TargetName $Hostname -Count 1 -ErrorAction SilentlyContinue
    if ($ping) {
        $rtts += $ping.Latency
        Write-Host "Sample $i: $($ping.Latency) ms" -ForegroundColor DarkGray
    } else {
        Write-Host "Sample $i: Request timed out" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 200
}

if ($rtts.Count -eq 0) {
    Write-Error "All ping requests timed out."
    exit 1
}

$stats = $rtts | Measure-Object -Average -Minimum -Maximum

# Calculate jitter (mean absolute consecutive difference)
$jitterSum = 0
for ($j = 1; $j -lt $rtts.Count; $j++) {
    $jitterSum += [Math]::Abs($rtts[$j] - $rtts[$j - 1])
}
$avgJitter = if ($rtts.Count -gt 1) { [Math]::Round($jitterSum / ($rtts.Count - 1), 2) } else { 0 }

Write-Host "`n--- Network Statistics for $Hostname ---" -ForegroundColor Green
Write-Host "Sent: $Samples | Received: $($rtts.Count) | Lost: $($Samples - $rtts.Count) ($([Math]::Round((($Samples - $rtts.Count)/$Samples)*100, 1))% loss)"
Write-Host "Min RTT: $($stats.Minimum) ms | Avg RTT: $([Math]::Round($stats.Average, 2)) ms | Max RTT: $($stats.Maximum) ms"
Write-Host "Mean Jitter: $avgJitter ms" -ForegroundColor Cyan
