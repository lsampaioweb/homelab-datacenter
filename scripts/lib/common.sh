#!/bin/bash

# Shared functions for homelab-datacenter scripts.

# Get current timestamp in YYYY-MM-DD HH:MM:SS format.
get_current_datetime() {
  date "+%Y-%m-%d %H:%M:%S"
}

# Log a message with timestamp.
log_message() {
  echo "$(get_current_datetime) $*" >&2
}

# Log an info message.
log_info() {
  log_message "INFO: $*"
}

# Log a debug message if DEBUG is true.
log_debug() {
  if [ "$DEBUG" = "true" ]; then
    log_message "DEBUG: $*"
  fi
}

# Measure execution time of a function.
# Usage: measure_time "operation name" function_name [args...].
measure_time() {
  local operation="$1"
  local func="$2"
  shift 2
  TIMEFORMAT="$operation took %R seconds."
  time "$func" "$@"
  echo ""
}

# Check if a directory exists.
# Returns 0 (true) if the directory exists, 1 (false) otherwise.
directory_exists() {
  local dir="$1"
  [ -d "$dir" ] && return 0 || return 1
}

# Create a directory if it doesn't exist.
create_directory() {
  local dir="$1"
  if ! directory_exists "$dir"; then
    log_debug "Creating directory: $dir."

    if ! mkdir -p "$dir" 2>/dev/null; then
      log_message "ERROR: Failed to create directory $dir."
      exit 1
    fi
  fi
}

# Navigate to a directory with error checking.
navigate_to_dir() {
  local dir="$1"
  if ! pushd "$dir" >/dev/null 2>&1; then
    log_message "ERROR: Directory $dir does not exist."
    exit 1
  fi
}

# Return to the previous directory.
return_to_previous_dir() {
  popd >/dev/null 2>&1
}
