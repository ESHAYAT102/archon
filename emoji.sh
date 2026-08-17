#!/bin/bash
set -euo pipefail

script="/usr/share/omarchy/bin/omarchy-menu-emoji-insert"

if [ ! -f "$script" ]; then
  echo "emoji: $script not found — skipping"
  exit 0
fi

if grep -q 'wtype -M ctrl -k v -m ctrl' "$script"; then
  echo "emoji: already patched (Ctrl+V paste)"
  exit 0
fi

sudo sed -i 's|wtype -M shift -k Insert -m shift|wtype -M ctrl -k v -m ctrl|' "$script"
echo "emoji: patched omarchy-menu-emoji-insert — uses Ctrl+V instead of Shift+Insert"
