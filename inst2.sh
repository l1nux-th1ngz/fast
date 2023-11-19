#!/bin/bash

# List of packages to install
packages=(
    qt5-quickcontrols qt5-quickcontrols2 qt5-graphicaleffects swww swaylock-effects-git
    swayidle wlogout grim slurp swappy xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk imv
    qt5-imageformats pavucontrol pamixer nwg-look kvantum qt5ct firefox thunderbird neofetch dolphin
    visual-studio-code-bin vim helix geany geany-plugins
)

# Update the system first
echo "Updating system..."
sudo pacman -Syu

# Install packages
for pkg in "${packages[@]}"
do
    echo "Installing $pkg..."
    yay -S --noconfirm "$pkg"
done

echo "All packages installed successfully."
