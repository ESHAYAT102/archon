#!/bin/bash

clear

MUTED='\033[0;2m'
NC='\033[0m'

echo -e "${MUTED}█▀▀▀ █▀▀▀ █  █ ${NC}█▀▀█ █  █ █▀▀█ ▀▀█▀▀"
echo -e "${MUTED}█▀▀  ▀▀▀█ █▀▀█ ${NC}█▀▀█ ▀▀▀█ █▀▀█   █ "
echo -e "${MUTED}▀▀▀▀ ▀▀▀▀ ▀  ▀ ${NC}▀  ▀ ▀▀▀▀ ▀  ▀   ▀ "


echo "--- Removing selected packages..."
sudo pacman -R --noconfirm 1password-cli 1password-beta kdenline limine-snapper-sync signal-desktop xournalpp typora

echo "--- Updating system packages..."
sudo pacman -Syu --noconfirm

echo "--- Installing core packages..."
sudo pacman -S --noconfirm flatpak fish tmux ghostty 7zip yazi btop tree cava cmatrix stow lib32-mesa lib32-vulkan-intel vulkan-intel visual-studio-code-bin glow vhs shotwell zip unzip wget curl vlc hyprshot ttf-firacode-nerd ttf-cascadia-code
yay -S --noconfirm vicinae-bin

echo "--- Installing Flatpak applications..."
flatpak install --or-update com.github.neithern.g4music app.zen_browser.zen com.discordapp.Discord io.missioncenter.MissionCenter com.getpostman.Postman fr.handbrake.ghb -y

echo "--- Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "" >> "$HOME/.config/fish/config.fish"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.config/fish/config.fish"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "--- Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "--- Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo "--- Installing OpenCode..."
curl -fsSL https://opencode.ai/install | bash

echo "--- Changing default shell to Fish..."
chsh -s /usr/bin/fish

echo "--- Configuring global Git settings..."
git config --global init.defaultBranch main
git config --global --replace-all credential.helper store

echo "--- Setting up TMUX..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "--- Installing Pomo..."
git clone https://github.com/Bahaaio/pomo
cd pomo
go build .
sudo mv pomo /usr/local/bin/
cd ..
rm -rf pomo

echo "--- Installing Stormy..."
git clone https://github.com/ashish0kumar/stormy.git
cd stormy
go build
sudo mv stormy /usr/local/bin/
cd ..
rm -rf stormy

echo "--- Installing Omarchy Themes..."
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-green-theme
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mauve-theme

echo "--- Installing Magilio Font..."
git clone https://github.com/ESHAYAT102/magilio-font.git
cd magilio-font
mv Magilio.ttf ~/.local/fonts/
cd ..
rm -rf magilio-font

echo "--- Setting up dotfiles..."
curl -s https://archon.eshayat.com/dotfiles.sh | bash

echo "--- Script finished! Please reboot."
