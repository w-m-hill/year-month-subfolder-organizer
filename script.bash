#!/bin/bash

SOURCE_DIR="/path/to/your/source/directory"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

find "$SOURCE_DIR" -type f | while read file; do
    if [ ! -r "$file" ]; then
        echo "Warning: Cannot read file $file. Skipping."
        continue
    fi
    
    modified=$(stat -c "%y" "$file" | cut -d' ' -f1)
    year=$(date -d "$modified" +"%Y")
    month=$(date -d "$modified" +"%m")
    
    target_dir="$SOURCE_DIR/$year/$month"
    mkdir -p "$target_dir"
    
    if ! mv "$file" "$target_dir/"; then
        echo "Error: Failed to move $file to $target_dir"
    fi
done

echo "File organization complete!"
