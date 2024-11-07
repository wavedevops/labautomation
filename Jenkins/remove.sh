#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Log file
LOGFILE="/tmp/remove_jenkins.log"

# Function to check the exit status of each command
check_status() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}Error occurred. Exiting.${NC}"
    exit 1
  fi
}

# Start logging
echo "Starting Jenkins removal script..."

# Stop Jenkins service
echo -e "${GREEN}Stopping Jenkins service...${NC}"
systemctl stop jenkins &>>$LOGFILE
check_status

# Disable Jenkins service
echo -e "${GREEN}Disabling Jenkins service...${NC}"
systemctl disable jenkins &>>$LOGFILE
check_status

# Uninstall Jenkins
echo -e "${GREEN}Uninstalling Jenkins...${NC}"
yum remove -y jenkins &>>$LOGFILE
check_status

# Remove Java if it’s no longer needed
echo -e "${GREEN}Removing Java...${NC}"
yum remove -y java-17-openjdk &>>$LOGFILE
check_status

# Remove Jenkins repository file
echo -e "${GREEN}Removing Jenkins repository file...${NC}"
rm -f /etc/yum.repos.d/jenkins.repo &>>$LOGFILE
check_status

# Remove Jenkins directories
echo -e "${GREEN}Removing Jenkins directories...${NC}"
rm -rf /var/lib/jenkins /var/log/jenkins /var/cache/jenkins &>>$LOGFILE
check_status

# Reload systemd daemon
echo -e "${GREEN}Reloading systemd daemon...${NC}"
systemctl daemon-reload
check_status

echo -e "${GREEN}Jenkins removal completed successfully!${NC}"
