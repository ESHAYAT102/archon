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

omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-mauve-theme

omarchy-theme-install https://github.com/ESHAYAT102/omarchy-catppuccin-green-theme

cat > ~/.config/hypr/bindings.conf << 'EOT'
$terminal = uwsm app -- $TERMINAL

bindd = SUPER, L, Hyprlock, exec, hyprlock
bindd = SUPER SHIFT, L, Screensaver, exec, omarchy-launch-screensaver
bindd = SUPER, return, Terminal, exec, $terminal --working-directory="$(omarchy-cmd-terminal-cwd)"
bindd = SUPER, E, File manager, exec, uwsm app -- nautilus --new-window
bindd = SUPER, W, Browser, exec, flatpak run app.zen_browser.zen
bindd = SUPER, B, Brave Browser, exec, brave
bindd = SUPER, S, Music, exec, omarchy-launch-or-focus spotify
bindd = SUPER, T, Activity, exec, $terminal -e btop
bindd = SUPER SHIFT, T, Mission Center, exec, flatpak run io.missioncenter.MissionCenter
# bindd = SUPER, M, Minecraft, exec, java -jar /home/eshayat/Documents/minecraft.jar
bindd = SUPER, O, Obsidian, exec, omarchy-launch-or-focus obsidian "uwsm app -- obsidian -disable-gpu --enable-wayland-ime"
bindd = SUPER, C, Code Editor, exec, code
bindd = SUPER, Z, Zed, exec, zed
# bindd = SUPER, A, Steam, exec, steam
bindd = SUPER, G, Gapless, exec, flatpak run com.github.neithern.g4music
bindd = SUPER, D, Discord, exec, flatpak run com.discordapp.Discord
EOT

cat > ~/.config/hypr/hypridle.conf << 'EOT'
general {
    lock_cmd = omarchy-lock-screen                          # lock screen and 1password
    before_sleep_cmd = loginctl lock-session                # lock before suspend.
    after_sleep_cmd = hyprctl dispatch dpms on              # to avoid having to press a key twice to turn on the display.
    inhibit_sleep = 3                                       # wait until screen is locked
}

listener {
    timeout = 300                                              # 5min
    on-timeout = pidof hyprlock || omarchy-launch-screensaver  # start screensaver (if we haven't locked already)
}

listener {
    timeout = 1800                       # 30min
    on-timeout = loginctl lock-session # lock screen when timeout has passed
}

# listener {
#      timeout = 330                                             # 5.5min
#      on-timeout = hyprctl dispatch dpms off                    # screen off when timeout has passed
#      on-resume = hyprctl dispatch dpms on && brightnessctl -r  # screen on when activity is detected
# }
EOT

cat > ~/.config/hypr/hyprlock.conf << 'EOT'
source = $HOME/.config/omarchy/current/theme/mocha.conf

animations {
    enabled = true
}

$accent = $text
$accentAlpha = $textAlpha
$font = JetBrainsMono Nerd Font ExtraBold

# GENERAL
general {
  hide_cursor = true
}

# BACKGROUND
background {
  monitor =
  path = $HOME/.config/omarchy/current/background
  blur_passes = 3
  color = $text
}

# TIME
label {
  monitor =
  text = $TIME12
  color = $text
  font_size = 120
  font_family = $font
  position = 0, -150
  halign = center
  valign = top
}

# DATE
label {
  monitor =
  text = cmd[update:43200000] date +"%A, %d %B %Y"
  color = $text
  font_size = 25
  font_family = $font
  position = 0, -420
  halign = center
  valign = top
}

# INPUT FIELD
input-field {
  monitor =
  size = 300, 60
  outline_thickness = 4
  dots_size = 0.2
  dots_spacing = 0.2
  dots_center = true
  outer_color = $text
  inner_color = $crust
  font_color = $text
  fade_on_empty = false
  placeholder_text = <span foreground="##$accentAlpha">$USER</span>
  hide_input = false
  check_color = $accent
  fail_color = $red
  fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
  capslock_color = $yellow
  position = 0, -800
  halign = center
  valign = top
}
EOT

cat > ~/.config/hypr/input.conf << 'EOT'
input {
  kb_layout = us
  # kb_options = compose:caps

  # Change speed of keyboard repeat
  repeat_rate = 40
  repeat_delay = 600

  # Start with numlock on by default
  numlock_by_default = true

  # Increase sensitity for mouse/trackpack (default: 0)
  # sensitivity = 0.35

  touchpad {
    # Use natural (inverse) scrolling
    natural_scroll = true

 # Use two-finger clicks for right-click instead of lower-right corner
    clickfinger_behavior = true

    # Control the speed of your scrolling
    scroll_factor = 0.2
  }
}

# Scroll faster in the terminal
windowrule = scrolltouchpad 1.5, tag:terminal

# Enable touchpad gestures for changing workspaces
# See https://wiki.hyprland.org/Configuring/Gestures/
gesture = 3, horizontal, workspace
EOT

cat > ~/.config/hypr/looknfeel.conf << 'EOT'
# Change the default Omarchy look'n'feel

# https://wiki.hyprland.org/Configuring/Variables/#general
general {
    # No gaps between windows
     gaps_in = 2
     gaps_out = 4

    # Use master layout instead of dwindle
    # layout = master
}

# https://wiki.hyprland.org/Configuring/Variables/#decoration
decoration {
    # Use round window corners
     rounding = 8
       # Set the opacity for the focused (active) window
    active_opacity = 0.99

    # Set the opacity for unfocused (inactive) windows
    inactive_opacity = 0.9
}

# https://wiki.hypr.land/Configuring/Dwindle-Layout/
dwindle {
    # Avoid overly wide single-window layouts on wide screens
    # single_window_aspect_ratio = 1 1
}
EOT

cat > ~/.config/hypr/mocha.conf << 'EOT'
$rosewater = rgb(f5e0dc)
$rosewaterAlpha = f5e0dc

$flamingo = rgb(f2cdcd)
$flamingoAlpha = f2cdcd

