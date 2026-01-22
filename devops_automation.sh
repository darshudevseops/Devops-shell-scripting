#!/bin/bash

# devops_automation.sh
# Master script for DevOps automation tasks
# Demonstrates parameter handling and script scheduling concepts
# Author: DevOps Intern
# Date: $(date)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Display usage
usage() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  info      - Display system information"
    echo "  clean     - Clean up log files"
    echo "  backup    - Perform backup task"
    echo "  monitor   - Monitor system resources"
    echo "  all       - Run all tasks"
    echo "  help      - Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 info          # Show system info"
    echo "  $0 all           # Run all automation tasks"
}

# Function to run system info
run_info() {
    echo -e "${GREEN}Running System Information Report...${NC}"
    ./system_info.sh
    echo -e "${GREEN}Output saved to system_report_$(date +%Y%m%d).txt${NC}"
    ./system_info.sh > "system_report_$(date +%Y%m%d).txt"
}

# Function to run log cleanup
run_clean() {
    echo -e "${GREEN}Running Log Cleanup...${NC}"
    echo -e "${YELLOW}Note: Using test directory for safety${NC}"
    mkdir -p test_logs
    touch test_logs/test{1..5}.log
    LOG_DIR="test_logs" ./log_cleanup.sh
    ./log_cleanup.sh > "log_cleanup_$(date +%Y%m%d).txt"
}

# Function to run backup
run_backup() {
    echo -e "${GREEN}Running Backup Task...${NC}"
    ./backup_task.sh
    ./backup_task.sh > "backup_report_$(date +%Y%m%d).txt"
}

# Function to run monitoring
run_monitor() {
    echo -e "${GREEN}Running System Monitoring...${NC}"
    ./monitor_system.sh
    ./monitor_system.sh > "monitoring_report_$(date +%Y%m%d).txt"
}

# Main script logic
echo "========================================="
echo "     DEVOPS AUTOMATION MASTER SCRIPT"
echo "========================================="
echo ""

# Check if no arguments provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No option provided${NC}"
    echo ""
    usage
    exit 1
fi

# Handle command line arguments
case "$1" in
    info)
        run_info
        ;;
    clean)
        run_clean
        ;;
    backup)
        run_backup
        ;;
    monitor)
        run_monitor
        ;;
    all)
        echo -e "${GREEN}Running all automation tasks...${NC}"
        echo ""
        run_info
        echo ""
        run_clean
        echo ""
        run_backup
        echo ""
        run_monitor
        ;;
    help)
        usage
        ;;
    *)
        echo -e "${RED}Error: Unknown option '$1'${NC}"
        echo ""
        usage
        exit 1
        ;;
esac

echo ""
echo "========================================="
echo "Automation completed at: $(date)"
echo "========================================="
