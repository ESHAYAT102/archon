#!/bin/bash

print_logo() {
    cat << "EOF"
 _______             __                
|   _   |.----.----.|  |--.-----.-----.
|       ||   _|  __||     |  _  |     |
|___|___||__| |____||__|__|_____|__|__| by Eshayat
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
  claude-code
)

pacman_packages_install=(
  flatpak
  fish
  ghostty
  tmux
  7zip
  yazi
  tree
  tldr
  bat
  thefuck
  kew
  tailscale
  hypridle
  jq
  wtype
  cava
  cpio
  cmake
  cmatrix
  asciiquarium
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
  nodejs
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
  hyprmoncfg
  t3code-nightly-bin
  charm-pop-bin
  terax-bin
)

flatpak_package_install=(
  com.discordapp.Discord
  # app.zen_browser.zen
  # com.github.neithern.g4music
  # io.missioncenter.MissionCenter
  # fr.handbrake.ghb
  # dev.geopjr.Calligraphy
  # io.ente.photos
  # io.github.flattool.Warehouse
  # io.github.anil_e.Codd
  # com.github.tchx84.Flatseal
)

brew_package_install=(
  codex
  opencode
  bun
  gh
)

bun_package_install=(
  @esyt/milo
  @esyt/moonify
  @gitlawb/openclaude@latest
  @juliusbrussee/caveman-code
  git-open
  port-whisperer
  pake-cli
  localterm
  pnpm
)

setup_tmux_palette() {
  local install_dir="$HOME/.config/tmux/tmux-palette"
  local bind_line="bind -n C-p run-shell \"$install_dir/bin/tmux-palette.sh\""

  mkdir -p "$HOME/.config/tmux"

  if [ -d "$install_dir/.git" ]; then
    git -C "$install_dir" pull
  else
    rm -rf "$install_dir"
    git clone https://github.com/eduwass/tmux-palette "$install_dir"
  fi

  (cd "$install_dir" && bun i)

  touch "$HOME/.config/tmux/tmux.conf"
  grep -qxF "$bind_line" "$HOME/.config/tmux/tmux.conf" || printf '\n# Raycast-style command palette\n%s\n' "$bind_line" >> "$HOME/.config/tmux/tmux.conf"

  touch "$HOME/.tmux.conf"
  grep -qxF 'source-file ~/.config/tmux/tmux.conf' "$HOME/.tmux.conf" || printf 'source-file ~/.config/tmux/tmux.conf\n' >> "$HOME/.tmux.conf"
}

clear
print_logo

sudo pacman -Syu --noconfirm

omarchy-install-zed

for package in ${pacman_packages_remove[@]}; do
  sudo pacman -R --noconfirm ${package}
done

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

chsh -s /usr/bin/fish

curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify restore backup apply

curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/skater/main/scripts/install.sh | sh

curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/vicinae-confetti-extension/refs/heads/master/install.sh | bash

curl -fsSL https://bun.sh/install | bash
for package in ${bun_package_install[@]}; do
  bun i -g ${package}
done

bunx skills add jakubkrehel/make-interfaces-feel-better
codex plugin marketplace add DietrichGebert/ponytail

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
setup_tmux_palette

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

git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git
cd MacTahoe-icon-theme/cursors
sudo ./install.sh
cd ../..
rm -rf MacTahoe-icon-theme

gsettings set org.gnome.desktop.interface cursor-theme 'MacTahoe'
gsettings set org.gnome.desktop.interface cursor-size 28

omarchy-font-set "FiraCode Nerd Font"
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme

git clone https://github.com/ESHAYAT102/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
cd ..
rm -rf dotfiles

rm -rf ~/.local/share/omarchy/applications/typora.desktop
rm -rf ~/.local/share/applications/typora.desktop
