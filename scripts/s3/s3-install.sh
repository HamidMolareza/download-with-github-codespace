#!/bin/bash

if command -v aws &> /dev/null; then
    echo "The aws command is already installed."
    exit 1
fi

sudo apt update -y
sudo apt install awscli -y

aws configure
