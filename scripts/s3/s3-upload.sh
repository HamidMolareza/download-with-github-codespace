#!/bin/bash

# Constants - Change these
domain="s3.ir-thr-at1.arvanstorage.ir"
bucket_name="bucket-aws"
bucket_path="files"

# Functions
check_path() {
    local path="$1"

    if [ -e "$path" ]; then
        if [ -f "$path" ]; then
            echo 0
        elif [ -d "$path" ]; then
            echo 1
        else
            echo 3
        fi
    else
        echo 3
    fi
}

# Check if yt-dlp is installed
if ! command -v aws &>/dev/null; then
    echo "Error: aws is not installed. Please install it first."
    exit 1
fi

# Check if a YouTube link is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file or path to upload> <options>"
    echo "Sample:"
    printf "\t%s file.mp4\n" "$0"
    printf "\t%s folder\n" "$0"
    printf "\t%s folder--exclude "*.tmp"\n" "$0"
    exit 1
fi

path="$1"
if [ "$(check_path "$path")" -eq 0 ]; then
    folder=0 #file
elif [ "$(check_path "$path")" -eq 1 ]; then
    folder=1 #folder
else
    echo "Input ($path) is not valid. Only file or folder are allowed."
    exit 1
fi

shift 1 # skip the path argument to get options

if [ $folder -eq 0 ]; then
    # Upload File
    aws --endpoint-url "https://$domain" s3 cp "$path" "s3://$bucket_name/$bucket_path/" "$@"
else
    # Upload folder
    aws --endpoint-url "https://$domain" s3 cp --recursive "$path" "s3://$bucket_name/$bucket_path/" "$@"
fi

if [ "$?" -eq 0 ]; then
    echo "File(s) uploaded successfully."
    if [ $folder -eq 0 ]; then
        echo "Download URL: https://$bucket_name.$domain/$bucket_path/$(basename "$path")"
    fi

    echo ""
    aws --endpoint-url "https://$domain" s3 ls s3://$bucket_name/$bucket_path/
else
    echo "Error: Failed to upload file."
    exit 1
fi