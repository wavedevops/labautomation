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
info "Starting eksctl removal process..."

# Step 1: Check if eksctl exists in /usr/local/bin
info "Checking if eksctl is installed..."
if [[ -f /usr/local/bin/eksctl ]]; then
    info "Found eksctl binary. Proceeding to remove it..."
    sudo rm -f /usr/local/bin/eksctl
    if [[ $? -ne 0 ]]; then
        error "Failed to remove eksctl. Please check permissions."
    else
        success "eksctl removed successfully."
    fi
else
    success "eksctl is not installed. Nothing to remove."
fi

# Step 2: Check for leftover temporary files
info "Checking for leftover temporary files..."
if [[ -f /tmp/eksctl.tar.gz ]]; then
    rm -f /tmp/eksctl.tar.gz
    if [[ $? -ne 0 ]]; then
        error "Failed to clean up temporary files."
    else
        success "Temporary files cleaned up successfully."
    fi
else
    success "No temporary files found."
fi

info "eksctl removal process completed."
