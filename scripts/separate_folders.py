#!/usr/bin/env python3

import os
import shutil
import argparse

def get_size(start_path):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(start_path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            total_size += os.path.getsize(fp)
    return total_size

def create_subfolder(base_path, index):
    subfolder_name = f"subfolder_{index}"
    subfolder_path = os.path.join(base_path, subfolder_name)
    os.makedirs(subfolder_path, exist_ok=True)
    return subfolder_path

def main():
    parser = argparse.ArgumentParser(description="Separate folder into subfolders with a maximum size of 5GB each.")
    parser.add_argument("folder_path", type=str, help="Path to the folder to be separated.")
    args = parser.parse_args()

    folder_path = args.folder_path
    if not os.path.isdir(folder_path):
        print(f"The provided path '{folder_path}' is not a directory.")
        return

    max_size = 4.9 * 1024 * 1024 * 1024  # 5GB in bytes
    current_size = 0
    folder_index = 1
    subfolder_path = create_subfolder(folder_path, folder_index)

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path)

            if current_size + file_size > max_size:
                folder_index += 1
                subfolder_path = create_subfolder(folder_path, folder_index)
                current_size = 0

            shutil.move(file_path, subfolder_path)
            current_size += file_size

if __name__ == "__main__":
    main()
