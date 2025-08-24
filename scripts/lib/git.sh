#!/bin/bash

# Git Operations Library
# 
# This library provides reusable functions for Git repository management,
# including submodule handling, branch tracking, and automated updates.
#
# Functions:
#   - pull_main_repository(): Pull latest changes from main repository
#   - initialize_submodules(): Initialize and sync all submodules
#   - configure_submodule_tracking(): Configure submodules to track main branch
#   - update_submodules_to_latest(): Update submodules to latest commits
#   - commit_submodule_updates(): Commit and push submodule reference updates
#   - update_git_repository(): Main orchestrator function for full repository update
#
# Dependencies: log.sh, directory.sh
# Author: Luciano Sampaio
# Version: 2.0

# Function to pull latest changes from main repository.
pull_main_repository() {
  log_info "Pulling latest changes from main repository..."
  git pull || {
    log_error "Git pull failed for main repository."
    return 1
  }
}

# Function to initialize and sync submodules.
initialize_submodules() {
  log_info "Initializing and syncing submodules..."
  git submodule update --init --recursive || {
    log_error "Submodule initialization failed."
    return 1
  }
  git submodule sync --recursive || {
    log_error "Submodule sync failed."
    return 1
  }
}

# Function to configure submodule branch tracking.
configure_submodule_tracking() {
  log_info "Configuring submodule branch tracking..."
  git submodule foreach '
    if ! git config -f $toplevel/.gitmodules submodule.$name.branch >/dev/null 2>&1; then
      echo "Configuring $name to track main branch..."
      git config -f $toplevel/.gitmodules submodule.$name.branch main
    fi
  ' || {
    log_error "Failed to configure submodule branch tracking."
    return 1
  }
}

# Function to update submodules to latest commits.
update_submodules_to_latest() {
  log_info "Updating submodules to latest commits..."
  git submodule foreach '
    current_branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
    if [ "$current_branch" != "main" ]; then
      echo "Switching $name to main branch..."
      git checkout main 2>/dev/null || git checkout -b main 2>/dev/null || true
    fi
    echo "Pulling latest changes for $name..."
    git pull origin main 2>/dev/null || git pull 2>/dev/null || echo "Warning: Could not pull latest changes for $name."
  '
}

# Function to commit and push submodule updates.
commit_submodule_updates() {
  if git status --porcelain | grep -q .; then
    log_info "New submodule commits detected, committing and pushing..."
    git add . || {
      log_error "Failed to stage submodule changes."
      return 1
    }
    git commit -m "chore: Update submodule commits." --author "$BOT_AUTHOR" || {
      log_error "Failed to commit submodule changes."
      return 1
    }
    git push origin main || {
      log_error "Failed to push submodule changes."
      return 1
    }
    log_info "Submodule updates committed and pushed successfully."
  else
    log_info "No submodule changes detected."
  fi
}

# Main function to update a git repository.
update_git_repository() {
  local dir="$1"
  local repo="$2"

  log_info "Starting update for repository: $repo."
  log_info "Location: $dir/$repo."

  # Validate directory exists.
  if [[ ! -d "$dir/$repo" ]]; then
    log_error "Directory $dir/$repo does not exist."
    return 1
  fi

  # Navigate to repository.
  navigate_to_dir "$dir/$repo" || {
    log_error "Failed to navigate to $dir/$repo."
    return 1
  }

  # Execute update sequence.
  pull_main_repository && \
  initialize_submodules && \
  configure_submodule_tracking && \
  update_submodules_to_latest && \
  commit_submodule_updates

  local exit_code=$?

  # Return to previous directory.
  return_to_previous_dir

  if [ $exit_code -eq 0 ]; then
    log_info "Successfully updated $repo."
  else
    log_error "Failed to update $repo."
    return $exit_code
  fi

  echo "" # Add spacing between repositories.
}
