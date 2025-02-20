#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Log file
LOG_FILE="/tmp/uninstall_docker.log"

# Function to check the exit status of each command
check_status() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}Error occurred. Check the log file: $LOG_FILE${NC}"
    exit 1
  fi
}

echo -e "${GREEN}Starting complete Docker uninstallation script...${NC}" | tee -a "$LOG_FILE"

# Step 1: Stop and disable Docker services
echo -e "${GREEN}Stopping and disabling Docker service...${NC}" | tee -a "$LOG_FILE"
sudo systemctl stop docker containerd &>> "$LOG_FILE"
sudo systemctl disable docker containerd &>> "$LOG_FILE"
sudo systemctl reset-failed docker containerd &>> "$LOG_FILE"
check_status

# Step 2: Uninstall Docker and all dependencies
echo -e "${GREEN}Removing all Docker packages and dependencies...${NC}" | tee -a "$LOG_FILE"
sudo yum remove -y docker* containerd* podman* &>> "$LOG_FILE"
check_status

# Step 3: Remove Docker repository
echo -e "${GREEN}Removing Docker repository from YUM...${NC}" | tee -a "$LOG_FILE"
sudo rm -f /etc/yum.repos.d/docker-ce.repo &>> "$LOG_FILE"
check_status

# Step 4: Remove all Docker-related files and configurations
echo -e "${GREEN}Deleting Docker files and configurations...${NC}" | tee -a "$LOG_FILE"
sudo rm -rf /var/lib/docker /etc/docker &>> "$LOG_FILE"
sudo rm -rf /var/lib/containerd /var/lib/containers &>> "$LOG_FILE"
sudo rm -rf /var/run/docker.sock &>> "$LOG_FILE"
sudo rm -rf ~/.docker &>> "$LOG_FILE"
check_status

# Step 5: Remove Docker group (if exists)
echo -e "${GREEN}Removing Docker group...${NC}" | tee -a "$LOG_FILE"
sudo groupdel docker &>> "$LOG_FILE"
check_status

# Step 6: Clean up remaining Docker-related files and dependencies
echo -e "${GREEN}Cleaning up YUM cache and unused dependencies...${NC}" | tee -a "$LOG_FILE"
sudo yum autoremove -y &>> "$LOG_FILE"
sudo yum clean all &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Docker and all related files have been completely removed!${NC}" | tee -a "$LOG_FILE"