$pink = rgb(f5c2e7)
$pinkAlpha = f5c2e7

$mauve = rgb(cba6f7)
$mauveAlpha = cba6f7

$red = rgb(f38ba8)
$redAlpha = f38ba8

$maroon = rgb(eba0ac)
$maroonAlpha = eba0ac

$peach = rgb(fab387)
$peachAlpha = fab387

$yellow = rgb(f9e2af)
$yellowAlpha = f9e2af

$green = rgb(a6e3a1)
$greenAlpha = a6e3a1

$teal = rgb(94e2d5)
$tealAlpha = 94e2d5

$sky = rgb(89dceb)
$skyAlpha = 89dceb

$sapphire = rgb(74c7ec)
$sapphireAlpha = 74c7ec

$blue = rgb(89b4fa)
$blueAlpha = 89b4fa

$lavender = rgb(b4befe)
$lavenderAlpha = b4befe

$text = rgb(cdd6f4)
$textAlpha = cdd6f4

$subtext1 = rgb(bac2de)
$subtext1Alpha = bac2de

$subtext0 = rgb(a6adc8)
$subtext0Alpha = a6adc8
$overlay2 = rgb(9399b2)
$overlay2Alpha = 9399b2

$overlay1 = rgb(7f849c)
$overlay1Alpha = 7f849c

$overlay0 = rgb(6c7086)
$overlay0Alpha = 6c7086

$surface2 = rgb(585b70)
$surface2Alpha = 585b70

$surface1 = rgb(45475a)
$surface1Alpha = 45475a

$surface0 = rgb(313244)
$surface0Alpha = 313244

$base = rgb(1e1e2e)
$baseAlpha = 1e1e2e

$mantle = rgb(181825)
$mantleAlpha = 181825

$crust = rgb(11111b)
$crustAlpha = 11111b
EOT

cat > ~/.config/fastfetch/config.jsonc << 'EOT'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "file",
    "source": "~/.config/omarchy/branding/arch_mini.txt",
    "color": { "1": "green" },
    "padding": {
      "top": 0,
      "right": 6,
      "left": 2
    }
  },
  "modules": [
    "break",
   {
      "type": "command",
      "key": "\udb82\udcc7 OS",
      "keyColor": "green",
      "text": "version=$(omarchy-version); echo \"Arch Linux $version\""
    },
    {
      "type": "cpu",
      "key": "│ ├",
      "showPeCoreCount": true,
      "keyColor": "green"
    },
    {
      "type": "disk",
      "key": "│ ├󰋊",
      "keyColor": "green"
    },
    {
      "type": "memory",
      "key": "│ ├",
      "keyColor": "green"
    },
    {
      "type": "uptime",
      "key": "│ ├󱫐",
      "keyColor": "green"
    },
    {
      "type": "packages",
      "key": "│ ├󰏖",
      "keyColor": "green"
    },
    {
      "type": "command",
      "key": "└ └󰸌",
      "keyColor": "green",
      "text": "theme=$(omarchy-theme-current); echo -e \"$theme \\e[38m●\\e[37m●\\e[36m●\\e[35m●\\e[34m●\\e[33m●\\e[32m●\\e[31m●\""
    },
]
}
EOT

cat > ~/.config/fish/config.fish << 'EOT'
zoxide init fish | source
zoxide init fish --cmd cd | source

set -gx PATH $PATH /home/eshayat/.spicetify

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set -gx PATH $HOME/.local/bin $PATH

alias edit msedit

alias q exit

alias update "sudo pacman -Syu && yay -Syu"

alias ff fastfetch

alias cls "clear && fastfetch"

alias fishconfig "nvim ~/.config/fish/config.fish"

alias minecraft "java -jar /home/eshayat/Documents/minecraft.jar"

alias mc "java -jar /home/eshayat/Documents/minecraft.jar"

alias python python3

function ls
    eza -l --git --icons --header $argv
end

alias init 'git init'
alias add 'git add .'
alias branch 'git branch -M main'
alias push 'git push -u origin main'

function commit
    git commit -m "$argv"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

ff
EOT

cat > ~/.config/fish/functions/fish_prompt.fish << 'EOT'
# name: Default
# author: Eshayat

function fish_prompt --description 'Write out the simple ➜ ~ prompt'
    set -l normal (set_color normal)

    # ➜ symbol in a color (e.g., blue)
    set -l arrow_color (set_color green)

    set -l pwd_color (set_color green)

    echo -n -s $arrow_color "➜" $normal " " $pwd_color (prompt_pwd) $normal " "
end
EOT

cat > ~/.config/ghostty/config << 'EOT'
# Dynamic theme colors
config-file = ?"~/.config/omarchy/current/theme/ghostty.conf"

# Looks
theme = Catppuccin Mocha

# Font
font-family = "Cascadia Code PL"
font-style = semibold
font-size = 9
font-feature = +liga, +dlig, +calt

# Window
window-padding-x = 14
window-padding-y = 14
confirm-close-surface=false
resize-overlay = never

# Cursor stlying
cursor-style = "bar"
cursor-style-blink = false
shell-integration-features = no-cursor

# Keyboard bindings
keybind = f11=toggle_fullscreen
keybind = ctrl+k=toggle_command_palette
keybind = ctrl+w=close_tab
keybind = ctrl+v=paste_from_clipboard
keybind = ctrl+a=select_all
keybind = ctrl+t=new_tab
keybind = ctrl+tab=next_tab
keybind = ctrl+shift+tab=previous_tab
EOT

cat > ~/.XCompose << 'EOT'
include "%H/.local/share/omarchy/default/xcompose"

# Identification
<Multi_key> <space> <n> : "Eshayat Al-Wasiu"
<Multi_key> <space> <e> : "eshayat.wasiu@gmail.com"
<Multi_key> <space> <p> : "01946113366"
EOT

