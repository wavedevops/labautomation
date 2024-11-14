#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print error and exit
error_exit() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Check the partitions
echo -e "${GREEN}[INFO] Checking partitions...${NC}"
lsblk || error_exit "Failed to list partitions"

# Directly extend the logical volumes if no partition resize is possible
echo -e "${GREEN}[INFO] Extending logical volumes...${NC}"
sudo lvextend -l +50%FREE /dev/mapper/RootVG-rootVol || error_exit "Failed to extend root logical volume"
sudo lvextend -l +50%FREE /dev/mapper/RootVG-varVol || error_exit "Failed to extend var logical volume"

# Resize the root filesystem
echo -e "${GREEN}[INFO] Resizing root filesystem...${NC}"
sudo xfs_growfs / || error_exit "Failed to resize root filesystem"

# Resize the /var filesystem
echo -e "${GREEN}[INFO] Resizing /var filesystem...${NC}"
sudo xfs_growfs /var || error_exit "Failed to resize /var filesystem"

echo -e "${GREEN}[INFO] Resize completed successfully!${NC}"
