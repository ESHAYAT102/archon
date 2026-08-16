<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/219d722a-62cb-4e54-8860-65b0e5ebc395" />

---

Run the `script.sh` script file to install.

```bash
cd ~/Downloads && wget https://raw.githubusercontent.com/ESHAYAT102/archon/refs/heads/main/script.sh && chmod +x ./script.sh && ./script.sh && rm script.sh
```

### Flags

- `./script.sh --try` — run only the `try` workspace-manager setup (installs `tobi-try`, applies an embedded patch to remove date prefixes from new folders, and wires `TRY_NO_DATE` + `try init ~/Work/tries` into your shell config). Self-contained: works from the single-file wget install above.