cat > ~/.config/waybar/config.jsonc << 'EOT'
{
  "reload_style_on_change": true,
  "layer": "top",
  "position": "top",
  "spacing": 0,
  "height": 26,
  "modules-left": ["clock" ,"custom/screenrecording-indicator", "custom/update"],
  "modules-center": [
    "custom/omarchy", "hyprland/workspaces",
  ],
  "modules-right": [
    "group/tray-expander",
    "bluetooth",
    "network",
    "pulseaudio",
    "battery",
  ],

  "hyprland/workspaces": {
    "on-click": "activate",
    "format": "{icon}",
    "format-icons": {
      // "default": "",
      // "1": "<b>一</b>",
      // "2": "<b>二</b>",
      // "3": "<b>三</b>",
      // "4": "<b>四</b>",
      // "5": "<b>五</b>",
      // "6": "<b>六</b>",
      // "7": "<b>七</b>",
      // "8": "<b>八</b>",
      // "9": "<b>九</b>",
      // "10": "<b>十</b>",
      // "active": "󱓻",
      "active": "<span font='12'>󰮯</span>",
      "empty": "<span font='8'></span>",
      "default": "󰊠",
    },
    "persistent-workspaces": {
      "1": [],
      "2": [],
      "3": [],
      "4": [],
      "5": [],
    },
  },

  "custom/omarchy": {
    "format": "<span>\udb82\udcc7</span>",
    "on-click": "omarchy-menu",
    "tooltip-format": "",
  },

  "custom/update": {
    "format": "",
    "exec": "omarchy-update-available",
    "on-click": "omarchy-launch-floating-terminal-with-presentation omarchy-update",
    "tooltip-format": "Omarchy update available",
    "signal": 7,
    "interval": 3600,
  },

  "clock": {
    "interval": 1,
    "format": "{:L%I:%M:%S %p} ",
    "format-alt": "{:L%A | %B %d (%Y)} ",
    "tooltip": false,
    "on-click-right": "omarchy-cmd-tzupdate",
  },

  "network": {
    "format-icons": ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"],
    "format": "{icon} ",
    "format-wifi": "{icon} ",
    "format-ethernet": "󰀂",
    "format-disconnected": "󰤮",
    "tooltip-format-wifi": "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
    "tooltip-format-ethernet": "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
    "tooltip-format-disconnected": "Disconnected",
    "interval": 1,
    "spacing": 1,
    "on-click": "omarchy-launch-wifi",
  },

  "battery": {
    // "format": "{icon} {capacity}%",
    "format": "{icon}",
    "format-discharging": "{icon}",
    "format-charging": "{icon}",
    "format-plugged": "",
    "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
    "format-full": "󰁹󱐋",
    "tooltip-format-discharging": "{power:>1.0f}W↓ {capacity}%",
    "tooltip-format-charging": "{power:>1.0f}W↑ {capacity}%",
    "interval": 1,
    "on-click": "omarchy-menu power",
    "states": {
      "warning": 20,
      "critical": 10,
    },
  },

  "bluetooth": {
    "format": "",
    "format-disabled": "󰂲",
    "format-connected": "",
    "tooltip-format": "Devices connected: {num_connections}",
    "on-click": "blueberry",
  },

  "pulseaudio": {
    "format": "{icon}",
    "on-click": "$TERMINAL --class=Wiremix -e wiremix",
    "on-click-right": "pamixer -t",
    "tooltip-format": "Playing at {volume}%",
    "scroll-step": 5,
    "format-muted": "",
    "format-icons": {
      "default": ["", "", " "],
    },
  },

  "group/tray-expander": {
    "orientation": "inherit",
    "drawer": {
      "transition-duration": 600,
      "children-class": "tray-group-item",
    },
    "modules": ["custom/expand-icon", "tray"],
  },

  "custom/expand-icon": {
    "format": " ",
    "tooltip": false,
  },

  "custom/screenrecording-indicator": {
    "on-click": "omarchy-cmd-screenrecord",
    "exec": "$OMARCHY_PATH/default/waybar/indicators/screen-recording.sh",
    "signal": 8,
    "return-type": "json",
  },

  "tray": {
    "icon-size": 14,
    "spacing": 14,
  },
}
EOT

cat > ~/.config/waybar/style.css << 'EOT'
@import "../omarchy/current/theme/waybar.css";

* {
    background-color: transparent;
    color: #cdd6f4;
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: "CaskaydiaMono Nerd Font";
    font-size: 14px;
    font-weight: 900;
}

.modules-left {
    margin: 4px 6px;
    padding: 4px;
    border-radius: 8px;
}

.modules-center {
    margin: 4px 6px;
    padding: 4px 8px 4px 4px;
    border-radius: 8px;
}

.modules-right {
    margin: 4px 6px;
    padding: 4px 4px 4px 11px;
    border-radius: 8px;
}

#workspaces button {
    all: initial;
    padding: 0 6px;
    margin: 0 1.5px;
    min-width: 9px;
}

#workspaces button.empty {
    opacity: 0.5;
}

#tray,
#cpu,
#battery,
#network,
#bluetooth,
#pulseaudio,
#custom-omarchy,
#custom-screenrecording-indicator,
#custom-update {
    min-width: 12px;
    margin: 0 7.5px;
}

#custom-expand-icon {
    margin-right: 7px;
}

tooltip {
    padding: 2px;
}

#custom-update {
    font-size: 10px;
}

#clock {
    margin-left: 8.75px;
}

.hidden {
    opacity: 0;
}

#custom-screenrecording-indicator {
    min-width: 12px;
    margin-left: 8.75px;
    font-size: 10px;
}
EOT

cat > ~/.config/walker/config.toml << 'EOT'
force_keyboard_focus = true                                                 # forces keyboard forcus to stay in Walker
close_when_open = true                                                      # close walker when invoking while already opened
selection_wrap = true                                                       # wrap list if at bottom or top
click_to_close = true                                                       # closes walker if clicking outside of the main content area
global_argument_delimiter = "#"                                             # query: firefox#https://benz.dev => part after delimiter will be ignored when querying. this should be the same as in the elephant config
exact_search_prefix = "'"                                                   # disable fuzzy searching
theme = "omarchy-default"                                                   # theme to use
disable_mouse = false                                                       # disable mouse (on input and list only)
additional_theme_location = "~/.local/share/omarchy/default/walker/themes/"

