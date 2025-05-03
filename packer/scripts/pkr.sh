#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./pkr.sh build home
#   $1 -> validate, build.
#   $2 -> home, homelab.

# Store the absolute path of the initial directory.
BASE_DIR="$(pwd)"

# Absolute path for the logs directory.
LOGS_DIR="$BASE_DIR/packer-logs"

# Create logs directory if it doesn't exist.
mkdir -p "$LOGS_DIR"

# Variable to store the PID of the current Packer process.
packer_pid=""

# Function to handle SIGINT (Ctrl+C).
cleanup() {
  if [ -n "$packer_pid" ]; then
    echo "Caught interrupt, stopping Packer (PID: $packer_pid)..."
    kill -SIGINT "$packer_pid" 2>/dev/null
    wait "$packer_pid" 2>/dev/null
  fi
  echo "Exiting..."
  exit 1
}

# Set up trap to catch SIGINT.
trap cleanup SIGINT

runningPackerBuild() {
  local project_dir="$1"
  local action="$2"
  local environment="$3"

  # Extract project name (e.g., "10-proxmox-Ubuntu-server-raw" from "10-proxmox-Ubuntu-server-raw/packer/")
  local project_name=$(echo "$project_dir" | cut -d'/' -f1)
  # Use absolute path for log file.
  local log_file="$LOGS_DIR/${project_name}.log"

  # Debug: Print the log file name to verify
  echo "Logging to: $log_file"

  TIMEFORMAT='Build took %R seconds.'
  time {
    echo "Running $project_dir with commands: [$action $environment]" | tee "$log_file"
    cd "../datacenter/02-packer/$project_dir"

      # Run pkr.sh and capture its output.
      # stdbuf -o0 sed to disable buffering, ensuring real-time writes.
      # sed '...' -> Remove ANSI escape codes from the output.
      ./pkr.sh "$action" "$environment" 2>&1 | tee /dev/tty | stdbuf -o0 sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log_file" & packer_pid=$!

      # Wait for the Packer process to complete.
      wait $packer_pid

    cd -
    echo "Finished $project_dir" | tee -a "$log_file"
  }

  echo ""
}

function createTemplates() {
  runningPackerBuild "10-proxmox-ubuntu-server-raw/packer/" "$1" "$2"
  runningPackerBuild "11-proxmox-ubuntu-server-standard/packer/" "$1" "$2"
  runningPackerBuild "12-proxmox-ubuntu-server-std-docker/packer/" "$1" "$2"
  runningPackerBuild "20-proxmox-ubuntu-desktop-raw/packer/" "$1" "$2"
  runningPackerBuild "21-proxmox-ubuntu-desktop-standard/packer/" "$1" "$2"
}

createTemplates "$1" "$2"

# # Run these commands on the node that has the template files.
# : << 'MULTILINE-COMMENT'
# qm destroy 911 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 910 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 902 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 901 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 900 --purge 1 --destroy-unreferenced-disks 1
# MULTILINE-COMMENT
