#!/bin/bash

# log_cleanup.sh
# This script automates log file cleanup for DevOps tasks
# Author: DevOps Intern
# Date: $(date)

# Configuration variables
LOG_DIR="/var/log"
BACKUP_DIR="/tmp/log_backups"
DAYS_TO_KEEP=7
MAX_LOG_SIZE="10M"

echo "========================================="
echo "     LOG CLEANUP AUTOMATION"
echo "========================================="
echo ""

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

echo "Starting log cleanup process..."
echo "Log directory: $LOG_DIR"
echo "Backup directory: $BACKUP_DIR"
echo "Keeping logs from last $DAYS_TO_KEEP days"
echo ""

# Backup logs older than 1 day
echo "1. BACKING UP OLD LOGS:"
find "$LOG_DIR" -name "*.log" -type f -mtime +1 -exec tar -czf "$BACKUP_DIR/logs_backup_$(date +%Y%m%d_%H%M%S).tar.gz" {} + 2>/dev/null

if [ $? -eq 0 ]; then
    echo "   ✓ Logs backed up successfully"
else
    echo "   ⚠ No logs found for backup or backup failed"
fi
echo ""

# Compress large log files
echo "2. COMPRESSING LARGE LOG FILES:"
find "$LOG_DIR" -name "*.log" -type f -size +$MAX_LOG_SIZE -exec gzip {} \;

if [ $? -eq 0 ]; then
    echo "   ✓ Large logs compressed"
else
    echo "   ⚠ No large log files found"
fi
echo ""

# Remove old log files
echo "3. REMOVING OLD LOG FILES:"
find "$LOG_DIR" -name "*.log" -type f -mtime +$DAYS_TO_KEEP -delete

if [ $? -eq 0 ]; then
    echo "   ✓ Old logs cleaned up"
    echo "   Removed logs older than $DAYS_TO_KEEP days"
else
    echo "   ⚠ No old log files to remove"
fi
echo ""

# Cleanup old backups (older than 30 days)
echo "4. CLEANING UP OLD BACKUPS:"
find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +30 -delete
echo "   Removed backups older than 30 days"
echo ""

echo "Current disk usage in $LOG_DIR:"
du -sh "$LOG_DIR"
echo ""

echo "Log cleanup completed at: $(date)"
echo "========================================="
