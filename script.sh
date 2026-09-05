#!/bin/bash

print_logo() {
    cat << "EOF"
 _______             __                
|   _   |.----.----.|  |--.-----.-----.
|       ||   _|  __||     |  _  |     |
|___|___||__| |____||__|__|_____|__|__| by Eshayat

  Make sure you are logged in to your Spotify account in the Spotify app.
  Spicetify will not work without an active Spotify session.
EOF
}

pacman_packages_install=(
  flatpak
  fish
  ghostty
  gtk-layer-shell
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

setup_try() {
  local try_rb="/usr/lib/tobi-try/try.rb"
  local patch_file="$(mktemp)"
  local zshrc="$HOME/.zshrc"
  local dot_zshrc="$HOME/Documents/dotfiles/config/zsh/.zshrc"

  sudo pacman -S --needed --noconfirm tobi-try

  cat > "$patch_file" << 'PATCH_EOF'
--- pristine.rb	2026-08-17 05:43:35.511887891 +0600
+++ try.rb	2026-08-17 05:34:25.766011821 +0600
@@ -7,6 +7,17 @@
 require_relative 'lib/tui'
 require_relative 'lib/fuzzy'
 
+# Date prefix for generated names; disabled with TRY_NO_DATE=1
+def date_prefix
+  return "" if ENV['TRY_NO_DATE'] == '1'
+  Time.now.strftime("%Y-%m-%d")
+end
+
+def prefixed_name(base)
+  prefix = date_prefix
+  prefix.empty? ? base : "#{prefix}-#{base}"
+end
+
 class TrySelector
   include Tui::Helpers
   TRY_PATH = ENV['TRY_PATH'] || File.expand_path("~/src/tries")
@@ -419,11 +430,10 @@
     background = is_selected ? Tui::Palette::SELECTED_BG : nil
     line = screen.body.add_line(background: background)
     line.write << (is_selected ? Tui::Text.highlight("→ ") : "  ")
-    date_prefix = Time.now.strftime("%Y-%m-%d")
     label = if @input_buffer.empty?
-      "📂 Create new: #{date_prefix}-"
+      "📂 Create new: #{prefixed_name('')}"
     else
-      "📂 Create new: #{date_prefix}-#{@input_buffer}"
+      "📂 Create new: #{prefixed_name(@input_buffer)}"
     end
     line.write << label
   end
@@ -774,11 +784,10 @@
 
   def handle_create_new
     # Create new try directory
-    date_prefix = Time.now.strftime("%Y-%m-%d")
 
     # If user already typed a name, use it directly
     if !@input_buffer.empty?
-      final_name = "#{date_prefix}-#{@input_buffer}".gsub(/\s+/, '-')
+      final_name = prefixed_name(@input_buffer).gsub(/\s+/, '-')
       full_path = File.join(@base_path, final_name)
       @selected = { type: :mkdir, path: full_path }
     else
@@ -789,7 +798,7 @@
         show_cursor
         STDERR.puts "Enter new try name"
         STDERR.puts
-        STDERR.print("> #{date_prefix}-")
+        STDERR.print("> #{prefixed_name('')}")
         STDERR.flush
 
         STDERR.cooked do
@@ -802,7 +811,7 @@
 
       return if entry.nil? || entry.empty?
 
-      final_name = "#{date_prefix}-#{entry}".gsub(/\s+/, '-')
+      final_name = prefixed_name(entry).gsub(/\s+/, '-')
       full_path = File.join(@base_path, final_name)
 
       @selected = { type: :mkdir, path: full_path }
@@ -1058,8 +1067,7 @@
     parsed = parse_git_uri(git_uri)
     return nil unless parsed
 
-    date_prefix = Time.now.strftime("%Y-%m-%d")
-    "#{date_prefix}-#{parsed[:user]}-#{parsed[:repo]}"
+    prefixed_name("#{parsed[:user]}-#{parsed[:repo]}")
   end
 
   def is_git_uri?(arg)
@@ -1216,9 +1224,8 @@
       else
         File.basename(repo_dir)
       end
-      date_prefix = Time.now.strftime("%Y-%m-%d")
-      base = resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-      full_path = File.join(tries_path, "#{date_prefix}-#{base}")
+      base = resolve_unique_name_with_versioning(tries_path, base)
+      full_path = File.join(tries_path, prefixed_name(base))
       # Use worktree if .git exists (file in worktrees, directory in regular repos)
       if File.exist?(File.join(repo_dir, '.git'))
         return script_worktree(full_path, repo_dir)
@@ -1363,8 +1370,9 @@
   # If the given base ends with digits and today's dir already exists,
   # bump the trailing number to the next available one for today.
   # Otherwise, fall back to unique_dir_name with -2, -3 suffixes.
-  def resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-    initial = "#{date_prefix}-#{base}"
+  def resolve_unique_name_with_versioning(tries_path, base)
+    prefix = date_prefix
+    initial = prefixed_name(base)
     return base unless Dir.exist?(File.join(tries_path, initial))
 
     m = base.match(/^(.*?)(\d+)$/)
@@ -1373,13 +1381,13 @@
       candidate_num = n + 1
       loop do
         candidate_base = "#{stem}#{candidate_num}"
-        candidate_full = File.join(tries_path, "#{date_prefix}-#{candidate_base}")
+        candidate_full = File.join(tries_path, prefixed_name(candidate_base))
         return candidate_base unless Dir.exist?(candidate_full)
         candidate_num += 1
       end
     else
       # No numeric suffix; use -2 style uniqueness on full name
-      return unique_dir_name(tries_path, "#{date_prefix}-#{base}").sub(/^#{Regexp.escape(date_prefix)}-/, '')
+      unique_dir_name(tries_path, prefixed_name(base)).sub(/^#{prefix}-/, '')
     end
   end
 
@@ -1400,9 +1408,8 @@
     else
       begin; File.basename(File.realpath(repo_dir)); rescue; File.basename(repo_dir); end
     end
-    date_prefix = Time.now.strftime("%Y-%m-%d")
-    base = resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-    File.join(tries_path, "#{date_prefix}-#{base}")
+    base = resolve_unique_name_with_versioning(tries_path, base)
+    File.join(tries_path, prefixed_name(base))
   end
 
   case command
PATCH_EOF

  if [ -f "$try_rb" ]; then
    if grep -q "TRY_NO_DATE" "$try_rb"; then
      echo "try: already patched (TRY_NO_DATE supported)"
    elif sudo patch -d /usr/lib/tobi-try -p0 --forward -s < "$patch_file"; then
      echo "try: patched /usr/lib/tobi-try/try.rb to support TRY_NO_DATE"
    else
      sudo rm -f /usr/lib/tobi-try/try.rb.rej /usr/lib/tobi-try/try.rb.orig
      echo "try: WARNING could not apply patch (tobi-try version may have changed)" >&2
    fi
  fi
  rm -f "$patch_file"

  for f in "$zshrc" "$dot_zshrc"; do
    [ -f "$f" ] || continue
    grep -qxF 'export TRY_NO_DATE=1' "$f" || printf 'export TRY_NO_DATE=1\n' >> "$f"
    grep -qxF 'eval "$(try init ~/Work/tries)"' "$f" || printf 'eval "$(try init ~/Work/tries)"\n' >> "$f"
  done
  echo "try: shell integration ensured in ~/.zshrc"
}

setup_emoji() {
  local script="/usr/share/omarchy/bin/omarchy-menu-emoji-insert"

  if [ ! -f "$script" ]; then
    echo "emoji: $script not found — skipping"
    return 0
  fi

  if grep -q 'wtype -M ctrl -k v -m ctrl' "$script"; then
    echo "emoji: already patched (Ctrl+V paste)"
    return 0
  fi

  sudo sed -i 's|wtype -M shift -k Insert -m shift|wtype -M ctrl -k v -m ctrl|' "$script"
  echo "emoji: patched omarchy-menu-emoji-insert — uses Ctrl+V instead of Shift+Insert"
}

setup_dictate() {
  local qml="/usr/share/omarchy/shell/plugins/bar/indicators/Dictation.qml"

  if [ ! -f "$qml" ]; then
    echo "dictate: $qml not found — skipping"
    return 0
  fi

  if grep -q 'voxtype record toggle' "$qml"; then
    echo "dictate: already patched (click toggles dictate)"
    return 0
  fi

  sudo sed -i 's|root.bar.run("omarchy-voxtype-config")|root.bar.run("voxtype record toggle")|' "$qml"
  echo "dictate: patched Dictation.qml — click now toggles dictate"
  omarchy restart shell 2>/dev/null || true
}

clear
print_logo

case "${1:-}" in
  --try)
setup_try
setup_emoji
    exit 0
    ;;
  --dictate)
    setup_dictate
    exit 0
    ;;
  --emoji)
    setup_emoji
    exit 0
    ;;
