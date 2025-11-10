#!/bin/bash

# --- START OF SCRIPT ---

# Clear terminal screen
clear

# 1. REMOVE unwanted packages
echo "--- Removing selected packages..."
sudo pacman -R --noconfirm 1password-cli 1password-beta kdenline limine-snapper-sync signal-desktop xournalpp

# 2. UPDATE system
echo "--- Updating system packages..."
sudo pacman -Syu --noconfirm

# 3. INSTALL core packages
echo "--- Installing core packages..."
sudo pacman -S --noconfirm flatpak fish ghostty btop cava cmatrix stow lib32-mesa lib32-vulkan-intel vulkan-intel visual-studio-code-bin cursor-bin glow vhs shotwell zip unzip wget curl vlc hyprshot ttf-firacode-nerd ttf-cascadia-code

# 4. INSTALL git-credential-manager-bin (using yay)
echo "--- Installing git-credential-manager-bin via yay..."
yay -S --noconfirm git-credential-manager-bin

# 5. INSTALL Flatpak applications
echo "--- Installing Flatpak applications..."
flatpak install --or-update com.github.neithern.g4music app.zen_browser.zen com.discordapp.Discord io.missioncenter.MissionCenter -y

# 6. INSTALL Homebrew (and configure Fish shell)
echo "--- Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# NOTE: The $HOME variable automatically resolves to the current user's home directory.

# Add an empty line to config.fish (using the portable $HOME path)
echo "" >> "$HOME/.config/fish/config.fish"

# Append the Homebrew shell environment command to config.fish (using the portable $HOME path)
# The full path to brew is used here as it's the standard install location for Linuxbrew
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.config/fish/config.fish"

# Evaluate the Homebrew environment in the current script session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 7. INSTALL Ollama
echo "--- Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# 8. SET Fish as the default shell
echo "--- Changing default shell to Fish..."
chsh -s /usr/bin/fish

# 9. CONFIGURE Git
echo "--- Configuring global Git settings..."
git config --global init.defaultBranch main
git config --global --unset-all credential.helper
git config --global --get-all credential.helper

# 10. CONFIGURE Git Credential Manager
echo "--- Configuring Git Credential Manager..."
git-credential-manager configure

echo "--- Script finished! Please restart your terminal session for Fish shell and Homebrew changes to take effect. ---"
# --- END OF SCRIPT ---
