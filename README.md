# Linux Server Health Monitoring System

An automated, hardened Linux server health monitoring and management system using Bash scripting.

## Features
- **Resource Telemetry:** Real-time logging of CPU, RAM, and Disk utilization.
- **Process Auditing:** Captures top 5 RAM consuming processes.
- **Service Monitoring:** Audits the availability of essential background services (Cron).
- **Error Handling:** Implemented strict input/output verification using Bash exit codes.
- **Security Hardening:** Restricted file permissions (chmod 700/600) and configured passwordless SSH key authentication.
