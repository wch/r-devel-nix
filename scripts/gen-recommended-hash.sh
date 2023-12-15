#!/usr/bin/env bash

set -e

# Use C locale to ensure consistent sorting of filenames across platforms
LC_ALL=C

script_dir=$(dirname $(realpath "$0"))
output_dir=$(realpath "$script_dir/../")

# Directory containing the recommended files
recommended_dir="${script_dir}/_recommended"

output_file="${output_dir}/recommended-package-hashes.txt"

# Ensure the provided directory is not the current working directory
if [ "$PWD" == "$(realpath "$recommended_dir")" ]; then
    echo "The specified directory should not be the current working directory."
    exit 1
fi

# Clear the output file
> "$output_file"

# Iterate over each file in the directory
cd "$recommended_dir"
for file in *; do
    if [ -f "$file" ]; then
        # Generate hash for the file
        hash=$(nix hash file "$file")

        # Append the filename and hash to the output file
        echo "${file} ${hash}" >> "$output_file"
    fi
done

echo "Hashes written to $output_file"
echo
