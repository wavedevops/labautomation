# #!/bin/bash

# # Define color codes
# GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
# RED='\033[0;31m'
# NC='\033[0m' # No Color

# # Function to print messages with color
# print_message() {
#     COLOR=$1
#     MESSAGE=$2
#     echo -e "${COLOR}${MESSAGE}${NC}"
# }

# # Function to handle errors and exit
# check_error() {
#     if [ $? -ne 0 ]; then
#         print_message $RED "An error occurred. Exiting."
#         exit 1
#     fi
# }

# # Check if Minikube is installed, install if not
# print_message $YELLOW "Checking for Minikube..."
# type minikube &>/dev/null
# if [ $? -ne 0 ]; then
#     print_message $YELLOW "Minikube not found. Installing Minikube..."
#     sudo dnf install -y https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
#     check_error
# else
#     print_message $GREEN "Minikube is already installed."
# fi

# # Check if Docker is installed, install if not
# print_message $YELLOW "Checking for Docker..."
# type docker &>/dev/null
# if [ $? -ne 0 ]; then
#     print_message $YELLOW "Docker not found. Installing Docker..."
#     sudo dnf install -y docker
#     check_error
#     sudo systemctl start docker
#     sudo systemctl enable docker
# else
#     print_message $GREEN "Docker is already installed."
# fi

# # Set sysctl configuration
# print_message $YELLOW "Setting sysctl fs.protected_regular to 0..."
# sudo sysctl -w fs.protected_regular=0
# check_error

# # Download and install kubectl
# print_message $YELLOW "Installing kubectl..."
# curl -L -o /bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# check_error
# chmod +x /bin/kubectl
# check_error
# print_message $GREEN "kubectl installed successfully."

# # Start Minikube
# print_message $YELLOW "Running the following command - minikube start --force"
# minikube start --force
# check_error

# print_message $GREEN "Minikube started successfully!"

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

# Check if Minikube is installed, install if not
print_message $YELLOW "Checking for Minikube..."
type minikube &>/dev/null
if [ $? -ne 0 ]; then
    print_message $YELLOW "Minikube not found. Installing Minikube..."
    sudo dnf install -y https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
    check_error
else
    print_message $GREEN "Minikube is already installed."
fi

# Check if Docker is installed, install if not
print_message $YELLOW "Checking for Docker..."
type docker &>/dev/null
if [ $? -ne 0 ]; then
    print_message $YELLOW "Docker not found. Installing Docker..."
    sudo dnf install -y docker
    check_error
    sudo systemctl start docker
    sudo systemctl enable docker
else
    print_message $GREEN "Docker is already installed."
fi

# Set sysctl configuration
print_message $YELLOW "Setting sysctl fs.protected_regular to 0..."
sudo sysctl -w fs.protected_regular=0
check_error

# Download and install kubectl
print_message $YELLOW "Installing kubectl..."
curl -L -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
check_error
sudo chmod +x /usr/local/bin/kubectl
check_error
print_message $GREEN "kubectl installed successfully."

# Start Minikube
print_message $YELLOW "Running the following command - minikube start --force"
minikube start --force
check_error

print_message $GREEN "Minikube started successfully!"
