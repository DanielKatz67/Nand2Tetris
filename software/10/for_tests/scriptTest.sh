#!/bin/bash

# Assign the first and second argument to variables
folder1=$1
folder2_tests=$2

# Loop through xml files in folder1
for file1 in "$folder1"/*.xml; do
    # Extract the filename without the extension
    filename=$(basename -- "$file1")
    filename_without_ext="${filename%.*}"

    # Construct the corresponding filename in folder2-tests
    file2="$folder2_tests/${filename_without_ext}_test.xml"

    # Check if the corresponding file exists in folder2-tests
    if [ -f "$file2" ]; then
        echo "Comparing $file1 and $file2"
        # Use diff -w to compare the files
        diff -w "$file1" "$file2"
    else
        echo "No corresponding file for $file1 in $folder2_tests"
    fi
done