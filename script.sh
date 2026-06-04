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
  ghostty
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
  rsync
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
  terax-bin
)

flatpak_package_install=(
  com.github.neithern.g4music
  app.zen_browser.zen
  com.discordapp.Discord
  io.missioncenter.MissionCenter
  fr.handbrake.ghb
  dev.geopjr.Calligraphy
  io.ente.photos
  io.github.flattool.Warehouse
  io.github.anil_e.Codd
  com.github.tchx84.Flatseal
)

bun_package_install=(
  opencode-ai
  @google/gemini-cli
  @openai/codex
  @github/copilot
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

  (cd "$install_dir" && bun install)

  touch "$HOME/.config/tmux/tmux.conf"
  grep -qxF "$bind_line" "$HOME/.config/tmux/tmux.conf" || printf '\n# Raycast-style command palette\n%s\n' "$bind_line" >> "$HOME/.config/tmux/tmux.conf"

  touch "$HOME/.tmux.conf"
  grep -qxF 'source-file ~/.config/tmux/tmux.conf' "$HOME/.tmux.conf" || printf 'source-file ~/.config/tmux/tmux.conf\n' >> "$HOME/.tmux.conf"
}

setup_vscode_theme_hook() {
  local hook_dir="$HOME/.config/omarchy/hooks/post-boot.d"
  local hook_path="$hook_dir/vscode-theme"

  mkdir -p "$hook_dir"

  cat >"$hook_path" <<'VSCODE_THEME_HOOK'
#!/usr/bin/env bash
set -euo pipefail

SYSTEM_VSCODE="/opt/visual-studio-code"
LOCAL_VSCODE="$HOME/.local/opt/visual-studio-code-custom"
LOCAL_BIN="$HOME/.local/bin/code"
CSS_FILE="$HOME/.config/vscode/style.css"
JS_FILE="$HOME/.config/vscode/script.js"
DESKTOP_DIR="$HOME/.local/share/applications"

if [[ ! -d "$SYSTEM_VSCODE" || ! -f "$CSS_FILE" || ! -f "$JS_FILE" ]]; then
  exit 0
fi

mkdir -p "$(dirname "$LOCAL_VSCODE")" "$HOME/.local/bin" "$DESKTOP_DIR"
rsync -a --no-owner --no-group --delete "$SYSTEM_VSCODE/" "$LOCAL_VSCODE/"

/usr/bin/node <<'NODE'
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");

const home = process.env.HOME;
const htmlPath = path.join(home, ".local/opt/visual-studio-code-custom/resources/app/out/vs/code/electron-browser/workbench/workbench.html");
const cssPath = path.join(home, ".config/vscode/style.css");
const jsPath = path.join(home, ".config/vscode/script.js");
const id = crypto.randomUUID();
const dir = path.dirname(htmlPath);
const backupPath = path.join(dir, `workbench.${id}.bak-custom-css`);
const tmpPath = path.join(dir, `workbench.${id}.tmp-custom-css`);

let html = fs.readFileSync(htmlPath, "utf8");
html = html.replace(/<!-- !! VSCODE-CUSTOM-CSS-START !! -->[\s\S]*?<!-- !! VSCODE-CUSTOM-CSS-END !! -->\n*/g, "");
html = html.replace(/<!-- !! VSCODE-CUSTOM-CSS-SESSION-ID [\w-]+ !! -->\n*/g, "");
html = html.replace(/<script>\/\* eslint-env browser \*\/[\s\S]*?__CUSTOM_CSS_JS_INDICATOR_CLS[\s\S]*?<\/script>\n*/g, "");
fs.writeFileSync(backupPath, html, "utf8");

const css = fs.readFileSync(cssPath, "utf8");
const js = fs.readFileSync(jsPath, "utf8");
html = html.replace(/<meta\s+http-equiv="Content-Security-Policy"[\s\S]*?\/>/, "");
html = html.replace(
  /<\/head>/,
  `<!-- !! VSCODE-CUSTOM-CSS-SESSION-ID ${id} !! -->\n` +
    "<!-- !! VSCODE-CUSTOM-CSS-START !! -->\n" +
    `<style>${css}</style><script>${js}</script>` +
    "<!-- !! VSCODE-CUSTOM-CSS-END !! -->\n</head>"
);

fs.writeFileSync(tmpPath, html, "utf8");
fs.renameSync(tmpPath, htmlPath);
NODE

cat >"$LOCAL_BIN" <<EOF
#!/usr/bin/env bash
exec "$LOCAL_VSCODE/bin/code" "\$@"
EOF
chmod +x "$LOCAL_BIN"

cat >"$DESKTOP_DIR/code.desktop" <<EOF
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$LOCAL_BIN %F
Icon=visual-studio-code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=TextEditor;Development;IDE;
MimeType=application/x-code-workspace;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=$LOCAL_BIN --new-window %F
Icon=visual-studio-code
EOF

cat >"$DESKTOP_DIR/code-url-handler.desktop" <<EOF
[Desktop Entry]
Name=Visual Studio Code - URL Handler
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$LOCAL_BIN --open-url %U
Icon=visual-studio-code
Type=Application
NoDisplay=true
StartupNotify=true
Categories=Utility;TextEditor;Development;IDE;
MimeType=x-scheme-handler/vscode;
Keywords=vscode;
EOF

update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
VSCODE_THEME_HOOK

  chmod +x "$hook_path"
  "$hook_path"
}

setup_xdph_no_picker() {
  local picker_path="$HOME/.local/bin/xdph-no-picker"
  local xdph_conf="$HOME/.config/hypr/xdph.conf"

  mkdir -p "$HOME/.local/bin" "$HOME/.config/hypr"

  cat >"$picker_path" <<'XDPH_NO_PICKER'
#!/usr/bin/env bash
exit 1
XDPH_NO_PICKER
  chmod +x "$picker_path"

  cat >"$xdph_conf" <<EOF
screencopy {
    allow_token_by_default = true
    custom_picker_binary = $picker_path
}
EOF

  systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service 2>/dev/null || true
}

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

gsettings set org.gtk.gtk4.Settings.Debug enable-inspector-keybinding false
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding false

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

omarchy-font-set "FiraCode Nerd Font"
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme

git clone https://github.com/ESHAYAT102/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
cd ..
rm -rf dotfiles

setup_xdph_no_picker
setup_vscode_theme_hook
