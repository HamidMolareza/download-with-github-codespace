#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install yt-dlp
install_yt_dlp() {
    echo "yt-dlp is not installed. Installing yt-dlp..."
    sudo apt update
    sudo apt install -y python3-pip
    sudo apt install -y python3-brotli
    sudo pip3 install yt-dlp
}

# Check if a YouTube link is provided
if [ $# -eq 0 ]; then
    echo "Usage: $(basename "$0") <youtube_link>"
    exit 1
fi

# Check if yt-dlp is installed
if ! command_exists yt-dlp; then
    install_yt_dlp
fi

if ! command_exists ffmpeg; then
    sudo apt install -y ffmpeg
fi

# Get the YouTube link from command-line argument
youtube_link="$1"

# Show supported formats for downloading
echo "Supported formats for downloading:"
yt-dlp -F "$youtube_link"

# Prompt user to enter the video ID
read -p "Enter the video ID you want to download: " video_id

# Download the video using yt-dlp
yt-dlp -f $video_id "$youtube_link"
