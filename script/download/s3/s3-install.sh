#!/bin/bash

if command -v aws &> /dev/null; then
    echo "The aws command is already installed."
    exit 1
fi

sudo apt update
sudo apt install awscli

aws configure
