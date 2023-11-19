#!/bin/bash

# Update system and install necessary packages
yay -Syu --noconfirm ttf-sora zenity thefuck python-ansicolors lsd sox \
ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font \
ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa \
ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd python-pipx \
adobe-source-code-pro-fonts tidy mpd mpc python-pip \
pixman pango cairo mailspring emote \
aria2 udiskie udisks2 python-pip picom jq cantata \
ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa \
ttf-jetbrains-mono ttf-icomoon-feather xdg-desktop-portal-hyprland-git \
ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd \
ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font \
parallel socat starship \
otf-sora neovim eww-wayland \
ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font \
ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa \
ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd \
adobe-source-code-pro-fonts ttf-ms-win11-auto adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts \
ttf-jetbrains-mono otf-font-awesome nerd-fonts-sf-mono \
otf-nerd-fonts-monacob-mono ttf-font-awesome light brillo \
mint-themes yad impression \
fish spicetify zsh playerctl spotify noise-suppression-for-voice \
exa spotify-adblock-git tumbler \
oh-my-zsh spicetify-themes-git util-linux-libs \
zsh-theme-powerlevel10k compiler-rt \
zsh-syntax-highlighting python-compile blueman-applet \
zsh-autosuggestions spicetify-marketplace-bin \
pokemon-colorscripts-git genius-spicetify-git

# Enable TRIM
sudo systemctl enable fstrim.timer

# Clone and install Proxzima Plymouth theme
git clone https://aur.archlinux.org/proxzima-plymouth-git.git && cd proxzima-plymouth && sudo cp -r proxzima /usr/share/plymouth/themes && sudo plymouth-set-default-theme -R proxzima

# Enable Plymouth
sudo systemctl enable plymouth

# Download and install Nerd Font
curl -fLo "<FONT_NAME> Nerd Font Complete.otf" \
https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/<FONT_PATH>/complete/<FONT_NAME>%20Nerd%20Font%20Complete.otf
