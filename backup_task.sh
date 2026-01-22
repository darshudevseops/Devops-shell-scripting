#!/bin/bash

# backup_task.sh
# This script automates backup tasks with rotation
# Author: DevOps Intern
# Date: $(date)

# Configuration
SOURCE_DIR="$HOME/important_files"
BACKUP_DIR="/tmp/backups"
MAX_BACKUPS=5
BACKUP_PREFIX="backup_$(date +%Y%m%d)"

echo "========================================="
echo "     BACKUP AUTOMATION SCRIPT"
echo "========================================="
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Creating sample source directory with test files..."
    mkdir -p "$SOURCE_DIR"
    
    # Create some sample files
    for i in {1..5}; do
        echo "This is sample file $i" > "$SOURCE_DIR/file$i.txt"
    done
    echo "Created 5 sample files in $SOURCE_DIR"
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "Source Directory: $SOURCE_DIR"
echo "Backup Directory: $BACKUP_DIR"
echo ""

# Create backup
echo "1. CREATING NEW BACKUP:"
BACKUP_FILE="$BACKUP_DIR/${BACKUP_PREFIX}.tar.gz"
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    echo "   ✓ Backup created successfully: $(basename "$BACKUP_FILE")"
    echo "   Size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo "   ✗ Backup failed!"
    exit 1
fi
echo ""

# List all backups
echo "2. CURRENT BACKUPS:"
backup_count=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
if [ $backup_count -gt 0 ]; then
    ls -lh "$BACKUP_DIR"/*.tar.gz
    echo "   Total backups: $backup_count"
else
    echo "   No backups found"
fi
echo ""

# Backup rotation logic
echo "3. BACKUP ROTATION:"
if [ $backup_count -gt $MAX_BACKUPS ]; then
    echo "   Maximum backups ($MAX_BACKUPS) exceeded"
    
    # Count how many to delete
    to_delete=$((backup_count - MAX_BACKUPS))
    echo "   Removing $to_delete old backup(s)..."
    
    # Delete oldest backups
    ls -t "$BACKUP_DIR"/*.tar.gz | tail -$to_delete | while read old_backup; do
        echo "   Deleting: $(basename "$old_backup")"
        rm "$old_backup"
    done
    echo "   ✓ Backup rotation completed"
else
    echo "   ✓ Within backup limit ($backup_count/$MAX_BACKUPS)"
fi
echo ""

echo "Backup task completed at: $(date)"
echo "========================================="
