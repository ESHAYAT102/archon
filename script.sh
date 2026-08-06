#!/bin/bash

print_logo() {
    cat << "EOF"
 _______             __                
|   _   |.----.----.|  |--.-----.-----.
|       ||   _|  __||     |  _  |     |
|___|___||__| |____||__|__|_____|__|__| by Eshayat
                                        
Be sure to be logged in to the Spotify app before continuing; Spicetify requires an active Spotify login.
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
  omarchy-dev
  flatpak
  zsh
  ghostty
  7zip
  yazi
  tree
  cliphist
  libqalculate
  thefuck
  kew
  swaync
  tailscale
  polkit-gnome
  qrencode
  libnotify
  playerctl
  upower
  hypridle
  hyprlock
  satty
  scrcpy
  nano
  cava
  go
  cpio
  cmake
  cmatrix
  asciiquarium
  lib32-mesa
  lib32-vulkan-intel
  visual-studio-code-bin
  glow
  vhs
  skate
  shotwell
  zip
  wget
  curl
  nodejs
  rsync
  speedtest-cli
  vlc
  hyprshot
  uv
  python-cairo
  gtk-layer-shell
  ttf-firacode-nerd
  ttf-cascadia-code
  ttf-iosevka-nerd
)

yay_package_install=(
  quickshell-git
  caelestia-cli
  caelestia-shell
  zen-browser-bin
  voxtype-bin
  spotify
  vicinae-bin
  tty-clock
  crush-bin
  nautilus-backspace
  hyprmoncfg
  t3code-nightly-bin
  charm-pop-bin
  terax-bin
)

flatpak_package_install=(
  com.discordapp.Discord
  io.missioncenter.MissionCenter
  # com.github.neithern.g4music
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
  greptile
  opencode-ai
  t3
)

install_dotfiles() {
  local dotfiles_dir="$HOME/Documents/dotfiles"

  mkdir -p "$HOME/Documents"

  if [[ -d $dotfiles_dir/.git ]]; then
    git -C "$dotfiles_dir" pull --ff-only
  elif [[ -e $dotfiles_dir ]]; then
    echo "Cannot install dotfiles: $dotfiles_dir exists but is not a Git checkout." >&2
    return 1
  else
    git clone https://github.com/ESHAYAT102/dotfiles.git "$dotfiles_dir"
  fi

  chmod +x "$dotfiles_dir/install.sh"
  "$dotfiles_dir/install.sh" --all
}

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

configure_microphone() {
  local alsa_card

  for _ in {1..10}; do
    wpctl inspect @DEFAULT_AUDIO_SOURCE@ >/dev/null 2>&1 && break
    sleep 1
  done

  if ! wpctl inspect @DEFAULT_AUDIO_SOURCE@ >/dev/null 2>&1; then
    echo "Skipping microphone setup: no default PipeWire input is available."
    return
  fi

  alsa_card="$(wpctl inspect @DEFAULT_AUDIO_SOURCE@ | sed -n 's/^[[:space:]]*alsa\.card = "\([0-9][0-9]*\)"$/\1/p' | head -n 1)"

  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0

  if [[ -n $alsa_card ]] && amixer -c "$alsa_card" sget 'Internal Mic Boost' >/dev/null 2>&1; then
    amixer -c "$alsa_card" sset 'Internal Mic Boost' 1 >/dev/null
  else
    echo "Skipping internal microphone boost setup: the control was not found."
  fi

  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.50
}

clear
print_logo

sudo pacman -Syu --noconfirm

# Drop stale user copies that would shadow the upgraded Omarchy commands.
for legacy_command in "$HOME/.local/share/omarchy/bin"/omarchy*; do
  [[ -e $legacy_command ]] || continue
  [[ -f /usr/share/omarchy/bin/${legacy_command##*/} ]] && rm -f "$legacy_command"
done
hash -r

omarchy-install-zed

for package in "${pacman_packages_remove[@]}"; do
  pacman -Q "$package" >/dev/null 2>&1 || continue
  sudo pacman -R --noconfirm "$package"
done

for package in "${pacman_packages_install[@]}"; do
  sudo pacman -S --needed --noconfirm "$package"
done

for package in "${yay_package_install[@]}"; do
  yay -S --needed --noconfirm "$package"
done

sudo systemctl enable --now tailscaled

mkdir -p "$HOME/.config/voxtype"
cp /usr/share/omarchy/default/voxtype/config.toml "$HOME/.config/voxtype/config.toml"
sed -i 's/^mode = "type"$/mode = "clipboard"/' "$HOME/.config/voxtype/config.toml"
voxtype setup --download --no-post-install
if omarchy-hw-vulkan; then
  voxtype setup gpu --enable || true
fi
voxtype setup systemd

export FLATPAK_SELF_UPDATE_MODE=check
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
for package in "${flatpak_package_install[@]}"; do
  flatpak install --system -y --or-update "$package"
done

env -u BROWSER xdg-settings set default-web-browser zen.desktop
xdg-mime default zen.desktop x-scheme-handler/http
xdg-mime default zen.desktop x-scheme-handler/https
xdg-mime default zen.desktop text/html
chsh -s "$(command -v zsh)"

gsettings set org.gtk.gtk4.Settings.Debug enable-inspector-keybinding false
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding false

curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify restore backup apply

curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/skater/main/scripts/install.sh | sh

curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/vicinae-confetti-extension/refs/heads/master/install.sh | bash

curl -fsSL https://herdr.dev/install.sh | sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> "$HOME/.zshrc"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> "$HOME/.zshrc"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
sudo pacman -S --needed --noconfirm bubblewrap
for package in "${brew_package_install[@]}"; do
  brew install "$package"
done

for package in "${bun_package_install[@]}"; do
  bun i -g "$package"
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

git clone https://github.com/vinceliuice/MacTahoe-gtk-theme.git
cd MacTahoe-gtk-theme
./install.sh -b -l -t purple -f
./tweaks.sh -f
./tweaks.sh --flatpak -o normal -c dark -t purple
cd ..
rm -rf MacTahoe-gtk-theme

git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git
cd MacTahoe-icon-theme
./install.sh -t purple
cd cursors
sudo ./install.sh
cd ../..
rm -rf MacTahoe-icon-theme

gsettings set org.gnome.desktop.interface cursor-theme 'MacTahoe'
gsettings set org.gnome.desktop.interface cursor-size 28
gsettings set org.gnome.desktop.interface icon-theme 'MacTahoe-purple-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'MacTahoe-Dark-purple'

sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0

omarchy-font-set "FiraCode Nerd Font"
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme

install_dotfiles

rm -rf ~/.local/share/omarchy/applications/typora.desktop
rm -rf ~/.local/share/applications/typora.desktop

configure_microphone
