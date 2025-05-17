#!/bin/bash

# Directory where your 'tree' command was run (adjust if needed)
START_DIR="."

# Pattern used for excluding directories in your 'tree' command.
# This should match the -I pattern you used with tree.
IGNORE_PATTERN='ansible|tsm'

# The single file where all content will be saved
OUTPUT_FILE="combined-files.txt"

# --- Get the list of files ---
# Uses tree to find files, ignoring specified patterns, printing full paths,
# omitting the summary report, and filtering out directories.
# 'sed' removes leading spaces/indentation from tree output.
mapfile -t files < <(tree -I "$IGNORE_PATTERN" -f --noreport -if "$START_DIR" | grep -v '/$' | sed 's/^ *[└├│]..//; s/^ *//')

# Clear the output file if it already exists
> "$OUTPUT_FILE"
echo "Found ${#files[@]} files. Combining content into '$OUTPUT_FILE'..."
echo "" # Add a blank line for readability in script output

# --- Process files and append to the single output file ---
{
  # Add a general header to the combined file
  echo "############################################################"
  echo "### Generated: $(date)"
  echo "### Base Directory: $(pwd)/$START_DIR"
  echo "############################################################"
  echo ""

  total_files=${#files[@]}
  for (( i=0; i<total_files; i++ )); do
    file="${files[$i]}"

    # Check if it's a readable file AND if it's a regular file (not a directory or special file)
    if [[ -f "$file" && -r "$file" ]]; then
      # Print a clear header for this specific file
      echo "############################################################"
      echo "### File $((i + 1))/$total_files: $file"
      echo "############################################################"
      # Print the file's content
      cat "$file"
      # Ensure there's a newline after the file content, even if the file doesn't end with one
      echo ""
      # Add extra blank lines for visual separation between files
      echo ""
    fi
  done

  # Add a general footer to the combined file
  echo "############################################################"
  echo "### Combined Configuration Files (Updated) - End"
  echo "############################################################"

} > "$OUTPUT_FILE" # Redirect *all* output generated within the { ... } block to the output file.

echo "--- Done. Combined content saved to '$OUTPUT_FILE'. ---"
echo "Please open the file '$OUTPUT_FILE', copy its entire content, and paste it here."
