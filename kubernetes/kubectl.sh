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
info "Starting kubectl installation for x86_64 architecture..."

# Step 1: Download kubectl for x86_64
DOWNLOAD_URL="https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl"
info "Downloading kubectl from $DOWNLOAD_URL..."
curl -O $DOWNLOAD_URL
if [[ $? -ne 0 ]]; then
    error "Failed to download kubectl. Please check your internet connection."
else
    success "kubectl downloaded successfully."
fi

# Step 2: Make the binary executable
info "Making kubectl executable..."
chmod +x ./kubectl
if [[ $? -ne 0 ]]; then
    error "Failed to make kubectl executable. Please check file permissions."
else
    success "kubectl is now executable."
fi

# Step 3: Move the binary to /usr/local/bin
info "Moving kubectl to /usr/local/bin..."
sudo mv ./kubectl /usr/local/bin/
if [[ $? -ne 0 ]]; then
    error "Failed to move kubectl to /usr/local/bin. Please check permissions."
else
    success "kubectl moved to /usr/local/bin successfully."
fi

# Step 4: Verify the installation
info "Verifying kubectl installation..."
kubectl version --client
if [[ $? -ne 0 ]]; then
    error "kubectl installation failed. The binary might not be installed correctly."
else
    success "kubectl installed and verified successfully!"
fi

info "kubectl installation script completed."
