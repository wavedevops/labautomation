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

echo -e "${GREEN}Starting Docker uninstallation script...${NC}" | tee -a "$LOG_FILE"

# Step 1: Stop Docker Service
echo -e "${GREEN}Stopping Docker service...${NC}" | tee -a "$LOG_FILE"
sudo systemctl stop docker &>> "$LOG_FILE"
check_status

# Step 2: Disable Docker Service
echo -e "${GREEN}Disabling Docker service...${NC}" | tee -a "$LOG_FILE"
sudo systemctl disable docker &>> "$LOG_FILE"
check_status

# Step 3: Uninstall Docker and Dependencies
echo -e "${GREEN}Removing Docker packages...${NC}" | tee -a "$LOG_FILE"
sudo yum remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>> "$LOG_FILE"
check_status

# Step 4: Remove Docker Files and Configurations
echo -e "${GREEN}Removing Docker files...${NC}" | tee -a "$LOG_FILE"
sudo rm -rf /var/lib/docker /etc/docker &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Removing containerd files...${NC}" | tee -a "$LOG_FILE"
sudo rm -rf /var/lib/containerd &>> "$LOG_FILE"
check_status

# Step 5: Remove Docker Group (Optional)
echo -e "${GREEN}Removing Docker group...${NC}" | tee -a "$LOG_FILE"
sudo groupdel docker &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Docker uninstallation completed successfully!${NC}" | tee -a "$LOG_FILE"
