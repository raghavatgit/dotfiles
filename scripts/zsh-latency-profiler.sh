#!/usr/bin/env bash
# ZSH Startup Latency Profiler
# Measures wall-clock execution time across 10 interactive shell invocations.

set -euo pipefail

runs=10
echo "Measuring interactive shell startup latency (${runs} iterations)..."

total_ms=0
for i in $(seq 1 $runs); do
    ms=$( (TIMEFMT='%E'; time zsh -i -c exit) 2>&1 | awk -F'm|s' '{print ($1 * 60 + $2) * 1000}' )
    total_ms=$(echo "$total_ms + $ms" | bc)
    printf "  Run %2d: %6.1f ms\n" "$i" "$ms"
done

avg=$(echo "scale=2; $total_ms / $runs" | bc)
echo "Average Shell Startup Time: ${avg} ms"
