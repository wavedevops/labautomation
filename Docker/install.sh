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
    echo -e "${RED}Error occurred. Exiting.${NC}" | tee -a "$LOG_FILE"
    exit 1
  fi
}

# Start logging
echo "Starting Docker installation script..." 

# Install yum-utils
echo -e "${GREEN}Installing yum-utils...${NC}" 
yum install -y yum-utils &>> "$LOG_FILE"
check_status

# Add Docker repository
echo -e "${GREEN}Adding Docker repository...${NC}"
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo &>> "$LOG_FILE"
check_status

# Install Docker and related components
echo -e "${GREEN}Installing Docker and components...${NC}"
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>> "$LOG_FILE"
check_status

# Start Docker service
echo -e "${GREEN}Starting Docker service...${NC}"
systemctl start docker &>> "$LOG_FILE"
check_status

# Enable Docker to start on boot
echo -e "${GREEN}Enabling Docker to start on boot...${NC}"
systemctl enable docker &>> "$LOG_FILE"
check_status

# Add ec2-user to Docker group
echo -e "${GREEN}Adding ec2-user to Docker group...${NC}"
usermod -aG docker ec2-user &>> "$LOG_FILE"
check_status

# Logout and login message
echo -e "${GREEN}Logout and Login again to apply group changes...${NC}"

echo -e "${GREEN}Docker installation and setup completed successfully!${NC}"