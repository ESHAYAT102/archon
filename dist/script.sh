#!/bin/bash

clear

sudo pacman -R --noconfirm 1password-cli 1password-beta kdenline limine-snapper-sync signal-desktop

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm flatpak fish ghostty btop cava cmatrix stow lib32-mesa lib32-vulkan-intel vulkan-intel visual-studio-code-bin cursor-bin glow vhs shotwell zip unzip wget curl vlc hyprshot ttf-firacode-nerd ttf-cascadia-code

yay -S --noconfirm git-credential-manager-bin

flatpak install com.github.neithern.g4music app.zen_browser.zen com.discordapp.Discord io.missioncenter.MissionCenter

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

chsh -s /usr/bin/fish

git config --global init.defaultBranch main

git config --global --unset-all credential.helper

git config --global --get-all credential.helper

git-credential-manager configure