[modules.clipboard]
# detail_panel_width = 0 
hide_detail_panel = true

[shell]
anchor_top = true
anchor_bottom = true
anchor_left = true
anchor_right = true

[placeholders]
"default" = { input = " Search...", list = "No Results" } # placeholders for input and empty list, key is the providers name, so f.e. "desktopapplications" or "menus:other"

[keybinds]
close = ["Escape"]
next = ["Down"]
previous = ["Up"]
toggle_exact = ["ctrl e"]
resume_last_query = ["ctrl r"]
quick_activate = []

[providers]
default = [
  "desktopapplications",
  "menus",
  "websearch",
] # providers to be queried by default
empty = ["desktopapplications"] # providers to be queried when query is empty
max_results = 50 # global max results

[providers.sets] # define your own defaults/empty sets of providers
[providers.max_results_provider] # define max results per provider in here

[[providers.prefixes]]
prefix = "/"
provider = "providerlist"

[[providers.prefixes]]
prefix = "."
provider = "files"

[[providers.prefixes]]
prefix = ":"
provider = "symbols"

[[providers.prefixes]]
prefix = "="
provider = "calc"

[[providers.prefixes]]
prefix = "@"
provider = "websearch"

[[providers.prefixes]]
prefix = "$"
provider = "clipboard"

[providers.actions] # This will be MERGED/OVEWRITTEN with what the user specifies
dmenu = [{ action = "select", default = true, bind = "Return" }]

providerlist = [
  { action = "activate", default = true, bind = "Return", after = "ClearReload" },
]

bluetooth = [
  { action = "find", global = true, bind = "ctrl f", after = "AsyncClearReload" },
  { action = "trust", bind = "ctrl t", after = "AsyncReload" },
  { action = "untrust", bind = "ctrl t", after = "AsyncReload" },
  { action = "pair", bind = "Return", after = "AsyncReload" },
  { action = "remove", bind = "ctrl d", after = "AsyncReload" },
  { action = "connect", bind = "Return", after = "AsyncReload" },
  { action = "disconnect", bind = "Return", after = "AsyncReload" },
]

archlinuxpkgs = [
  { action = "install", bind = "Return", default = true },
  { action = "remove", bind = "Return" },
]

calc = [
  { action = "copy", default = true, bind = "Return" },
  { action = "delete", bind = "ctrl d", after = "AsyncReload" },
  { action = "save", bind = "ctrl s", after = "AsyncClearReload" },
]

websearch = [
  { action = "search", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

desktopapplications = [
  { action = "start", default = true, bind = "Return" },
  { action = "start:keep", label = "open+next", bind = "shift Return", after = "KeepOpen" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "AsyncReload" },
  { action = "pin", bind = "ctrl p", after = "AsyncReload" },
  { action = "unpin", bind = "ctrl p", after = "AsyncReload" },
  { action = "pinup", bind = "ctrl n", after = "AsyncReload" },
  { action = "pindown", bind = "ctrl m", after = "AsyncReload" },
]

files = [
  { action = "open", default = true, bind = "Return" },
  { action = "opendir", label = "open dir", bind = "ctrl Return" },
  { action = "copypath", label = "copy path", bind = "ctrl shift c" },
  { action = "copyfile", label = "copy file", bind = "ctrl c" },
]

todo = [
  { action = "save", default = true, bind = "Return", after = "ClearReload" },
  { action = "delete", bind = "ctrl d", after = "ClearReload" },
  { action = "active", bind = "Return", after = "ClearReload" },
  { action = "inactive", bind = "Return", after = "ClearReload" },
  { action = "done", bind = "ctrl f", after = "ClearReload" },
  { action = "clear", bind = "ctrl x", after = "ClearReload", global = true },
]

runner = [
  { action = "run", default = true, bind = "Return" },
  { action = "runterminal", label = "run in terminal", bind = "shift Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

symbols = [
  { action = "run_cmd", label = "select", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

unicode = [
  { action = "run_cmd", label = "select", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

clipboard = [
  { action = "copy", default = true, bind = "Return" },
  { action = "remove", bind = "ctrl d", after = "ClearReload" },
  { action = "remove_all", global = true, label = "clear", bind = "ctrl shift d", after = "ClearReload" },
  { action = "toggle_images", global = true, label = "toggle images", bind = "ctrl i", after = "ClearReload" },
  { action = "edit", bind = "ctrl o" },
]

[builtins.applications]
launch_prefix = "uwsm app -- "
hidden = false


[builtins.custom_commands]
hidden = false


[[builtins.custom_commands.entries]]
label = "RED PILL"
command = "alacritty -e redpill"
keywords = ["redpill","backup","restore","hyprland"]
icon = ""
EOT

cat > ~/.config/walker/themes/default.toml << 'EOT'
# AUTO GENERATED. DO NOT EDIT. CHANGES WILL BE OVERWRITTEN.

[ui.anchors]
bottom = true
left = true
right = true
top = true

[ui.window]
h_align = "fill"
v_align = "fill"

[ui.window.box]
h_align = "center"
width = 450

[ui.window.box.bar]
orientation = "horizontal"
position = "end"

[ui.window.box.bar.entry]
h_align = "fill"
h_expand = true

[ui.window.box.bar.entry.icon]
h_align = "center"
h_expand = true
pixel_size = 24
theme = ""

[ui.window.box.margins]
top = 200

[ui.window.box.ai_scroll]
name = "aiScroll"
h_align = "fill"
v_align = "fill"
max_height = 300
min_width = 400
height = 300
width = 400

[ui.window.box.ai_scroll.margins]
top = 8

[ui.window.box.ai_scroll.list]
name = "aiList"
orientation = "vertical"
width = 400
spacing = 10

[ui.window.box.ai_scroll.list.item]
name = "aiItem"
h_align = "fill"
v_align = "fill"
x_align = 0
y_align = 0
wrap = true

[ui.window.box.scroll.list]
marker_color = "#1BFFE1"
max_height = 300
max_width = 400
min_width = 400
width = 400

[ui.window.box.scroll.list.item.activation_label]
h_align = "fill"
v_align = "fill"
width = 20
x_align = 0.5
y_align = 0.5

[ui.window.box.scroll.list.item.icon]
pixel_size = 26
theme = ""

[ui.window.box.scroll.list.margins]
top = 8

[ui.window.box.search.prompt]
name = "prompt"
icon = "edit-find"
theme = ""
pixel_size = 18
h_align = "center"
v_align = "center"

[ui.window.box.search.clear]
name = "clear"
icon = "edit-clear"
theme = ""
pixel_size = 18
h_align = "center"
v_align = "center"

[ui.window.box.search.input]
h_align = "fill"
h_expand = true
icons = true

[ui.window.box.search.spinner]
hide = true
EOT

cat > ~/.config/swayosd/style.css << 'EOT'
/* AUTO GENERATED. DO NOT EDIT. CHANGES WILL BE OVERWRITTEN. */

@define-color foreground rgba(255, 255, 255, 0.8);
@define-color background hsla(240, 12.7%, 13.9%, 0.98);
@define-color color1 hsl(172, 100%, 25.3%);
/* AUTO GENERATED. DO NOT EDIT. CHANGES WILL BE OVERWRITTEN. */

#window,
#box,
#aiScroll,
#aiList,
#search,
#password,
#input,
#prompt,
#clear,
#typeahead,
#list,
child,
scrollbar,
slider,
#item,
#text,
#label,
#bar,
#sub,
#activationlabel {
  all: unset;
}

#cfgerr {
  background: rgba(255, 0, 0, 0.4);
  margin-top: 20px;
  padding: 8px;
  font-size: 1.2em;
}

#window {
  color: @foreground;
}

#box {
  border-radius: 2px;
  background: @background;
  padding: 32px;
  border: 1px solid lighter(@background);
  box-shadow:
    0 19px 38px rgba(0, 0, 0, 0.3),
    0 15px 12px rgba(0, 0, 0, 0.22);
}

#search {
  box-shadow:
    0 1px 3px rgba(0, 0, 0, 0.1),
    0 1px 2px rgba(0, 0, 0, 0.22);
  background: lighter(@background);
  padding: 8px;
}

#prompt {
  margin-left: 4px;
  margin-right: 12px;
  color: @foreground;
  opacity: 0.2;
}

#clear {
  color: @foreground;
  opacity: 0.8;
}

#password,
#input,
#typeahead {
  border-radius: 2px;
}

