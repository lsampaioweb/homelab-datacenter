#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./apply.sh [environment]
# ./apply.sh staging
# ./apply.sh production

# Source common functions and variables.
. $(dirname "$0")/../../lib/common.sh
. $(dirname "$0")/vars/apply.sh

# Set default value for environment.
environment=${1:-staging}

# Create logs directory with date if it doesn't exist.
create_directory "$LOG_DIR"

# Redirect output to both console and log file.
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

run_terraform_apply() {
  local project_dir="$1"
  local environment="$2"

  log_info "Deploying $project_dir with environment $environment."

  navigate_to_dir "$project_dir"
  ./tf.sh apply "$environment" -auto-approve
  return_to_previous_dir
}

# measure_time "Deploying 01-working-machine" run_terraform_apply "$HOME/git/datacenter/06-projects/01-working-machine/terraform/" "$environment"
measure_time "Deploying 04-load-balancer" run_terraform_apply "$HOME/git/datacenter/06-projects/04-load-balancer/terraform/" "$environment"
measure_time "Deploying 05-backup-manager" run_terraform_apply "$HOME/git/datacenter/06-projects/05-backup-manager/terraform/" "$environment"
measure_time "Deploying 06-dhcp" run_terraform_apply "$HOME/git/datacenter/06-projects/06-dhcp/terraform/" "$environment"
measure_time "Deploying 07-dns" run_terraform_apply "$HOME/git/datacenter/06-projects/07-dns/terraform/" "$environment"
measure_time "Deploying 08-ntp" run_terraform_apply "$HOME/git/datacenter/06-projects/08-ntp/terraform/" "$environment"

log_info "Terraform deployments completed successfully."
