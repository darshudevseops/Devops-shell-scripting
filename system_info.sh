#!/bin/bash

# system_info.sh
# This script displays basic system information
# Author: DevOps Intern
# Date: $(date)

echo "========================================="
echo "     SYSTEM INFORMATION REPORT"
echo "========================================="
echo ""

# Using variables to store system information
HOSTNAME=$(hostname)
KERNEL_VERSION=$(uname -r)
OS_NAME=$(grep '^NAME=' /etc/os-release | cut -d'"' -f2)
CPU_MODEL=$(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)
CPU_CORES=$(nproc)
MEMORY_TOTAL=$(free -h | grep Mem | awk '{print $2}')
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')
UPTIME=$(uptime -p)
CURRENT_USER=$(whoami)

# Display system information
echo "1. BASIC INFORMATION:"
echo "   Hostname: $HOSTNAME"
echo "   Kernel Version: $KERNEL_VERSION"
echo "   Operating System: $OS_NAME"
echo "   Current User: $CURRENT_USER"
echo "   System Uptime: $UPTIME"
echo ""

echo "2. HARDWARE INFORMATION:"
echo "   CPU Model: $CPU_MODEL"
echo "   CPU Cores: $CPU_CORES"
echo "   Total Memory: $MEMORY_TOTAL"
echo "   Root Disk Usage: $DISK_USAGE"
echo ""

echo "3. NETWORK INFORMATION:"
echo "   IP Addresses:"
ip -4 addr show | grep inet | awk '{print "   - "$2}' | cut -d'/' -f1
echo ""

echo "4. CURRENT PROCESSES (Top 5 by CPU):"
ps aux --sort=-%cpu | head -6 | awk '{printf "   %-10s %-10s %-10s\n", $11, $2, $3}'
echo ""

echo "Report generated on: $(date)"
echo "========================================="
