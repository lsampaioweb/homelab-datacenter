#!/bin/bash

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
      log_error "Failed to create directory $dir."
      exit 1
    fi
  fi
}

# Navigate to a directory with error checking.
navigate_to_dir() {
  local dir="$1"
  if ! pushd "$dir" >/dev/null 2>&1; then
    log_error "Directory $dir does not exist."
    exit 1
  fi
}

# Return to the previous directory.
return_to_previous_dir() {
  popd >/dev/null 2>&1
}
