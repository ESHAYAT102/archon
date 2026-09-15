<img width="1920" height="1080" alt="Screenshot1" src="https://github.com/user-attachments/assets/85307cf9-e339-4d83-9423-9876e2e688c4" />

<img width="1920" height="1080" alt="Screenshot2" src="https://github.com/user-attachments/assets/7e025e23-0dfa-476a-8f5d-3e6a0719ce36" />

<img width="1920" height="1080" alt="Screenshot3" src="https://github.com/user-attachments/assets/4f6a472a-748a-4468-884b-5555f66564e5" />

---

```bash
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script.sh | bash
```

The full setup also installs the MacOS Icons theme and applies Archon's ArcDock customizations, including the left-side Launchpad button, application-icon fallback handling, and normalized fallback icon sizing.

### Flags

- `--try` — run only the `try` workspace-manager setup (installs `tobi-try`, applies an embedded patch to remove date prefixes from new folders, and wires `TRY_NO_DATE` + `try init ~/Work` into your shell config).
- `--dictate` — run only the dictate fix (patches the Omarchy bar's Dictation indicator so clicking the icon toggles dictation instead of opening the VoxType config). Will be overwritten on the next `omarchy update`.
- `--emoji` — run only the emoji picker fix (patches `omarchy-menu-emoji-insert` to use Ctrl+V instead of Shift+Insert so pasting works on Wayland apps). Will be overwritten on the next `omarchy update`.

```bash
# try only
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/try.sh | bash

# dictate only
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/dictate.sh | bash

# emoji only
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/emoji.sh | bash
```
