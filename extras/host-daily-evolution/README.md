# Host daily evolution (the writer)

This is the **product**, not a side plugin. Self-evolution: seal yesterday’s log, distill, **write `provisional` the same day when the five gates pass**.

Timer is **on by default** (`lamp: running`). The **key** is an API key or subscription env vars. No key → timer still on, distill does not run. `lamp: unused` = you turned the timer off.

Put the key on the OS job, not in the vault. That key is not a cloud memory API.

| File | Role |
|---|---|
| `check.sh` | Proves writer files exist and reads `lamp:`. Default `running`. Does not fire the job. |
| `run.sh` | OS job entry. Skips distill if the key is missing. Writes `self_evolution_key` / `krouter_writer` on the health page (never the secret). |
| `patch_health.py` | Updates those health fields. |
| `PROMPT.md` | Writer contract. Pin a local CLI; pass this file to it. |
| `launchd.example.plist` | macOS example. Replace `WRITER`, `VAULT`, and the key. |
| `cron.example` | cron example. Same replacements. |

`dsh plugin add` is a mount, not this writer. It does not replace the timer.

## Prove it on the template

```bash
export OBSIDIAN_VAULT=/path/to/runtime36/template
./extras/host-daily-evolution/check.sh
```

`./scripts/first_run.sh` runs that check. Pass means the writer files exist and the lamp is `running` (default) or `unused` (you turned it off). CI does not fire the daily job.

## Contract

1. Set `OBSIDIAN_VAULT` to your vault root (the knowledge base).
2. Pin the writer binary by absolute path. Do not use a PATH-level `agent`.
3. Fill the self-evolution key on the OS job (API key or subscription env vars). Not in the vault.
4. Timer is on. Cloud chat automations are not this writer.
5. Write L1 logs and L2 distillation. When the five gates pass, write `provisional` the same day (no ask). Do not auto-promote to `active`.
6. Do not edit `canonical_sources.psv`.
7. On failure, leave a to-summarize note.
8. Uninstalling a Cursor / Codex / Claude Code / DSH mount does not stop this job. Disable the OS schedule yourself, then set `lamp: unused`.
