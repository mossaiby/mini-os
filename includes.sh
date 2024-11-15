#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <destination_directory>"
    exit 1
fi

# Read arguments
INPUT_FILE="$1"
DEST_DIR="$2"

# Read each line in the input file
while IFS= read -r input_path; do
    # Skip files in the '../src' directory
    if [[ "$input_path" == ../src ]]; then
        continue
    fi

    # Remove the "../src/" prefix from the path
    path="${input_path#../src/}"

    # Find .h files and copy them, preserving directory structure
    find "$path" -name "*.h" -exec cp --parents {} "$DEST_DIR" \;
done < "$INPUT_FILE"
