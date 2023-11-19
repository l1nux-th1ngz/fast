#!/bin/bash

# Create .fonts directory in the home folder
mkdir -p ~/.fonts

# Initialize pacman keyring
sudo pacman-key --init

# Update font cache
fc-cache

# Install fontconfig, anyrun-git, and emacs-gcc-wayland-devel-bin using yay
yay -S --noconfirm fontconfig anyrun-git emacs-gcc-wayland-devel-bin
