#!/bin/bash

# Exit on any error
set -e

# Replace 'openonload-8.0.0.1.tgz' with the actual filename if different
OPENONLOAD_TAR_FILE="onload-8.1.0.15.tgz"

# Check if the OpenOnload tar file exists in the current directory
if [ ! -f "$OPENONLOAD_TAR_FILE" ]; then
    echo "Error: The OpenOnload tar file '$OPENONLOAD_TAR_FILE' not found in the current directory."
    exit 1
fi

# Extract the OpenOnload tarball
tar xzf "$OPENONLOAD_TAR_FILE"

# Change to the extracted directory
cd "${OPENONLOAD_TAR_FILE%.tgz}"

# Build the OpenOnload driver
./scripts/onload_build 

# Install the OpenOnload driver
 ./scripts/onload_install 

# Load the OpenOnload kernel module
modprobe onload

# Check if onload module is loaded successfully
if ! lsmod | grep -q onload; then
    echo "Error: Failed to load the OpenOnload kernel module."
    exit 1
fi

echo "OpenOnload version 8 driver has been built and installed successfully."

