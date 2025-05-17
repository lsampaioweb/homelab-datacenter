#!/bin/bash

# Source shared functions.
. $(dirname "$0")/../../lib/log.sh
. $(dirname "$0")/../../lib/directory.sh
. $(dirname "$0")/../../lib/time.sh

# Run a Terraform operation (apply or destroy) on a project directory.
# Usage: run_terraform_operation "operation" "project_dir" "environment".
run_terraform_operation() {
  local operation="$1"
  local project_dir="$2"
  local environment="$3"

  log_info "$operation $project_dir with environment $environment."

  navigate_to_dir "$project_dir"
  ./tf.sh "$operation" "$environment" -auto-approve
  return_to_previous_dir
}
