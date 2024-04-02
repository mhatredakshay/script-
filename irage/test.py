import subprocess

# Define the command to be executed
fs="mnt"
command = f"lsblk | grep -i {fs}"

# Run the command and capture the output
try:
    output = subprocess.check_output(command, shell=True, text=True)
    print(output)
except subprocess.CalledProcessError as e:
    print(f"Error: {e}")

