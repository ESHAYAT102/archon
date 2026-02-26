#!/bin/bash

clear
sudo pacman -Syu --noconfirm
sudo pacman -R --noconfirm 1password-cli 1password-beta kdenlive limine-snapper-sync signal-desktop xournalpp typora mako swayosd
rm -rf ~/.local/share/omarchy/applications/typora.desktop
sudo pacman -S --noconfirm flatpak fish tmux ghostty 7zip yazi btop tree tldr bat thefuck kew swaync nano cava go cpio cmake cmatrix stow element-desktop lib32-mesa lib32-vulkan-intel vulkan-intel visual-studio-code-bin glow vhs skate shotwell zip unzip wget curl vlc hyprshot ttf-firacode-nerd ttf-cascadia-code ttf-iosevka-nerd
yay -S --noconfirm vicinae-bin tty-clock snappy-switcher
flatpak install --or-update com.github.neithern.g4music app.zen_browser.zen com.discordapp.Discord io.missioncenter.MissionCenter com.getpostman.Postman fr.handbrake.ghb -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "" >> "$HOME/.config/fish/config.fish"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.config/fish/config.fish"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
spicetify backup apply
curl -fsSL https://bun.sh/install | bash
bun i -g @charmland/crush opencode-ai @github/copilot @google/gemini-cli @openai/codex
chsh -s /usr/bin/fish
git config --global init.defaultBranch main
git config --global --replace-all credential.helper store
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/Bahaaio/pomo
cd pomo
go build .
sudo mv pomo /usr/local/bin/
cd ..
rm -rf pomo
git clone https://github.com/ashish0kumar/stormy.git
cd stormy
go build
sudo mv stormy /usr/local/bin/
cd ..
rm -rf stormy
curl -fsSL https://getjolt.sh/install.sh | bash
curl -fsS https://dl.brave.com/install.sh | CHANNEL=nightly sh
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mauve-theme
git clone https://github.com/ESHAYAT102/fonts.git
cd fonts
mv ./* ~/.local/share/fonts/
cd ..
rm -rf fonts
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/zakk4223/hyprland-easymotion
hyprpm enable hyprscrolling
hyprpm enable hyprEasymotion
git clone https://github.com/ESHAYAT102/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
cd ..
rm -rf dotfiles
