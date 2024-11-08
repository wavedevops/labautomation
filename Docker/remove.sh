#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Log file
LOG_FILE="/tmp/remove_docker.log"

# Function to check the exit status of each command
check_status() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}Error occurred. Exiting.${NC}" | tee -a "$LOG_FILE"
    exit 1
  fi
}

# Start logging
echo "Starting Docker removal script..."

# Stop Docker service
echo -e "${GREEN}Stopping Docker service...${NC}"
systemctl stop docker &>> "$LOG_FILE"
check_status

# Disable Docker service
echo -e "${GREEN}Disabling Docker service...${NC}"
systemctl disable docker &>> "$LOG_FILE"
check_status

# Uninstall Docker
echo -e "${GREEN}Uninstalling Docker...${NC}"
yum remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>> "$LOG_FILE"
check_status

# Remove Docker images, containers, and volumes (if you want to keep these, skip this step)
echo -e "${GREEN}Removing Docker images, containers, and volumes...${NC}"
rm -rf /var/lib/docker &>> "$LOG_FILE"
check_status

# Remove Docker group
echo -e "${GREEN}Removing Docker group...${NC}"
groupdel docker &>> "$LOG_FILE"
check_status

# Remove Docker configuration file
echo -e "${GREEN}Removing Docker configuration files...${NC}"
rm -f /etc/yum.repos.d/docker-ce.repo &>> "$LOG_FILE"
check_status

# Reload systemd daemon
echo -e "${GREEN}Reloading systemd daemon...${NC}"
systemctl daemon-reload &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Docker removal completed successfully!${NC}" &>> "$LOG_FILE"
