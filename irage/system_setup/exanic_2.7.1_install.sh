#!/bin/bash

# Function to display error messages and exit
function error_exit {
    echo "Error: $1"
    exit 1
}

# Check if running with root privileges
if [[ $EUID -ne 0 ]]; then
    error_exit "This script must be run with root privileges."
fi

# Check if necessary tools are installed
if ! command -v wget &>/dev/null; then
    error_exit "wget is not installed. Please install it using 'yum install wget' and try again."
fi

if ! command -v tar &>/dev/null; then
    error_exit "tar is not installed. Please install it using 'yum install tar' and try again."
fi

# Download and install Exanic driver
EXANIC_VERSION="2.7.1"
EXANIC_ARCHIVE="exanic-${EXANIC_VERSION}.tar.gz"
EXANIC_URL="https://exablaze.com/downloads/exanic/exanic-2.7.1.tar.gz"

# Download the Exanic driver package (bypass SSL certificate check)
wget --no-check-certificate "$EXANIC_URL" || error_exit "Failed to download Exanic driver."

# Extract the Exanic driver package
tar -xzf "$EXANIC_ARCHIVE" || error_exit "Failed to extract Exanic driver."

# Change directory to the extracted folder
cd "exanic-${EXANIC_VERSION}" || error_exit "Failed to change directory."

# Install kernel headers and development tools
yum install -y kernel-devel gcc make || error_exit "Failed to install kernel headers and development tools."

# Build and install the Exanic driver module
make || error_exit "Failed to build the Exanic driver."
make install || error_exit "Failed to install the Exanic driver."

# Load the Exanic driver module
modprobe exanic || error_exit "Failed to load the Exanic driver."

# Verify the installation
if lsmod | grep -q "exanic"; then
    echo "Exanic version ${EXANIC_VERSION} installed successfully!"
else
    error_exit "Exanic installation failed."
fi

# Clean up temporary files
#cd ..
#rm -rf "exanic-${EXANIC_VERSION}" "$EXANIC_ARCHIVE"

echo "Exanic version ${EXANIC_VERSION} installation completed."
