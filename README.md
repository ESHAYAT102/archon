<img width="1920" height="1080" alt="screenshot-2026-08-17_06-14-15" src="https://github.com/user-attachments/assets/4f6a472a-748a-4468-884b-5555f66564e5" />

---

### Flags

- `--try` — run only the `try` workspace-manager setup (installs `tobi-try`, applies an embedded patch to remove date prefixes from new folders, and wires `TRY_NO_DATE` + `try init ~/Work/tries` into your shell config).
- `--dictate` — run only the dictate fix (patches the Omarchy bar's Dictation indicator so clicking the icon toggles dictation instead of opening the VoxType config). Will be overwritten on the next `omarchy update`.

```bash
# full install
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script.sh | bash

# try only
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script-try.sh | bash

# dictate only
curl -fsSL https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script-dictate.sh | bash
```