#input {
  background: none;
}

#password {}

#spinner {
  padding: 8px;
}

#typeahead {
  color: @foreground;
  opacity: 0.8;
}

#input placeholder {
  opacity: 0.5;
}

#list {}

child {
  padding: 8px;
  border-radius: 2px;
}

child:selected,
child:hover {
  background: alpha(@color1, 0.4);
}

#item {}

#icon {
  margin-right: 8px;
}

#text {}

#label {
  font-weight: 500;
}

#sub {
  opacity: 0.5;
  font-size: 0.8em;
}

#activationlabel {}

#bar {}

.barentry {}

.activation #activationlabel {}

.activation #text,
.activation #icon,
.activation #search {
  opacity: 0.5;
}

.aiItem {
  padding: 10px;
  border-radius: 2px;
  color: @foreground;
  background: @background;
}

.aiItem.user {
  padding-left: 0;
  padding-right: 0;
}

.aiItem.assistant {
  background: lighter(@background);
}
' > ~/.config/walker/themes/default.css

echo '
[server]
show_percentage = true
max_volume = 100
style = "./style.css"
' > ~/.config/swayosd/config.toml

echo '
@import "../omarchy/current/theme/swayosd.css";

window {
  border-radius: 0;
  opacity: 0.97;
  border: 2px solid @border-color;

  background-color: @background-color;
}

label {
  font-family: "CaskaydiaMono Nerd Font";
  font-size: 11pt;

  color: @label;
}

image {
  color: @image;
}

progressbar {
  border-radius: 0;
}

progress {
  background-color: @progress;
}
EOT

echo '
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
████                     ████                     ████
████                     ████                     ████
████    █████████████████████         ████████    ████
████    █████████████████████         ████████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████████████                              ████    ████
████████████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ██████████████████████████████████████    ████
████    ██████████████████████████████████████    ████
████                     ████                     ████
████                     ████                     ████
█████████████████████████████     ████████████████████
█████████████████████████████     ████████████████████
' > ~/.config/omarchy/branding/about.txt

