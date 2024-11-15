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
while IFS= read -r obj_file; do
    # Replace .o with .c and .S to get possible source file paths
    c_file="${obj_file%.o}.c"
    s_file="${obj_file%.o}.S"
    
    # Skip files in the 'scripts' directory
    if [[ "$obj_file" =~ ^./scripts/ ]]; then
        continue
    fi

    # Check if either the .c or .S file exists
    if [ -f "$c_file" ]; then
        # Copy the .c file to the destination, preserving directory structure
        cp --parents "$c_file" "$DEST_DIR"
    elif [ -f "$s_file" ]; then
        # Copy the .S file to the destination, preserving directory structure
        cp --parents "$s_file" "$DEST_DIR"
    else
        # Warn if neither file exists
        echo "Warning: Source file $c_file or $s_file not found."
    fi
done < "$INPUT_FILE"
