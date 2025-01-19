#!/bin/bash

# Define the log file
LOG_FILE="/var/log/system_monitor.log"

# Function to monitor CPU usage
check_cpu() {
    echo "CPU Usage:" >> $LOG_FILE
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Load: " $2 "%"}' >> $LOG_FILE
    echo "" >> $LOG_FILE
}

# Function to monitor memory usage
check_memory() {
    echo "Memory Usage:" >> $LOG_FILE
    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' >> $LOG_FILE
    echo "" >> $LOG_FILE
}

# Function to monitor disk usage
check_disk() {
    echo "Disk Usage:" >> $LOG_FILE
    df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}' >> $LOG_FILE
    echo "" >> $LOG_FILE
}

# Function to monitor network activity
check_network() {
    echo "Network Activity:" >> $LOG_FILE
    ifconfig eth0 | grep 'RX packets' >> $LOG_FILE
    ifconfig eth0 | grep 'TX packets' >> $LOG_FILE
    echo "" >> $LOG_FILE
}

# Function to log the current system status
log_system_status() {
    echo "------------------------------" >> $LOG_FILE
    echo "Date: $(date)" >> $LOG_FILE
    echo "------------------------------" >> $LOG_FILE
    
    check_cpu
    check_memory
    check_disk
    check_network
    
    echo "System monitoring logged in $LOG_FILE"
}

# Run the function
log_system_status
