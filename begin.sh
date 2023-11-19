#!/bin/bash

------------------------------------------------------------------
Yes, I definitely know what I'm doing maybe possibly I think! LMAO
------------------------------------------------------------------


# Setting
loadkeys us
timedatectl set-ntp true

# Drive selection
clear
lsblk
echo -ne "Drive to install to: "
read -r drive
cfdisk "$drive"

# Partition slection
clear
lsblk "$drive"

echo -ne "Enter EFI partition: "
read -r efipartition

read -r -p "Should we format the EFI partition? [y/n]: " answer
if [[ $answer = y ]]; then
    echo "There it goes then"
    mkfs.fat -F 32 "$efipartition"
else
    echo "Alright, skipping EFI partition formatting"
fi

echo -ne "Enter swap partition: "
read -r swappartition
mkswap "$swappartition"

echo -ne "Enter root/home partition: "
read -r rootpartition
mkfs.ext4 "$rootpartition"

# Mounting filesystems
mount "$rootpartition" /mnt
mkdir -p /mnt/boot
mount "$efipartition" /mnt/boot
swapon "$swappartition"

# Initial Install
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt > /mnt/etc/fstab

# Moving the rest of the script to the install and chrooting
sed '1,/^###part2$/d' install.sh > /mnt/install2.sh
chmod +x /mnt/install2.sh
arch-chroot /mnt ./install2.sh
exit



###part2



#!/bin/bash

# Setting things so things are faster
pacman -S --noconfirm sed git xdg-user-dirs
xdg-user-dirs-update
echo
print_success " All necessary packages installed successfully."

git clone https://aur.archlinux.org/yay
cd yay
makepkg -si

git clone https://aur.archlinux.org/paru
cd paru
makepkg -si

makej=$(nproc)
makel=$(expr "$(nproc)" + 1)
sed -i "s/^#MAKEFLAGS=\"-j2\"$/MAKEFLAGS=\"-j$makej -l$makel\"/" /etc/makepkg.conf

# Setting timezone stuff
ln -sf /usr/share/zoneinfo/US/Mountain /etc/localtime
hwclock --systohc

# Setting language stuff
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

# Setting hostname
clear
echo -ne "Enter your desired hostname (Name your computer): "
read -r hostname
echo "$hostname" > /etc/hostname

echo "127.0.0.1      localhost" >> /etc/hosts
echo "::1            localhost" >> /etc/hosts
echo "127.0.1.1      $hostname.localdomain $hostname" >> /etc/hosts

# First making of initcpio
mkinitcpio -P

# Installing systemd-boot 
bootctl install

# Systemd-boot pacman hook
mkdir -p /etc/pacman.d/hooks

echo "[Trigger]" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "Type = Package" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "Operation = Upgrade" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "Target = systemd" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "[Action]" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "Description = Gracefully upgrading systemd-boot..." >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "When = PostTransaction" >> /etc/pacman.d/hooks/100-systemd-boot.hook
echo "Exec = /usr/bin/systemctl restart systemd-boot-update.service" >> /etc/pacman.d/hooks/100-systemd-boot.hook

# Setting loader and entry files for systemd-boot
mkdir -p /boot/loader/entries

echo "timeout 0" >> /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.conf

clear
lsblk
echo -ne "Enter root partition: "
read -r rootpart

echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=$(blkid | grep $rootpart | awk '{print $2}' | sed 's/"//g') loglevel=3 audit=0 quiet rw" >> /boot/loader/entries/arch.conf

# Installing things i forgot in later scripts
pacman -S nnn mpd playerctl mpc ncmpcpp  \
          lolcat   nodejs 
           feh  bat exa 
          rclone rsync maim  noto-fonts noto-fonts-emoji 
          ttf-joypixels ttf-font-awesome  mpv   fzf gzip p7zip
