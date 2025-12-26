#!/bin/bash

# YAY
git clone https://aur.archlinux.org/yay-bin.git
cd ./yay-bin
sudo makepkg -si

sudo cat <<EOF | sudo tee /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
EOF

sudo mkdir /boot/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo mkdir /etc/systemd/getty@tty1.service.d

sudo cat <<EOF | sudo tee /etc/systemd/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin metwas %I $TERM
EOF

# Drivers
sudo pacman -S --noconfirm mesa
sudo pacman -S --noconfirm xf86-video-amdgpu
sudo pacman -S --noconfirm vulkan-radeon
sudo pacman -S --noconfirm libva-mesa-driver

# Apps
yay -S --noconfirm thorium-browser-bin
yay -S --noconfirm zed
yay -S --noconfirm esp-idf
yay -S --noconfirm cava
yay -S --noconfirm yazi
yay -S --noconfirm hollywood
yay -S --noconfirm tty-clock

# ZED custom THEME
sudo mkdir ./.config/zed
sudo mkdir ./.config/zed/themes
git clone https://github.com/Metwas/nightfox.zed.git ./.config/zed/themes

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Restart
sudo systemctl daemon-reexec
