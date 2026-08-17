#!/bin/bash
set -euo pipefail

qml="/usr/share/omarchy/shell/plugins/bar/indicators/Dictation.qml"

if [ ! -f "$qml" ]; then
  echo "dictate: $qml not found — skipping"
  exit 0
fi

if grep -q 'voxtype record toggle' "$qml"; then
  echo "dictate: already patched (click toggles dictate)"
  exit 0
fi

sudo sed -i 's|root.bar.run("omarchy-voxtype-config")|root.bar.run("voxtype record toggle")|' "$qml"
echo "dictate: patched Dictation.qml — click now toggles dictate"
omarchy restart shell 2>/dev/null || true
