#!/bin/bash

# Define the servers
server1="172.16.100.23"
server2="172.16.100.46"

# Define the usernames
username="backup"

# SSH into servers, fetch .bashrc, and compare
compare_bashrc() {
    echo "Comparing .bashrc for user '$username' on $1 and $2"
    ssh "$username@$1" "cat ~/.bashrc" > /tmp/server1_bashrc
    ssh "$username@$2" "cat ~/.bashrc" > /tmp/server2_bashrc

    # Compare the files and display the differences
    diff /tmp/server1_bashrc /tmp/server2_bashrc
}

# Execute function to compare .bashrc files
compare_bashrc "$server1" "$server2"

# Cleanup temporary files
#rm /tmp/server1_bashrc /tmp/server2_bashrc

