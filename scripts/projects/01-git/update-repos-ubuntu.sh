#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./update-repos-ubuntu.sh

# Set the directory of where the script is located.
SCRIPT_DIR=$(dirname "$0")

# Git directory.
GIT_DIR="$HOME/git"

# Include the script that will update all repositories.
. "$SCRIPT_DIR/update-repos.sh"
