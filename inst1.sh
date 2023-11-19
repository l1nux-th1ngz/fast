#!/bin/bash

# Create .fonts directory in the home folder
mkdir -p ~/.fonts

# Initialize pacman keyring
sudo pacman-key --init

# Update font cache
fc-cache

# Install fontconfig using yay
yay -S --noconfirm fontconfig
