#!/bin/bash

# List of packages to install
packages=(
    gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 wayland
    libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon 
    xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio hyprland-git wlroots gcc clang
    dunst mako cliphist pipewire wireplumber cava polkit-kde-agent qt5-wayland qt6-wayland rofi-lbonn-wayland-git
    pacseek kate marker nano-syntax-highlighting pipewire-alsa pipewire-audio pipewire-jack	pipewire-pulse	
    gst-plugin-pipewire	networkmanager network-manager-applet bluez bluez-utils	blueman brightnessctl impression 
    libreoffice-fresh
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
