# Optional Cursor hook

Default `install.sh` does not enable this.

1. Copy `exec-gate.py` somewhere writable.
2. Put an absolute `python3 /that/path/exec-gate.py` command into `~/.cursor/hooks.json` (see `hooks.json.example`).
3. The hook process must see `OBSIDIAN_VAULT`.

Denied: mutating `$OBSIDIAN_VAULT/Clippings`, quitting or reloading Obsidian. This is not a general sandbox.
