#!/bin/bash

----------------------------------------------------------------------
# You, probally should not use, this my first build and is massive!!!
----------------------------------------------------------------------


# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check if whiptail is available
if ! command -v whiptail >/dev/null; then
    echo "whiptail is not installed. Install it and run this script again."
    exit 1
fi

# Use whiptail to get user input
USERNAME=$(whiptail --inputbox "Enter your username" 8 78 --title "User Input" 3>&1 1>&2 2>&3)
PASSWORD=$(whiptail --passwordbox "Enter your password" 8 78 --title "User Input" 3>&1 1>&2 2>&3)

# Create a 500MB EFI partition and a root partition with the rest of the space
echo -e "g\nn\n\n\n+500M\nt\n1\nn\n\n\n\nw" | fdisk /dev/nvme0n1

# Install base system and generate fstab
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt > /mnt/etc/fstab

# Install necessary packages
pacman -S --noconfirm sed git xdg-user-dirs
xdg-user-dirs-update
echo
echo "All necessary packages installed successfully."

# Install yay and paru from AUR
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd ..

git clone https://aur.archlinux.org/paru
cd paru
makepkg -si
cd ..

# Install additional packages
yay -S --noconfirm nnn mpd playerctl mpc ncmpcpp lolcat nodejs feh bat exa rclone rsync maim mpv fzf gzip p7zip

# Start the installation
archinstall \
    --script <<EOF
{
    "!root-password": "$PASSWORD",
    "!hostname": "archlinux",
    "!users": {
        "$USERNAME": {
            "!password": "$PASSWORD"
        }
    },
    "!harddrives": ["/dev/nvme0n1"],
    "!bootloader": "grub-install",
    "!file-ystem": "ext4",
    "!kernels": ["linux"],
    "!partitions": {
        "/dev/nvme0n1p1": {
            "FileSystem": "fat32",
            "MountPoint": "/boot"
        },
        "/dev/nvme0n1p2": {
            "FileSystem": "ext4",
            "MountPoint": "/"
        }
    }
}
EOF

# Prepare for the next script
sed '1,/^$/d' inst.sh > /mnt/inst.sh
chmod +x /mnt/inst.sh
arch-chroot /mnt ./inst.sh
exit
