#!/bin/bash

# Source shared variables.
. $(dirname "$0")/../../vars/variables.sh

# Variables specific to project.

# logs/<date>/daily-updates.log.
LOG_FILE="$LOGS_DIR/$(date +%Y-%m-%d)/daily-updates.log"

# logs/<date>
LOG_DIR=$(dirname "$LOG_FILE")
