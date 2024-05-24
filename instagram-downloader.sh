#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if instaloader is installed
if command_exists instaloader; then
    echo "instaloader is already installed."
else
    echo "instaloader is not installed. Installing..."

    # Update package list and install pip3 if not installed
    sudo apt update
    if ! command_exists pip3; then
        sudo apt install -y python3-pip
    fi

    # Install instaloader using pip3
    pip3 install --user instaloader

    # Add ~/.local/bin to PATH if it's not already there
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
        source ~/.bashrc
        source ~/.profile
    fi

    echo "instaloader installation complete."
fi

# Verify installation
if command_exists instaloader; then
    echo "instaloader is successfully installed and ready to use."
else
    echo "There was an issue installing instaloader. Please check for errors."
fi

instaloader --version