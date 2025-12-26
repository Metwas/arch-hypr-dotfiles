#!/bin/bash

curl -L -O https://github.com/Metwas/arch-hypr-dotfiles/archive/refs/heads/main.zip
sudo unzip ./main.zip
sudo cp -r ./arch-hypr-dotfiles-main/* ./
sudo cp -r ./arch-hypr-dotfiles-main/.* ./

sudo rm -rf ./arch-hypr-dotfiles-main
sudo rm ./main.zip

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# autostart hyprland
sudo cat <<EOF | sudo tee ~/.zprofile
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec Hyprland
fi
EOF
