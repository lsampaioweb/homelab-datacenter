#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./update-packer-repos.sh

# Set the directory of where the script is located.
SCRIPT_DIR=$(dirname "$0")

# Git directory.
GIT_DIR="$HOME/git"

# Source common functions and variables.
. "$SCRIPT_DIR/../../lib/log.sh"
. "$SCRIPT_DIR/../../lib/directory.sh"
. "$SCRIPT_DIR/../../lib/time.sh"
. "$SCRIPT_DIR/../../lib/git.sh"
. "$SCRIPT_DIR/vars/variables.sh"

# Create logs directory with date if it doesn't exist.
create_directory "$LOG_DIR"

# Redirect output to both console and log file.
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

log_info "Starting Packer repositories update process..."

# Message with the path to the log file.
log_info "Full log in: $LOG_FILE."

# Validate GIT_DIR exists
if [[ ! -d "$GIT_DIR" ]]; then
  log_error "Git directory does not exist: $GIT_DIR"
  exit 1
fi

# Navigate to the git directory.
navigate_to_dir "$GIT_DIR"

# Packer repositories.
measure_time "Updating 01-packer-proxmox-ubuntu-iso" update_git_repository "$GIT_DIR/datacenter/02-packer" "01-packer-proxmox-ubuntu-iso"
measure_time "Updating 02-packer-proxmox-ubuntu-clone" update_git_repository "$GIT_DIR/datacenter/02-packer" "02-packer-proxmox-ubuntu-clone"
measure_time "Updating 10-proxmox-ubuntu-server-raw" update_git_repository "$GIT_DIR/datacenter/02-packer" "10-proxmox-ubuntu-server-raw"
measure_time "Updating 11-proxmox-ubuntu-server-standard" update_git_repository "$GIT_DIR/datacenter/02-packer" "11-proxmox-ubuntu-server-standard"
measure_time "Updating 12-proxmox-ubuntu-server-std-docker" update_git_repository "$GIT_DIR/datacenter/02-packer" "12-proxmox-ubuntu-server-std-docker"
measure_time "Updating 20-proxmox-ubuntu-desktop-raw" update_git_repository "$GIT_DIR/datacenter/02-packer" "20-proxmox-ubuntu-desktop-raw"
measure_time "Updating 21-proxmox-ubuntu-desktop-standard" update_git_repository "$GIT_DIR/datacenter/02-packer" "21-proxmox-ubuntu-desktop-standard"

# Return to the original directory.
return_to_previous_dir

log_info "Packer repository updates completed successfully."
