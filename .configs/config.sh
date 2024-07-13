#!/bin/bash

chmod -R +x scripts

printf "\n\n" >> ~/.bashrc

printf "%s\n" "export PATH=\"$PWD/scripts:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/s3:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/download:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/youtube:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/aliases:\$PATH\"" >> ~/.bashrc

printf "\n\n" >> ~/.bashrc

printf "%s\n" ". $PWD/.configs/aliases" >> ~/.bashrc

source "$HOME/.bashrc"

pip install -r "$PWD/scripts/youtube/requirements.txt"

sudo apt update
sudo apt install ffmpeg
