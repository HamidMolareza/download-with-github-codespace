#!/bin/bash

# Check if filename is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Get the filename from the command-line argument
filename=$1

# Check if file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Read the file line by line and download each URL, optionally with the specified name
while IFS= read -r line; do
    # Skip empty lines
    if [ -z "$line" ]; then
        continue
    fi

    # Split the line into URL and custom file name
    url=$(echo "$line" | awk '{print $1}')
    custom_name=$(echo "$line" | awk '{print $2}')

    # Check if URL is present
    if [ -z "$url" ]; then
        echo "Invalid line (missing URL): $line"
        continue
    fi

    # Download the URL with the custom file name if provided
    if [ -z "$custom_name" ]; then
        echo "Downloading $url"
        wget "$url"
    else
        echo "Downloading $url as $custom_name"
        wget -O "$custom_name" "$url"
    fi
done < "$filename"
