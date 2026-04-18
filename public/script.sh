#!/bin/bash

clear
sudo pacman -Syu --noconfirm
sudo pacman -R --noconfirm 1password-cli 1password-beta kdenlive limine-snapper-sync signal-desktop xournalpp typora mako swayosd libreoffice-fresh
rm -rf ~/.local/share/omarchy/applications/typora.desktop
sudo pacman -S --noconfirm flatpak fish tmux ghostty 7zip yazi btop tree tldr bat thefuck kew swaync nano cava go cpio cmake cmatrix stow lib32-mesa lib32-vulkan-intel vulkan-intel visual-studio-code-bin glow vhs skate shotwell zip unzip wget curl speedtest-cli vlc hyprshot ttf-firacode-nerd ttf-cascadia-code ttf-iosevka-nerd
yay -S --noconfirm vicinae-bin tty-clock spicetify-cli crush-bin nautilus-backspace hyprmoncfg t3code-bin charm-pop-bin
spicetify backup apply
flatpak install --or-update com.github.neithern.g4music app.zen_browser.zen com.discordapp.Discord io.missioncenter.MissionCenter com.getpostman.Postman fr.handbrake.ghb -y
xdg-settings set default-web-browser app.zen_browser.zen.desktop
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/https
xdg-mime default app.zen_browser.zen.desktop text/html
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "" >> "$HOME/.config/fish/config.fish"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.config/fish/config.fish"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify backup apply
curl -fsSL https://bun.sh/install | bash
curl -fsSL https://gh.io/copilot-install | bash
curl -fsSL https://opencode.ai/install | bash
bun i -g @google/gemini-cli @openai/codex git-open
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
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme
git clone https://github.com/ESHAYAT102/fonts.git
cd fonts
mv ./* ~/.local/share/fonts/
cd ..
rm -rf fonts
cd ~/.config/
git clone https://github.com/BlueManCZ/hyprmod.git
cd hyprmod
uv sync
cd ~
git clone https://github.com/ESHAYAT102/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
cd ..
rm -rf dotfiles
