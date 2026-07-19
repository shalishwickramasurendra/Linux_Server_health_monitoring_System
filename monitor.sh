#!/bin/bash
#Git Flow test
echo "GitFlow workflow test branch: develop---two"


#disk space
Disk_Usage=$(df -h | grep "/dev/sdd" | awk '{print $5}' | sed "s/%//")
now=$(date "+%Y-%m-%d %H:%M:%S")
log="/home/shalish/project1/monitor/server_health.log"
echo "------Disk Usage-----" >>$log
#Error handeling
if [ -z "$Disk_Usage" ]; then
    echo "[$now] [CRITICAL] Failed to retrieve Disk Usage! Exiting..." >> $log
    exit 1
fi
if [ $Disk_Usage -gt 80 ];
then 
echo "[$now] Disk Status: [RISK] Usage is - $Disk_Usage%" >>$log
else
echo  "[$now] Disk Status: [OK] Usage is - $Disk_Usage%" >>$log
fi

#RAM USAGE
Total=$(free -m |  grep "Mem:" | awk '{print $2}')
Used=$(free -m | grep "Mem:" | awk '{print $3}')
Ram=$(((Used*100)/Total))

echo "------Ram Usage-------" >>$log
#Error handeling
if [ -z "$Total" ] || [ -z "$Used" ]; then
    echo "[$now] [CRITICAL] Failed to retrieve RAM metrics! Exiting..." >> $log
    exit 1
fi
if [ $Ram -gt 85 ];
then
echo "[$now] Ram Status: [RISK] Usage is - $Ram %" >>$log
else
echo "[$now] Ram Status: [OK] usage is - $Ram %" >>$log
fi

echo "----Cron status-----" >>$log

cron=$(systemctl status cron | grep "active" | awk '{print$2}')
if [ "$cron" == "active" ];
then 
echo "[$now] Cron Status: [OK] Active and Running " >>$log
else
echo "[$now] Cron Status: [OK] Active and Running " >>$log
fi

echo "-----CPU Usage-------" >>$log
cpu_value=$(top -bn1 | grep "%Cpu(s)" | awk '{print$2}')
cpu_valuef=$(printf "%.0f" "$cpu_value")
#Error handeling
if [ -z "$cpu_value" ]; then
    echo "[$now] [CRITICAL] Failed to retrieve CPU usage! Exiting..." >> $log
    exit 1
fi
if [ $cpu_valuef -gt 80 ];
then
echo "[$now] CPU Status: [RISK] Usage is - $cpu_valuef %" >>$log
else
echo "[$now] CPU Status: [OK] Usage is - $cpu_valuef %" >>$log
fi

echo "-----Top 5 RAM Consuming Processes-----" >> $log
ps -eo pid,cmd,%mem --sort=-%mem | head -n 6 >> $log

echo "[$now] ------------------------------------------------"
