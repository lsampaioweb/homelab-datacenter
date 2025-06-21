#!/bin/bash

# Directory to start searching for files (default: current directory)
START_DIR="."

# File extensions to ignore (comma-separated, no spaces)
# Example: jpg,png,gif,bmp,tiff,exe,iso,pdf,zip,tar,gz
IGNORE_EXTENSIONS="jpg,png,gif,bmp,tiff,exe,iso,pdf,zip,tar,gz,svg"

# Directories to ignore (comma-separated, no spaces)
# Example: .git,node_modules,dist
IGNORE_DIRECTORIES=".git"

# The single file where all content will be saved
OUTPUT_FILE="combined_files.txt"

# --- Get the list of files ---
# Build find command with multiple -not -name and -not -path conditions
find_args=("$START_DIR" -type f)

IFS=',' read -r -a dir_array <<< "$IGNORE_DIRECTORIES"
for dir in "${dir_array[@]}"; do
  find_args+=(-not -path "*/$dir/*")
done
IFS=',' read -r -a ext_array <<< "$IGNORE_EXTENSIONS"
for ext in "${ext_array[@]}"; do
  find_args+=(-not -name "*.$ext")
done

# Use find to list all files, excluding specified extensions and directories
# Store find output in a temporary file to avoid subshell scoping issues
temp_file=$(mktemp)
find "${find_args[@]}" -print0 > "$temp_file"
files=()
while IFS= read -r -d '' file; do
  files+=("$file")
done < "$temp_file"
rm -f "$temp_file"

# Clear the output file
> "$OUTPUT_FILE"
echo "Found ${#files[@]} files. Combining content into '$OUTPUT_FILE'..."
echo "" # Add a blank line for readability

# --- Process files and append to the single output file ---
{
  # Add a general header
  echo "############################################################"
  echo "### Generated: $(date)"
  echo "### Base Directory: $(pwd)/$START_DIR"
  echo "############################################################"
  echo ""

  total_files=${#files[@]}
  for (( i=0; i<total_files; i++ )); do
    file="${files[$i]}"

    # Check if it's a readable file
    if [[ -f "$file" && -r "$file" ]]; then
      # Print a clear header for this file
      echo "############################################################"
      echo "### File $((i + 1))/$total_files: $file"
      echo "############################################################"
      # Print the file's content
      cat "$file"
      # Ensure newline after file content
      echo ""
      # Add extra blank lines for separation
      echo ""
    else
      echo "############################################################"
      echo "### File $((i + 1))/$total_files: $file (SKIPPED - not readable or not a file)"
      echo "############################################################"
      echo ""
    fi
  done

  # Add a general footer
  echo "############################################################"
  echo "### Combined Project Files - End"
  echo "############################################################"

} >> "$OUTPUT_FILE" # Append all output to the output file

echo "--- Done. Combined content saved to '$OUTPUT_FILE'. ---"
echo "Please open the file '$OUTPUT_FILE', copy its entire content, and upload or paste it for review."
