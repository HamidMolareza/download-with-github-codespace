#!/usr/bin/env python3

import os
import subprocess
import sys
from typing import Optional
from tqdm import tqdm


def get_argv(args, index: int, default_value: Optional[str] = None) -> Optional[str]:
    try:
        return args[index]
    except IndexError:
        return default_value


def download_videos(file_path):
    with open(file_path, "r") as file:
        urls = file.readlines()

    # Remove any leading/trailing whitespace characters
    urls = [url.strip() for url in urls]

    # Download each URL using yt-dlp with progress bar
    for url in tqdm(urls, desc="Downloading videos", unit="video"):
        if url:
            print(f"Downloading {url}")
            try:
                # Execute yt-dlp command to download the video in the best quality
                subprocess.run(
                    [
                        "yt-dlp",
                        "-f",
                        "bv+ba/b",
                        url,
                    ],
                    check=True,
                )
            except subprocess.CalledProcessError as e:
                print(f"An error occurred while downloading {url}: {e}")


if __name__ == "__main__":
    file_path = get_argv(sys.argv, 1)
    if not file_path:
        file_path = input("Download links file path: ")

    if os.path.exists(file_path):
        download_videos(file_path)
    else:
        print(f"The file {file_path} does not exist.")
