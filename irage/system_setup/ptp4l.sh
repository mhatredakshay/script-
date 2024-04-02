#!/bin/bash

# Function to install LinuxPTP
install_linuxptp() {
    sudo yum install -y linuxptp
}

# Function to modify /etc/sysconfig/ptp4l file
modify_ptp4l_config() {
    # Delete content in /etc/sysconfig/ptp4l
    sudo echo -n "" > /etc/sysconfig/ptp4l

    # Add OPTIONS="-f /etc/ptp4l.conf -i eth2 -s" line to /etc/sysconfig/ptp4l
    echo 'OPTIONS="-f /etc/ptp4l.conf -i eth2 -s"' | sudo tee -a /etc/sysconfig/ptp4l
}

# Main script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Installing LinuxPTP..."
install_linuxptp

echo "Modifying /etc/sysconfig/ptp4l..."
modify_ptp4l_config

echo "LinuxPTP installation and configuration completed."
