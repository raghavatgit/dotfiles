<#
.SYNOPSIS
    Profiles memory allocation and Working Set metrics of a target process over time.
#>

param(
    [Parameter(Mandatory=$true)][string]$ProcessName,
    [int]$DurationSeconds = 10
)

Write-Host "Profiling process memory footprint: $ProcessName for ${DurationSeconds}s" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor DarkGray

$target = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
if (-not $target) {
    Write-Host "Process '$ProcessName' not found running." -ForegroundColor Red
    exit 1
}

$peakWorkingSet = 0
$peakPrivateBytes = 0
$sw = [System.Diagnostics.Stopwatch]::StartNew()

while ($sw.Elapsed.TotalSeconds -lt $DurationSeconds) {
    $proc = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($proc) {
        $ws = [math]::Round($proc.WorkingSet64 / 1MB, 2)
        $pb = [math]::Round($proc.PrivateMemorySize64 / 1MB, 2)

        if ($ws -gt $peakWorkingSet) { $peakWorkingSet = $ws }
        if ($pb -gt $peakPrivateBytes) { $peakPrivateBytes = $pb }

        Write-Host "  Time: $([math]::Round($sw.Elapsed.TotalSeconds, 1))s | Working Set: ${ws} MB | Private: ${pb} MB"
    }
    Start-Sleep -Milliseconds 500
}

$sw.Stop()
Write-Host "=================================================================" -ForegroundColor DarkGray
Write-Host "Profiling complete for $ProcessName" -ForegroundColor Green
Write-Host "  Peak Working Set  : $peakWorkingSet MB"
Write-Host "  Peak Private Bytes: $peakPrivateBytes MB"
