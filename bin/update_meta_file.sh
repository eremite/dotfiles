#!/usr/bin/env bash

full_path="$1"
filename=$(basename "$full_path")

if [ "$filename" = "project.md" ]; then
  file_id="gdrive_file_id"
elif [ "$filename" = "project.rb" ]; then
  file_id="gdrive_file_id"
elif [ "$filename" = "project.yml" ]; then
  file_id="1JAj-gdrive_file_id"
fi

if command -v gdrive &> /dev/null; then
  gdrive update "$file_id" "$full_path"
fi
