#!/usr/bin/env python3

import os
import subprocess
import sys
from typing import Optional
from tqdm import tqdm
import yt_dlp


class URLModel:
    def __init__(self, url: str, name: Optional[str]):
        if is_none_or_empty(url):
            raise Exception("The url parameter is required.")
        self.url = url
        
        if is_none_or_empty(name):
            self.name = None
        else:
            self.name = name

    def __repr__(self):
        return f"URLModel(url='{self.url}', name='{self.name}')"
    
    def __str__(self):
        if self.name:
            return f"[{self.name}]: {self.url}"
        return f"{self.url}"
    
    
def is_none_or_empty(s):
    return s is None or s.strip() == ''


def parse_file_to_url_model(filename):
    models = []
    with open(filename, 'r') as file:
        for line in file:
            stripped_line = line.strip()
            if stripped_line:  # ignore empty lines
                parts = stripped_line.split()
                if len(parts) >= 2:
                    url = parts[0]
                    name = ' '.join(parts[1:])  # join remaining parts as name
                    models.append(URLModel(url, name))
    return models


def get_argv(args, index: int, default_value: Optional[str] = None) -> Optional[str]:
    try:
        return args[index]
    except IndexError:
        return default_value


def download_videos(file_path):
    url_models = parse_file_to_url_model(file_path)

    # Download each URL using yt-dlp with progress bar
    for url_models in tqdm(urls, desc="Downloading videos", unit="video"):
        print(f"Downloading {url_models}")
        try:
            # Execute yt-dlp command to download the video in the best quality
            subprocess.run(
                [
                    "yt-dlp",
                    "-f",
                    "bv+ba/b",
                    url_models.url,
                ],
                check=True,
            )
        except subprocess.CalledProcessError as e:
            print(f"An error occurred while downloading {url_models}: {e}")
            
def download_videos(file_path):
    url_models = parse_file_to_url_model(file_path)

    # Download each URL using yt-dlp with progress bar
    for url_model in tqdm(url_models, desc="Downloading videos", unit="video"):
        print(f"Downloading {url_model}")
        output_folder = f"./{url_model.name}"
        os.makedirs(output_folder, exist_ok=True)  # Ensure the output directory exists
        
        def progress_hook(d):
            if d['status'] == 'downloading':
                print(f"\rDownloading {d['filename']} - {d['_percent_str']} at {d['_speed_str']} ETA {d['_eta_str']}", end='', flush=True)
            elif d['status'] == 'finished':
                print(f"\rDownloaded {d['filename']} - 100%")

        ydl_opts = {
            'format': 'bv+ba/b',
            'outtmpl': f'{output_folder}/%(title)s.%(ext)s',
            'progress_hooks': [progress_hook]
        }
        
        try:
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url_model.url])
        except yt_dlp.utils.DownloadError as e:
            print(f"An error occurred while downloading {url_model}: {e}")


if __name__ == "__main__":
    file_path = get_argv(sys.argv, 1)
    if not file_path:
        file_path = input("Download links file path: ")

    if os.path.exists(file_path):
        download_videos(file_path)
    else:
        print(f"The file {file_path} does not exist.")
