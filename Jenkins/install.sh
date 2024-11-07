#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

LOGFILE=/tmp/jenkins_output.log
# Function to check the exit status of each command
check_status() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}Error occurred. Exiting.${NC}"
    exit 1
  fi
}

# Download the Jenkins repo configuration
echo -e "${GREEN}Downloading Jenkins repo configuration...${NC}"
curl -Lo /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOGFILE
check_status

# Set up the Jenkins repository configuration
echo -e "${GREEN}Setting up Jenkins repository configuration...${NC}"
cat <<EOF > /etc/yum.repos.d/jenkins.repo
[jenkins]
name=Jenkins-stable
baseurl=http://pkg.jenkins.io/redhat-stable
gpgcheck=1
EOF
check_status

# Import the GPG key for Jenkins
echo -e "${GREEN}Importing Jenkins GPG key...${NC}"
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOGFILE
check_status

# Install required packages: fontconfig and Java 17
echo -e "${GREEN}Installing required packages...${NC}"
yum install -y fontconfig java-17-openjdk   &>>$LOGFILE
check_status

# Install Jenkins
echo -e "${GREEN}Installing Jenkins...${NC}"
yum install -y jenkins  &>>$LOGFILE
check_status

# Reload systemd to recognize the Jenkins service
echo -e "${GREEN}Reloading systemd daemon...${NC}"
systemctl daemon-reload   &>>$LOGFILE
check_status

# Enable Jenkins to start at boot
echo -e "${GREEN}Enabling Jenkins service...${NC}"
systemctl enable jenkins  &>>$LOGFILE
check_status

# Start Jenkins service
echo -e "${GREEN}Starting Jenkins service...${NC}"
systemctl start jenkins  &>>$LOGFILE
check_status

# Check Jenkins service status
echo -e "${GREEN}Checking Jenkins service status...${NC}"
systemctl status jenkins | grep "Active:"

echo -e "${GREEN} Jenkins service status...${NC}"
systemctl status jenkins

echo -e "${GREEN}Jenkins installation and setup completed successfully!${NC}"