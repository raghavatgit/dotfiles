#!/usr/bin/env bash
# Lightweight System Resource Telemetry Analyzer
# Collects CPU, memory, load average, and top resource consumers without third-party dependencies.

set -euo pipefail

echo "=== System Telemetry Report ==="
echo "Date: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo "Uptime: $(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')"

echo ""
echo "--- Memory Utilization ---"
free -h | awk 'NR==1{printf "%-12s %-10s %-10s %-10s\n", $1, $2, $3, $7} NR==2{printf "%-12s %-10s %-10s %-10s\n", $1, $2, $3, $7}'

echo ""
echo "--- Top 5 CPU Consumers ---"
ps aux --sort=-%cpu | awk 'NR<=6{printf "%-8s %-6s %-6s %-20s\n", $1, $2, $3, $11}'

echo ""
echo "--- Top 5 Memory Consumers ---"
ps aux --sort=-%mem | awk 'NR<=6{printf "%-8s %-6s %-6s %-20s\n", $1, $2, $4, $11}'
