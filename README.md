

# 🚀 DevOps Shell Scripts Collection

![Shell Scripting](https://img.shields.io/badge/Shell-Bash-green)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-lightgrey)
![License](https://img.shields.io/badge/License-MIT-blue)
![GitHub Stars](https://img.shields.io/github/stars/yourusername/devops-shell-scripts?style=social)
![Last Commit](https://img.shields.io/github/last-commit/yourusername/devops-shell-scripts)

A comprehensive collection of production-ready shell scripts for automating DevOps tasks, system administration, and infrastructure management.

## 📋 Table of Contents
- [Features](#-features)
- [Scripts Overview](#-scripts-overview)
- [Installation](#-installation)
- [Usage](#-usage)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

## ✨ Features

✅ **Automated System Monitoring** - Real-time system health checks  
✅ **Log Management** - Automated cleanup and rotation  
✅ **Backup Solutions** - Scheduled backups with retention policies  
✅ **Resource Optimization** - Memory and disk space management  
✅ **Security Checks** - Basic security auditing  
✅ **Cross-Platform** - Compatible with most Linux distributions  
✅ **Easy Configuration** - Simple variable-based customization  
✅ **Error Handling** - Robust error checking and logging  

## 📁 Scripts Overview

### 1. 🖥️ `system_info.sh`
Comprehensive system information gathering tool that displays:
- Hardware specifications (CPU, Memory, Disk)
- Operating system details
- Network configuration
- Running processes
- System load and uptime
- Resource utilization statistics

### 2. 🧹 `log_cleanup.sh`
Intelligent log management system featuring:
- Automated log rotation
- Compression of old logs
- Configurable retention periods
- Disk space monitoring
- Backup before deletion

### 3. 💾 `backup_script.sh`
Reliable backup solution with:
- Incremental and full backup options
- Compression and encryption support
- Backup verification
- Retention policy enforcement
- Email notifications

### 4. 🛡️ `security_check.sh`
Basic security audit tool checking:
- Open ports
- User account security
- SSH configuration
- File permissions
- System updates status

### 5. 📊 `resource_monitor.sh`
Real-time resource monitoring:
- CPU usage alerts
- Memory consumption tracking
- Disk I/O monitoring
- Network bandwidth usage
- Process resource usage

## 🚀 Installation

### Prerequisites
- Linux/Unix-based system
- Bash shell (version 4.0+)
- Root/sudo access (for some scripts)
- Basic terminal knowledge

Configure (Optional):

# Open any script in a text editor
vim system_info.sh

# Modify configuration variables at the top of each script
LOG_DIR="/var/log"
BACKUP_DIR="/backups"
RETENTION_DAYS=30

📖 Usage:
Basic Usage
# Display system information
./system_info.sh

# Clean up logs (may require sudo)
sudo ./log_cleanup.sh

# Create a backup
./backup_script.sh

# Monitor resources
./resource_monitor.sh

# Run security check
sudo ./security_check.sh

Run All Scripts:-
# Create a master script runner
cat > run_all.sh << 'EOF'
#!/bin/bash
echo "Starting DevOps Automation Suite..."
echo "==================================="

echo "[1/4] Gathering system information..."
./system_info.sh > /tmp/system_info_$(date +%s).log

echo "[2/4] Cleaning up logs..."
sudo ./log_cleanup.sh

echo "[3/4] Creating backup..."
./backup_script.sh

echo "[4/4] Security check..."
sudo ./security_check.sh

echo "==================================="
echo "All tasks completed successfully!"
EOF

chmod +x run_all.sh
./run_all.sh

🏗️ Project Structure:-
devops-shell-scripts/
├── 📄 README.md                 # This documentation
├── 📄 LICENSE                   # MIT License
├── 📄 .gitignore               # Git ignore rules
├── 🖥️ system_info.sh           # System information script
├── 🧹 log_cleanup.sh           # Log management script
├── 💾 backup_script.sh         # Backup automation script
├── 🛡️ security_check.sh        # Security audit script
├── 📊 resource_monitor.sh      # Resource monitoring script
├── 🧪 test.sh                  # Test/validation script
├── 📁 examples/                # Usage examples
│   ├── crontab_examples.txt   # Cron job configurations
│   ├── config_examples/       # Configuration templates
│   └── output_samples/        # Sample script outputs
├── 📁 docs/                    # Detailed documentation
│   ├── installation.md        # Installation guide
│   ├── troubleshooting.md     # Common issues and fixes
│   └── best_practices.md      # Scripting guidelines
└── 📁 screenshots/            # Documentation screenshots
    ├── system_info.png
    ├── backup_script.png
    ├── cron_jobs.png
    └── repo_structure.png
