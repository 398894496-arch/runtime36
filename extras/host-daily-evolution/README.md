# Host daily evolution (the writer)

This is the **product**, not a side plugin. Self-evolution: seal yesterday’s log, distill, **write `provisional` the same day when the five gates pass**.

Timer is **on by default** (`lamp: running`). The **key** is your `*_API_KEY` on the vault page, or an already-logged-in local CLI (`grok` / official Codex / `claude`). No key → timer still on, distill does not run. `lamp: unused` = you turned the timer off.

There is no extra env file. The job auto-detects the CLI each run. Do not commit a live key.

| File | Role |
|---|---|
| `check.sh` | Proves writer files exist and reads `lamp:`. Default `running`. Does not fire the job. |
| `run.sh` | OS job entry. Calls `resolve.py --exec`. Skips distill if the key and CLI login are both missing. |
| `resolve.py` | Reads the vault key page; auto-detects a logged-in CLI; otherwise runs the bundled API writer. Never prints secrets. |
| `api_writer.py` | Distill with only a vault-page `*_API_KEY`. No grok / Codex / claude required. |
| `patch_health.py` | Updates health fields (`present` / `missing` / `dead` / `unknown`). Never the secret. |
| `PROMPT.md` | Writer contract. Passed to the detected CLI. |
| `launchd.example.plist` | macOS example. Only `OBSIDIAN_VAULT`, `HOME`, `PATH`. No key slot. |
| `cron.example` | cron example. Same. |

`dsh plugin add` is a mount, not this writer. It does not replace the timer.

## Prove it on the template

```bash
export OBSIDIAN_VAULT=/path/to/runtime36/template
./extras/host-daily-evolution/check.sh
```

`./scripts/first_run.sh` runs that check. Pass means the writer files exist, the key page ships placeholders only, and the lamp is `running` (default) or `unused` (you turned it off). CI does not fire the daily job.

## Contract

1. Set `OBSIDIAN_VAULT` to your vault root (copy `template/` there first).
2. Either paste your `*_API_KEY` on `90 系统文件/自动化/自进化钥匙.md`, or already be logged in to `grok` / official Codex / `claude`. The job auto-detects. Do not use a PATH-level `agent`. Optional: pin `KROUTER_WRITER` to an absolute binary.
3. Timer is on. Cloud chat automations are not this writer.
4. Write L1 logs and L2 distillation. When the five gates pass, write `provisional` the same day (no ask). Do not auto-promote to `active`.
5. Do not edit `canonical_sources.psv`.
6. On failure, leave a to-summarize note.
7. Uninstalling a Cursor / Codex / Claude Code / DSH mount does not stop this job. Disable the OS schedule yourself, then set `lamp: unused`.

Paste a live `*_API_KEY` on the vault page, **or** log in a coding CLI. Either lane distills. The bundled `api_writer.py` is what makes API-key-only work.
