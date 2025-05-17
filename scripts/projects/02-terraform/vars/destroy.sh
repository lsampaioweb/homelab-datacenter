#!/bin/bash

# Source shared variables.
. $(dirname "$0")/../../vars/variables.sh

# Variables specific to project.

# logs/<date>/destroy.log.
LOG_FILE="$LOGS_DIR/$(date +%Y-%m-%d)/destroy.log"

# logs/<date>
LOG_DIR=$(dirname "$LOG_FILE")

# Set default value for environment.
environment=${1:-staging}
