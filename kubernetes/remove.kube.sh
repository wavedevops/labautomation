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
info "Starting kubectl removal process..."

# Step 1: Check if kubectl exists in /usr/local/bin
info "Checking if kubectl is installed..."
if [[ -f /usr/local/bin/kubectl ]]; then
    info "Found kubectl binary. Proceeding to remove it..."
    sudo rm -f /usr/local/bin/kubectl
    if [[ $? -ne 0 ]]; then
        error "Failed to remove kubectl. Please check permissions."
    else
        success "kubectl removed successfully."
    fi
else
    success "kubectl is not installed. Nothing to remove."
fi

# Step 2: Check for leftover temporary files
info "Checking for leftover temporary files..."
if [[ -f ./kubectl ]]; then
    rm -f ./kubectl
    if [[ $? -ne 0 ]]; then
        error "Failed to remove leftover kubectl file."
    else
        success "Leftover kubectl file removed successfully."
    fi
else
    success "No leftover kubectl files found."
fi

info "kubectl removal process completed."