esac

sudo pacman -Syu --noconfirm

omarchy remove service 1password
omarchy webapp remove all
omarchy plugin add https://github.com/brianblakely/omanote.git --enable
omarchy plugin add https://github.com/GennaroRiccio/update-widget.git --enable
omarchy plugin add https://github.com/fernandomenolli/omarchy-sill.git --enable
omarchy plugin add https://github.com/sumdahl/omarchy-plugin-media.git --enable
omarchy plugin add https://github.com/ESHAYAT102/hide-icons-omarchy-plugin.git --enable
omarchy plugin add https://github.com/ESHAYAT102/ajazz-keyboard-omarchy-plugin.git --enable
sudo install -Dm644 "$HOME/.config/omarchy/plugins/esh.ajazz-keyboard/udev/70-ajazz-ak820.rules" /etc/udev/rules.d/70-ajazz-ak820.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

for package in ${pacman_packages_remove[@]}; do
  sudo pacman -R --noconfirm kdenlive limine-snapper-sync signal-desktop xournalpp typora mako swayosd libreoffice-fresh
done

omarchy install editor zed

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

git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git
cd MacTahoe-icon-theme/cursors
sudo ./install.sh
cd ../..
rm -rf MacTahoe-icon-theme

gsettings set org.gnome.desktop.interface cursor-theme 'MacTahoe'
gsettings set org.gnome.desktop.interface cursor-size 28

omarchy-font-set "FiraCode Nerd Font"
omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mocha-theme

git clone https://github.com/ESHAYAT102/dotfiles
cd ./dotfiles
chmod +x install.sh
./install.sh --all
cd ..
rm -rf ./dotfiles

rm -rf ~/.local/share/omarchy/applications/typora.desktop
rm -rf ~/.local/share/applications/typora.desktop

setup_try

