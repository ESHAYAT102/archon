<img width="1920" height="1080" alt="preview" src="https://github.com/user-attachments/assets/b0434c21-ec87-4012-b7dc-27fc7436f8ad" />

---

Run the `script.sh` script file to install.

```bash
cd ~/Downloads && wget https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script.sh && chmod +x ./script.sh && ./script.sh && rm script.sh
```

## XDPH Screen-Share Picker

Archon disables the Hyprland portal screen-share picker by installing
`~/.local/bin/xdph-no-picker` and pointing `~/.config/hypr/xdph.conf` at it.
This makes unwanted Electron/browser screencast requests fail silently instead
of showing the `Windows / Outputs / Region` chooser.

To re-enable normal screen sharing, change `custom_picker_binary` in
`~/.config/hypr/xdph.conf` back to `hyprland-preview-share-picker`, then run:

```bash
systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service
```
