#!/bin/bash

chmod -R +x scripts

printf "%s\n" "export PATH=\"$PWD/scripts:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/s3:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/download:\$PATH\"" >> ~/.bashrc
printf "%s\n" "export PATH=\"$PWD/scripts/youtube:\$PATH\"" >> ~/.bashrc

source "$HOME/.bashrc"

pip install -r "$PWD/scripts/youtube/requirements.txt"