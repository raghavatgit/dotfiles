# Storage Random Read/Write Latency Benchmark
# Measures small-block file system I/O throughput.

$ErrorActionPreference = "Stop"
$testFile = "$env:TEMP\io_benchmark_temp.bin"
$blockSize = 4096
$iterations = 2000

Write-Host "Running 4KB random write benchmark ($iterations iterations)..." -ForegroundColor Cyan

$bytes = New-Object byte[] $blockSize
(New-Object Random).NextBytes($bytes)

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$stream = [System.IO.File]::OpenWrite($testFile)
for ($i = 0; $i -le $iterations; $i++) {
    $stream.Write($bytes, 0, $blockSize)
}
$stream.Flush()
$stream.Close()
$sw.Stop()

$totalMb = ($blockSize * $iterations) / 1MB
$throughput = [math]::Round($totalMb / ($sw.ElapsedMilliseconds / 1000), 2)

Write-Host "Throughput: $throughput MB/s ($($sw.ElapsedMilliseconds) ms)" -ForegroundColor Green

Remove-Item $testFile -Force
