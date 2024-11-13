#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print messages with color
print_message() {
    COLOR=$1
    MESSAGE=$2
    echo -e "${COLOR}${MESSAGE}${NC}"
}

# Function to handle errors and exit
check_error() {
    if [ $? -ne 0 ]; then
        print_message $RED "An error occurred. Exiting."
        exit 1
    fi
}

# Stop Minikube if running
if command -v minikube &> /dev/null; then
    print_message $YELLOW "Stopping Minikube..."
    minikube stop
    check_error
else
    print_message $RED "Minikube is not installed, skipping stop step."
fi

# Remove Minikube
if command -v minikube &> /dev/null; then
    print_message $YELLOW "Removing Minikube..."
    sudo rpm -e minikube
    check_error
    print_message $YELLOW "Removing Minikube data..."
    sudo rm -rf ~/.minikube
    check_error
else
    print_message $RED "Minikube is not installed, skipping removal."
fi

# Remove Docker
if command -v docker &> /dev/null; then
    print_message $YELLOW "Removing Docker..."
    sudo dnf remove -y docker-ce docker-ce-cli containerd.io
    check_error
    print_message $YELLOW "Removing Docker data directories..."
    sudo rm -rf /var/lib/docker /var/lib/containerd
    check_error
else
    print_message $RED "Docker is not installed, skipping removal."
fi

# Remove kubectl
if command -v kubectl &> /dev/null; then
    print_message $YELLOW "Removing kubectl..."
    sudo rm -f /bin/kubectl
    check_error
else
    print_message $RED "kubectl is not installed, skipping removal."
fi

# Clean up Docker repository
if [ -f /etc/yum.repos.d/docker-ce.repo ]; then
    print_message $YELLOW "Removing Docker repository..."
    sudo rm -f /etc/yum.repos.d/docker-ce.repo
    check_error
else
    print_message $RED "Docker repository not found, skipping removal."
fi

print_message $GREEN "Uninstallation complete! Minikube, Docker, and kubectl have been removed."

