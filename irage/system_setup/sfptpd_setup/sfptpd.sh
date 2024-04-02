#!/bin/bash


# Check if the ring.sh file exists in sfptpd_setup directory
if [ -f "/root/sfptpd_setup/ring.sh" ]; then
    # Move the ring.sh file to the root directory
    cp "/root/sfptpd_setup/ring.sh" /root/

    # Check if the move was successful
    if [ $? -eq 0 ]; then
        echo "The ring.sh file has been moved to the root directory."
    else
        echo "Failed to move the ring.sh file."
        exit 1
    fi
else
    echo "The ring.sh file does not exist in the sfptpd_setup directory."
    exit 1
fi

# Step 1: Extract SF.tar.xz
tar -xvf SF-108910-LS-16_Solarflare_Enhanced_PTP_Daemon_sfptpd_-_64_bit_binary_tarball.tgz

# Step 2: Move extracted files to /var directory
EXTRACTED_DIR=$(find . -type d -name "sfptpd-3.2.1.1004.x86_64" | head -n 1)
mv "$EXTRACTED_DIR" /var/


# Step 3: Delete ptp_salve.cfg file and copy ptp_slave.cfg from root to /var/sfptpd-3.2.1.1004.x86_64/config/
CONFIG_DIR="/var/sfptpd-3.2.1.1004.x86_64/config/"
PTP_SALVE_CFG="$CONFIG_DIR/ptp_salve.cfg"
PTP_SLAVE_CFG="/root/sfptpd_setup/ptp_slave.cfg" # Replace with the actual path of ptp_slave.cfg in root

if [ -f "$PTP_SALVE_CFG" ]; then
    rm "$PTP_SALVE_CFG"
fi

cp "$PTP_SLAVE_CFG" "$CONFIG_DIR"

# Step 4: Copy sfptpd from /var/sfptpd-3*/sfptpd to /usr/sbin/
SFPTPD_BINARY="/var/sfptpd-3.2.1.1004.x86_64/sfptpd"
cp "$SFPTPD_BINARY" /usr/sbin/

# Step 5: Create sfptpd.service file
SERVICE_FILE="/usr/lib/systemd/system/sfptpd.service"

cat <<EOL > "$SERVICE_FILE"
[Unit]
Description=sfptpd
DefaultDependencies=true
#Requisite=NetworkManager.service
#After=NetworkManager.service
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/sbin/sfptpd -f "$CONFIG_DIR/ptp_slave.cfg"

[Install]
WantedBy=multi-user.target
EOL

# Step 6: Reload systemd daemon and start sfptpd
systemctl daemon-reload
systemctl start sfptpd

# Step 7: Check if sfptpd is active
if systemctl is-active --quiet sfptpd; then
    echo "sfptpd is active and running."
else
    echo "Failed to start sfptpd."
fi
