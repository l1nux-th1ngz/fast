#!/bin/bash

# List of packages to install
packages=(
    gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 
    libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon 
    xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio hyprland-git
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