echo '
                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `
' > ~/.config/omarchy/branding/arch.txt

cat > ~/.config/omarchy/branding/arch_mini.txt << 'EOT'

        /\
       /  \
      /    \
     /      \
    /   ,,   \
   /   |  |   \
  /_-''    ''-_\
EOT

echo '
 ______    
/\  ___\   
\ \  __\   
 \ \_____\ 
  \/_____/ 
           
 ______    
/\  ___\   
\ \___  \  
 \/\_____\ 
  \/_____/ 
           
 __  __    
/\ \_\ \   
\ \  __ \  
 \ \_\ \_\ 
  \/_/\/_/
' > ~/.config/omarchy/branding/esh.txt

echo '
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
████                     ████                     ████
████                     ████                     ████
████    █████████████████████         ████████    ████
████    █████████████████████         ████████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████████████                              ████    ████
████████████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ██████████████████████████████████████    ████
████    ██████████████████████████████████████    ████
████                     ████                     ████
████                     ████                     ████
█████████████████████████████     ████████████████████
█████████████████████████████     ████████████████████
' > ~/.config/omarchy/branding/omarchy.txt

echo '
   ▄████████    ▄████████    ▄█    █▄       ▄████████ ▄██   ▄      ▄████████     ███     
  ███    ███   ███    ███   ███    ███     ███    ███ ███   ██▄   ███    ███ ▀█████████▄ 
  ███    █▀    ███    █▀    ███    ███     ███    ███ ███▄▄▄███   ███    ███    ▀███▀▀██ 
 ▄███▄▄▄       ███         ▄███▄▄▄▄███▄▄   ███    ███ ▀▀▀▀▀▀███   ███    ███     ███   ▀ 
▀▀███▀▀▀     ▀███████████ ▀▀███▀▀▀▀███▀  ▀███████████ ▄██   ███ ▀███████████     ███     
  ███    █▄           ███   ███    ███     ███    ███ ███   ███   ███    ███     ███     
  ███    ███    ▄█    ███   ███    ███     ███    ███ ███   ███   ███    ███     ███     
  ██████████  ▄████████▀    ███    █▀      ███    █▀   ▀█████▀    ███    █▀     ▄████▀   
' > ~/.config/omarchy/branding/screensaver.txt

echo '
                 ▄▄▄
 ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
███   ███  ███   ███   ███ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
███   ███  ███   ███   ███ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
███   ███  ███   ███   ███  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
 ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                       ███   █▀
' > ~/.config/omarchy/branding/screensaver_og.txt

cat > ~/.local/share/omarchy/default/hypr/autostart.conf << 'EOT'
exec-once = uwsm-app -- hypridle
exec-once = uwsm-app -- mako
exec-once = uwsm-app -- waybar
exec-once = uwsm-app -- fcitx5
exec-once = uwsm-app -- swaybg -i ~/.config/omarchy/current/background -m fill
exec-once = uwsm-app -- swayosd-server
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = omarchy-cmd-first-run
exec-once = uwsm-app -- elephant
exec-once = uwsm-app -- walker --gapplication-service

# Slow app launch fix -- set systemd vars
exec-once = systemctl --user import-environment $(env | cut -d'=' -f 1)
exec-once = dbus-update-activation-environment --systemd --all
exec-once = ollama serve
EOT

cat > ~/.local/share/omarchy/default/hypr/windows.conf << 'EOT'
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
windowrule = suppressevent maximize, class:.*

# Just dash of opacity by default
windowrule = opacity 0.9 0.87, class:.*

# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

# App-specific tweaks
source = ~/.local/share/omarchy/default/hypr/apps.conf
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/clipboard.conf << 'EOT'
bindd = SUPER, V, Clipboard manager, exec, omarchy-launch-walker -m clipboard
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/utilities.conf << 'EOT'
# Only display the OSD on the currently focused monitor
$osdclient = swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"

# Laptop multimedia keys for volume and LCD brightness (with OSD)
bindeld = ,XF86AudioRaiseVolume, Volume up, exec, $osdclient --output-volume raise
bindeld = ,XF86AudioLowerVolume, Volume down, exec, $osdclient --output-volume lower
bindeld = ,XF86AudioMute, Mute, exec, $osdclient --output-volume mute-toggle
bindeld = ,XF86AudioMicMute, Mute microphone, exec, $osdclient --input-volume mute-toggle
bindeld = ,XF86MonBrightnessUp, Brightness up, exec, $osdclient --brightness raise
bindeld = ,XF86MonBrightnessDown, Brightness down, exec, $osdclient --brightness lower

bindeld = SUPER, page_up, Brightness up, exec, $osdclient --brightness raise
bindeld = SUPER, page_down, Brightness down, exec, $osdclient --brightness lower

# Precise 1% multimedia adjustments with Alt modifier
bindeld = ALT, XF86AudioRaiseVolume, Volume up precise, exec, $osdclient --output-volume +1
bindeld = ALT, XF86AudioLowerVolume, Volume down precise, exec, $osdclient --output-volume -1
bindeld = ALT, XF86MonBrightnessUp, Brightness up precise, exec, $osdclient --brightness +1
bindeld = ALT, XF86MonBrightnessDown, Brightness down precise, exec, $osdclient --brightness -1

# Requires playerctl
bindld = , XF86AudioNext, Next track, exec, $osdclient --playerctl next
bindld = , XF86AudioPause, Pause, exec, $osdclient --playerctl play-pause
bindld = , XF86AudioPlay, Play, exec, $osdclient --playerctl play-pause
bindld = , XF86AudioPrev, Previous track, exec, $osdclient --playerctl previous

# Switch audio output with Super + Mute
bindld = SUPER, XF86AudioMute, Switch audio output, exec, omarchy-cmd-audio-switch
' > ~/.local/share/omarchy/default/hypr/bindings/media.conf
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf << 'EOT'
# Close windows
bindd = SUPER, Q, Close active window, killactive,
bindd = CTRL ALT, DELETE, Close all Windows, exec, omarchy-hyprland-window-close-all

# Control tiling
bindd = SUPER, J, Toggle split, togglesplit, # dwindle
bindd = SUPER, P, Pseudo window, pseudo, # dwindle
bindd = SUPER, F, Toggle floating, togglefloating,
bindd = SUPER SHIFT, F, Force full screen, fullscreen, 0
bindd = SUPER CTRL, F, Tiled full screen, fullscreenstate, 0 2
bindd = SUPER ALT, F, Full width, fullscreen, 1

# Move focus with SUPER + arrow keys
bindd = SUPER, LEFT, Move focus left, movefocus, l
bindd = SUPER, RIGHT, Move focus right, movefocus, r
bindd = SUPER, UP, Move focus up, movefocus, u
bindd = SUPER, DOWN, Move focus down, movefocus, d

# Switch workspaces with SUPER + [0-9]
bindd = SUPER, code:10, Switch to workspace 1, workspace, 1
bindd = SUPER, code:11, Switch to workspace 2, workspace, 2
bindd = SUPER, code:12, Switch to workspace 3, workspace, 3
bindd = SUPER, code:13, Switch to workspace 4, workspace, 4
bindd = SUPER, code:14, Switch to workspace 5, workspace, 5
bindd = SUPER, code:15, Switch to workspace 6, workspace, 6
bindd = SUPER, code:16, Switch to workspace 7, workspace, 7
bindd = SUPER, code:17, Switch to workspace 8, workspace, 8
bindd = SUPER, code:18, Switch to workspace 9, workspace, 9
bindd = SUPER, code:19, Switch to workspace 10, workspace, 10

# Move active window to a workspace with SUPER + SHIFT + [0-9]
bindd = SUPER SHIFT, code:10, Move window to workspace 1, movetoworkspace, 1
bindd = SUPER SHIFT, code:11, Move window to workspace 2, movetoworkspace, 2
bindd = SUPER SHIFT, code:12, Move window to workspace 3, movetoworkspace, 3
bindd = SUPER SHIFT, code:13, Move window to workspace 4, movetoworkspace, 4
bindd = SUPER SHIFT, code:14, Move window to workspace 5, movetoworkspace, 5
bindd = SUPER SHIFT, code:15, Move window to workspace 6, movetoworkspace, 6
bindd = SUPER SHIFT, code:16, Move window to workspace 7, movetoworkspace, 7
bindd = SUPER SHIFT, code:17, Move window to workspace 8, movetoworkspace, 8
bindd = SUPER SHIFT, code:18, Move window to workspace 9, movetoworkspace, 9
bindd = SUPER SHIFT, code:19, Move window to workspace 10, movetoworkspace, 10

# TAB between workspaces
bindd = SUPER, TAB, Next workspace, workspace, e+1
bindd = SUPER SHIFT, TAB, Previous workspace, workspace, e-1
bindd = SUPER CTRL, TAB, Former workspace, workspace, previous

# Swap active window with the one next to it with SUPER + SHIFT + arrow keys
bindd = SUPER SHIFT, LEFT, Swap window to the left, swapwindow, l
bindd = SUPER SHIFT, RIGHT, Swap window to the right, swapwindow, r
bindd = SUPER SHIFT, UP, Swap window up, swapwindow, u
bindd = SUPER SHIFT, DOWN, Swap window down, swapwindow, d

# Cycle through applications on active workspace
bindd = ALT, TAB, Cycle to next window, cyclenext
bindd = ALT SHIFT, TAB, Cycle to prev window, cyclenext, prev
bindd = ALT, TAB, Reveal active window on top, bringactivetotop
bindd = ALT SHIFT, TAB, Reveal active window on top, bringactivetotop

# Resize active window
bindd = SUPER, code:20, Expand window left, resizeactive, -100 0    # - key
bindd = SUPER, code:21, Shrink window left, resizeactive, 100 0     # = key
bindd = SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 -100
bindd = SUPER SHIFT, code:21, Expand window down, resizeactive, 0 100

# Scroll through existing workspaces with SUPER + scroll
bindd = SUPER, mouse_down, Scroll active workspace forward, workspace, e+1
bindd = SUPER, mouse_up, Scroll active workspace backward, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindmd = SUPER, mouse:272, Move window, movewindow
bindmd = SUPER, mouse:273, Resize window, resizewindow

# Toggle groups
bindd = SUPER CTRL, G, Toggle window grouping, togglegroup
bindd = SUPER ALT, G, Move active window out of group, moveoutofgroup

# Join groups
bindd = SUPER ALT, LEFT, Move window to group on left, moveintogroup, l
bindd = SUPER ALT, RIGHT, Move window to group on right, moveintogroup, r
bindd = SUPER ALT, UP, Move window to group on top, moveintogroup, u
bindd = SUPER ALT, DOWN, Move window to group on bottom, moveintogroup, d

# Navigate a single set of grouped windows
bindd = SUPER ALT, TAB, Next window in group, changegroupactive, f
bindd = SUPER ALT SHIFT, TAB, Previous window in group, changegroupactive, b

# Scroll through a set of grouped windows with SUPER + ALT + scroll
bindd = SUPER ALT, mouse_down, Next window in group, changegroupactive, f
bindd = SUPER ALT, mouse_up, Previous window in group, changegroupactive, b

# Activate window in a group by number
bindd = SUPER ALT, 1, Switch to group window 1, changegroupactive, 1
bindd = SUPER ALT, 2, Switch to group window 2, changegroupactive, 2
bindd = SUPER ALT, 3, Switch to group window 3, changegroupactive, 3
bindd = SUPER ALT, 4, Switch to group window 4, changegroupactive, 4
bindd = SUPER ALT, 5, Switch to group window 5, changegroupactive, 5
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/tiling.conf << 'EOT'
# This is now a deprecated file meant for those who did not wish to learn the latest Omarchy hotkeys.
# Do not make changes here, but bring them to tiling-v2.conf instead.

# Close windows
bindd = SUPER, Q, Close active window, killactive,
bindd = CTRL ALT, DELETE, Close all Windows, exec, omarchy-hyprland-window-close-all

# Control tiling
bindd = SUPER, J, Toggle split, togglesplit, # dwindle
bindd = SUPER, P, Pseudo window, pseudo, # dwindle
bindd = SUPER SHIFT, V, Toggle floating, togglefloating,
bindd = SHIFT, F11, Force full screen, fullscreen, 0
bindd = ALT, F11, Full width, fullscreen, 1

# Move focus with SUPER + arrow keys
bindd = SUPER, LEFT, Move focus left, movefocus, l
bindd = SUPER, RIGHT, Move focus right, movefocus, r
bindd = SUPER, UP, Move focus up, movefocus, u
bindd = SUPER, DOWN, Move focus down, movefocus, d

# Switch workspaces with SUPER + [0-9]
bindd = SUPER, code:10, Switch to workspace 1, workspace, 1
bindd = SUPER, code:11, Switch to workspace 2, workspace, 2
bindd = SUPER, code:12, Switch to workspace 3, workspace, 3
bindd = SUPER, code:13, Switch to workspace 4, workspace, 4
bindd = SUPER, code:14, Switch to workspace 5, workspace, 5
bindd = SUPER, code:15, Switch to workspace 6, workspace, 6
bindd = SUPER, code:16, Switch to workspace 7, workspace, 7
bindd = SUPER, code:17, Switch to workspace 8, workspace, 8
bindd = SUPER, code:18, Switch to workspace 9, workspace, 9
bindd = SUPER, code:19, Switch to workspace 10, workspace, 10

# Move active window to a workspace with SUPER + SHIFT + [0-9]
bindd = SUPER SHIFT, code:10, Move window to workspace 1, movetoworkspace, 1
bindd = SUPER SHIFT, code:11, Move window to workspace 2, movetoworkspace, 2
bindd = SUPER SHIFT, code:12, Move window to workspace 3, movetoworkspace, 3
bindd = SUPER SHIFT, code:13, Move window to workspace 4, movetoworkspace, 4
bindd = SUPER SHIFT, code:14, Move window to workspace 5, movetoworkspace, 5
bindd = SUPER SHIFT, code:15, Move window to workspace 6, movetoworkspace, 6
bindd = SUPER SHIFT, code:16, Move window to workspace 7, movetoworkspace, 7
bindd = SUPER SHIFT, code:17, Move window to workspace 8, movetoworkspace, 8
bindd = SUPER SHIFT, code:18, Move window to workspace 9, movetoworkspace, 9
bindd = SUPER SHIFT, code:19, Move window to workspace 10, movetoworkspace, 10

# TAB between workspaces
bindd = SUPER, TAB, Next workspace, workspace, e+1
bindd = SUPER SHIFT, TAB, Previous workspace, workspace, e-1
bindd = SUPER CTRL, TAB, Former workspace, workspace, previous

# Swap active window with the one next to it with SUPER + SHIFT + arrow keys
bindd = SUPER SHIFT, LEFT, Swap window to the left, swapwindow, l
bindd = SUPER SHIFT, RIGHT, Swap window to the right, swapwindow, r
bindd = SUPER SHIFT, UP, Swap window up, swapwindow, u
bindd = SUPER SHIFT, DOWN, Swap window down, swapwindow, d

# Cycle through applications on active workspace
bindd = ALT, TAB, Cycle to next window, cyclenext
bindd = ALT SHIFT, TAB, Cycle to prev window, cyclenext, prev
bindd = ALT, TAB, Reveal active window on top, bringactivetotop
bindd = ALT SHIFT, TAB, Reveal active window on top, bringactivetotop

# Resize active window
bindd = SUPER, code:20, Expand window left, resizeactive, -100 0    # - key
bindd = SUPER, code:21, Shrink window left, resizeactive, 100 0     # = key
bindd = SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 -100
bindd = SUPER SHIFT, code:21, Expand window down, resizeactive, 0 100

# Scroll through existing workspaces with SUPER + scroll
bindd = SUPER, MOUSE_DOWN, Scroll active workspace forward, workspace, e+1
bindd = SUPER, MOUSE_UP, Scroll active workspace backward, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindmd = SUPER, mouse:272, Move window, movewindow
bindmd = SUPER, mouse:273, Resize window, resizewindow
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/utilities.conf << 'EOT'
# Menus
bindd = SUPER, SPACE, Launch apps, exec, omarchy-launch-walker
bindd = SUPER CTRL, E, Emoji picker, exec, omarchy-launch-walker -m symbols
bindd = SUPER ALT, SPACE, Omarchy menu, exec, omarchy-menu
bindd = SUPER, ESCAPE, Power menu, exec, omarchy-menu system
bindld = , XF86PowerOff, Power menu, exec, omarchy-menu system
bindd = SUPER, K, Show key bindings, exec, omarchy-menu-keybindings
bindd = , XF86Calculator, Calculator, exec, gnome-calculator

# Aesthetics
bindd = SUPER SHIFT, SPACE, Toggle top bar, exec, omarchy-toggle-waybar
bindd = SUPER CTRL, SPACE, Next background in theme, exec, omarchy-theme-bg-next
bindd = SUPER SHIFT CTRL, SPACE, Pick new theme, exec, omarchy-menu theme
bindd = SUPER, BACKSPACE, Toggle window transparency, exec, hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle
bindd = SUPER SHIFT, BACKSPACE, Toggle workspace gaps, exec, omarchy-hyprland-workspace-toggle-gaps

# Notifications
bindd = SUPER, COMMA, Dismiss last notification, exec, makoctl dismiss
bindd = SUPER SHIFT, COMMA, Dismiss all notifications, exec, makoctl dismiss --all
bindd = SUPER CTRL, COMMA, Toggle silencing notifications, exec, makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send "Silenced notifications" || notify-send "Enabled notifications"

# Toggle idling
bindd = SUPER CTRL, I, Toggle locking on idle, exec, omarchy-toggle-idle

# Toggle nightlight
bindd = SUPER CTRL, N, Toggle nightlight, exec, omarchy-toggle-nightlight

# Control Apple Display brightness
bindd = CTRL, F1, Apple Display brightness down, exec, omarchy-cmd-apple-display-brightness -5000
bindd = CTRL, F2, Apple Display brightness up, exec, omarchy-cmd-apple-display-brightness +5000
bindd = SHIFT CTRL, F2, Apple Display full brightness, exec, omarchy-cmd-apple-display-brightness +60000

# Captures
bindd = SUPER SHIFT, R, Screenrecording, exec, omarchy-menu screenrecord
bind = SUPER SHIFT, S, exec, hyprshot -m region
bindd = SUPER SHIFT, C, Color picking, exec, pkill hyprpicker || hyprpicker -a

# File sharing
bindd = SUPER ALT, S, Share, exec, omarchy-menu share

# Waybar-less information
bindd = SUPER CTRL, T, Show time, exec, notify-send "    $(date +"%A %I:%M %p  —  %d %B %Y")"
bindd = SUPER CTRL, B, Show battery remaining, exec, notify-send "󰁹    Battery is at $(omarchy-battery-remaining)%"
EOT

echo "--- Script finished! Please reboot. ---"

# --- END OF SCRIPT ---
