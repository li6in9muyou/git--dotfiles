#!/bin/sh

# Get the filename of the current hook
hook_name=$(basename "$0")

# Construct the corresponding .husky script path
husky_script="./.husky/$hook_name"

# Check if the script exists and source it
if [ -f "$husky_script" ]; then
  echo "#   git--dotfiles/hooks/ensure-husky-runs/$hook_name"
  . "$husky_script"
  if [ $? -ne 0 ]; then
    echo -e "\033[31mAborted: husky failed\033[0m"
    exit 1
  fi
fi
