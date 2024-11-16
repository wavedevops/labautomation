#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No color

# Function to print success message
success() {
echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function to print error message
error() {
echo -e "${RED}[ERROR]${NC} $1"
exit 1
}

# Function to print info message
info() {
echo -e "${YELLOW}[INFO]${NC} $1"
}

# Start of the script
info "Starting eksctl installation..."

# Step 1: Download eksctl tar.gz
info "Downloading eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" -o /tmp/eksctl.tar.gz
if [[ $? -ne 0 ]]; then
error "Failed to download eksctl. Please check your internet connection."
else
success "eksctl downloaded successfully."
fi

# Step 2: Extract the tarball
info "Extracting eksctl..."
tar -xzf /tmp/eksctl.tar.gz -C /tmp
if [[ $? -ne 0 ]]; then
error "Failed to extract eksctl. Please check the tarball file."
else
success "eksctl extracted successfully."
fi

# Step 3: Move the binary to /usr/local/bin
info "Moving eksctl to /usr/local/bin..."
sudo mv /tmp/eksctl /usr/local/bin/
if [[ $? -ne 0 ]]; then
error "Failed to move eksctl to /usr/local/bin. Please check permissions."
else
success "eksctl moved to /usr/local/bin successfully."
fi

# Step 4: Verify the installation
info "Verifying eksctl installation..."
eksctl version
if [[ $? -ne 0 ]]; then
error "eksctl installation failed. The binary might not be installed correctly."
else
success "eksctl installed and verified successfully!"
fi

# Clean up
info "Cleaning up temporary files..."
rm -f /tmp/eksctl.tar.gz
success "Cleanup completed."

info "eksctl installation script completed."
