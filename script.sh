#!/bin/bash

print_logo() {
    cat << "EOF"
 _______             __                
|   _   |.----.----.|  |--.-----.-----.
|       ||   _|  __||     |  _  |     |
|___|___||__| |____||__|__|_____|__|__|
                                       
EOF
}

pacman_packages_remove=(
  1password-cli
  1password-beta
  kdenlive
  limine-snapper-sync
  signal-desktop
  xournalpp
  typora
  mako
  swayosd
  libreoffice-fresh
)

pacman_packages_install=(
  flatpak
  fish
  tmux
  7zip
  yazi
  btop
  tree
  tldr
  bat
  thefuck
  kew
  swaync
  nano
  cava
  go
  cpio
  cmake
  cmatrix
  stow
  lib32-mesa
  lib32-vulkan-intel
  vulkan-intel
  visual-studio-code-bin
  glow
  vhs
  skate
  shotwell
  zip
  unzip
  wget
  curl
  speedtest-cli
  vlc
  hyprshot
  uv
  ttf-firacode-nerd
  ttf-cascadia-code
  ttf-iosevka-nerd
)

yay_package_install=(
  vicinae-bin
  tty-clock
  crush-bin
  nautilus-backspace
  hyprmoncfg
  t3code-bin
  charm-pop-bin
)

flatpak_package_install=(
  com.github.neithern.g4music
  app.zen_browser.zen
  com.discordapp.Discord
  io.missioncenter.MissionCenter
  fr.handbrake.ghb
  dev.geopjr.Calligraphy
)

bun_package_install=(
  opencode-ai
  @google/gemini-cli
  @openai/codex
  @github/copilot
  git-open
  port-whisperer
  localterm
)

clear
print_logo

sudo pacman -Syu --noconfirm

for package in ${pacman_packages_remove[@]}; do
  sudo pacman -R --noconfirm ${package}
done
rm -rf ~/.local/share/omarchy/applications/typora.desktop

for package in ${pacman_packages_install[@]}; do
  sudo pacman -S --noconfirm ${package}
done

for package in ${yay_package_install[@]}; do
  yay -S --noconfirm ${package}
done

export FLATPAK_SELF_UPDATE_MODE=check
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
for package in ${flatpak_package_install[@]}; do
  flatpak install --system -y --or-update ${package}
done

xdg-settings set default-web-browser app.zen_browser.zen.desktop
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/https
xdg-mime default app.zen_browser.zen.desktop text/html
chsh -s /usr/bin/fish

curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify restore backup apply

curl -fsSL https://getjolt.sh/install.sh | bash

curl -fsSL https://bun.sh/install | bash
for package in ${bun_package_install[@]}; do
  bun i -g ${package}
done

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

git clone https://github.com/ESHAYAT102/vicinae-codex-extension.git
cd vicinae-codex-extension
bun i
bun run build
cd ..
rm -rf vicinae-codex-extension

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

omarchy-font-set "FiraCode Nerd Font"
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme

git clone https://github.com/ESHAYAT102/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
cd ..
rm -rf dotfiles
