#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./run-daily-updates.sh

# Source common functions and variables.
. $(dirname "$0")/../../lib/log.sh
. $(dirname "$0")/../../lib/directory.sh
. $(dirname "$0")/../../lib/time.sh
. $(dirname "$0")/vars/variables.sh

# Create logs directory with date if it doesn't exist.
create_directory "$LOG_DIR"

# Redirect output to both console and log file.
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

run_jumpserver_daily_updates() {
  log_info "Running JumpServer updates."

  navigate_to_dir "$HOME/git/datacenter/06-projects/01-working-machine/ansible"
  ansible-playbook update.yml
  return_to_previous_dir
}

run_openssl_daily_updates() {
  log_info "Running OpenSSL certificate updates."

  navigate_to_dir "$HOME/git/datacenter/06-projects/02-openssl-certificates"
  ansible-playbook verify_certificate.yml
  return_to_previous_dir
}

run_proxmox_cluster_daily_updates() {
  log_info "Running Proxmox cluster updates."

  navigate_to_dir "$HOME/git/datacenter/06-projects/03-proxmox-cluster"
  ansible-playbook update.yml
  return_to_previous_dir
}

measure_time "JumpServer updates" run_jumpserver_daily_updates
measure_time "OpenSSL certificate updates" run_openssl_daily_updates
measure_time "Proxmox cluster updates" run_proxmox_cluster_daily_updates

log_info "Daily updates completed successfully."
