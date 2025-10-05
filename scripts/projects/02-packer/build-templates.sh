#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./build-templates.sh [action] [environment]
#   action defaults to "validate", environment defaults to "home".
#   $1 -> validate, build.
#   $2 -> home, homelab.

# Source common functions and variables.
. $(dirname "$0")/../../lib/log.sh
. $(dirname "$0")/../../lib/directory.sh
. $(dirname "$0")/../../lib/time.sh
. $(dirname "$0")/vars/variables.sh

# Variable to store the PID of the current Packer process.
packer_pid=""

# Create logs directory with date if it doesn't exist.
create_directory "$LOG_DIR"

# Resolve LOG_FILE to absolute path before any directory navigation.
LOG_FILE_ABSOLUTE=$(realpath "$LOG_FILE")

# Function to handle SIGINT (Ctrl+C).
cleanup() {
  if [ -n "$packer_pid" ]; then
    log_error "Caught interrupt, stopping Packer (PID: $packer_pid)..."
    kill -SIGINT "$packer_pid" 2>/dev/null
    wait "$packer_pid" 2>/dev/null
  fi
  log_info "Exiting..."
  exit 1
}

# Set up trap to catch SIGINT.
trap cleanup SIGINT

run_packer_build() {
  local project_dir="$1"
  local action="${2:-validate}"
  local environment="${3:-home}"

  # Check if action and environment are provided.
  if [ -z "$action" ] || [ -z "$environment" ]; then
    log_error "Missing required arguments: action and environment."
    exit 1
  fi

  # Extract project name (e.g., "10-proxmox-ubuntu-server-raw" from "10-proxmox-ubuntu-server-raw/packer/").
  local project_name=$(echo "$project_dir" | cut -d'/' -f1)

  log_info "Running $project_name with commands: [$action $environment]."

  navigate_to_dir "$PACKER_PROJECTS_PATH/$project_dir"

  # Run pkr.sh and capture its output.
  # tee /dev/tty to display on console, stdbuf -o0 sed to disable buffering, ensuring real-time writes.
  # sed '...' -> Remove ANSI escape codes from the output.
  ./pkr.sh "$action" "$environment" 2>&1 | tee /dev/tty | stdbuf -o0 sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$LOG_FILE_ABSOLUTE" & packer_pid=$!

  # Wait for the Packer process to complete.
  wait $packer_pid

  return_to_previous_dir
}

create_templates() {
  run_packer_build "10-proxmox-ubuntu-server-raw/packer/" "$1" "$2"
  run_packer_build "11-proxmox-ubuntu-server-standard/packer/" "$1" "$2"
  run_packer_build "12-proxmox-ubuntu-server-std-docker/packer/" "$1" "$2"
  run_packer_build "20-proxmox-ubuntu-desktop-raw/packer/" "$1" "$2"
  run_packer_build "21-proxmox-ubuntu-desktop-standard/packer/" "$1" "$2"
}

measure_time "Template build" create_templates "$1" "$2"

log_info "Template builds completed successfully."
