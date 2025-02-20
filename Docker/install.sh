#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Log file
LOG_FILE="/tmp/install_docker.log"

# Function to check the exit status of each command
check_status() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}Error occurred. Check the log file: $LOG_FILE${NC}"
    exit 1
  fi
}

echo -e "${GREEN}Starting Docker installation script...${NC}" | tee -a "$LOG_FILE"

# Step 1: Remove Podman
echo -e "${GREEN}Removing Podman...${NC}" | tee -a "$LOG_FILE"
sudo yum remove -y podman &>> "$LOG_FILE"
check_status

# Step 2: Install Required Packages
echo -e "${GREEN}Installing required packages...${NC}" | tee -a "$LOG_FILE"
sudo yum install -y yum-utils &>> "$LOG_FILE"
check_status

# Step 3: Add Docker Repository
echo -e "${GREEN}Adding Docker repository...${NC}" | tee -a "$LOG_FILE"
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo &>> "$LOG_FILE"
check_status

# Step 4: Install Docker
echo -e "${GREEN}Installing Docker...${NC}" | tee -a "$LOG_FILE"
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>> "$LOG_FILE"
check_status

# Step 5: Start and Enable Docker
echo -e "${GREEN}Starting Docker service...${NC}" | tee -a "$LOG_FILE"
sudo systemctl start docker &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Enabling Docker to start on boot...${NC}" | tee -a "$LOG_FILE"
sudo systemctl enable docker &>> "$LOG_FILE"
check_status

# Step 6: Verify Docker Installation
echo -e "${GREEN}Verifying Docker installation...${NC}" | tee -a "$LOG_FILE"
docker --version &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Running Docker test...${NC}" | tee -a "$LOG_FILE"
sudo docker run hello-world &>> "$LOG_FILE"
check_status

echo -e "${GREEN}Docker installation completed successfully!${NC}" | tee -a "$LOG_FILE"
