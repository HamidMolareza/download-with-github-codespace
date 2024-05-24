#!/bin/bash

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp is not installed. Please install it first."
    exit 1
fi

# Check if a YouTube link is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <youtube_link>"
    exit 1
fi

# Get the YouTube link from command-line argument
youtube_link="$1"

# Show supported formats for downloading
echo "Supported formats for downloading:"
yt-dlp -F "$youtube_link"

# Prompt user to enter the video ID
read -rp "Enter the video ID you want to download: " video_id

# Download the video using yt-dlp
yt-dlp -f $video_id "$youtube_link"
