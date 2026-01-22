#!/bin/bash

# monitor_system.sh
# This script demonstrates loops, conditionals, and system monitoring
# Author: DevOps Intern
# Date: $(date)

echo "========================================="
echo "     SYSTEM MONITOR WITH LOOPS"
echo "========================================="
echo ""

# Function to check service status
check_service() {
    if systemctl is-active --quiet "$1"; then
        echo "✓ $1 is RUNNING"
        return 0
    else
        echo "✗ $1 is STOPPED"
        return 1
    fi
}

# Array of services to check
services=("sshd" "cron" "docker" "nginx" "apache2")

echo "1. SERVICE STATUS CHECK:"
echo "------------------------"

# Using for loop to iterate through services
for service in "${services[@]}"; do
    check_service "$service"
done
echo ""

# Check disk usage with conditional thresholds
echo "2. DISK USAGE MONITOR:"
echo "------------------------"

# Using while loop to read disk info
df -h | grep '^/dev/' | while read -r line; do
    filesystem=$(echo $line | awk '{print $1}')
    size=$(echo $line | awk '{print $2}')
    used=$(echo $line | awk '{print $3}')
    avail=$(echo $line | awk '{print $4}')
    use_percent=$(echo $line | awk '{print $5}' | tr -d '%')
    mount=$(echo $line | awk '{print $6}')
    
    # Conditional statements for disk usage
    if [ $use_percent -ge 90 ]; then
        status="CRITICAL ⚠"
    elif [ $use_percent -ge 80 ]; then
        status="WARNING ⚠"
    else
        status="OK ✓"
    fi
    
    echo "  $filesystem ($mount): $used/$size used - $use_percent% - $status"
done
echo ""

# Check memory usage
echo "3. MEMORY USAGE:"
echo "------------------------"
free -h | head -2
echo ""

# Process monitoring with loops
echo "4. TOP 5 MEMORY CONSUMING PROCESSES:"
echo "------------------------"
echo "  PID    %MEM    COMMAND"
ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "  %-6s %-7s %s\n", $2, $4, $11}'
echo ""

# Demonstration of different loop types
echo "5. LOOP DEMONSTRATIONS:"
echo "------------------------"

# For loop with range
echo "  Counting with for loop:"
for i in {1..5}; do
    echo -n "  $i "
done
echo ""
echo ""

# While loop
echo "  Countdown with while loop:"
count=5
while [ $count -gt 0 ]; do
    echo "  T-minus $count..."
    sleep 0.2
    count=$((count - 1))
done
echo "  Liftoff! 🚀"
echo ""

echo "Monitoring completed at: $(date)"
echo "========================================="
