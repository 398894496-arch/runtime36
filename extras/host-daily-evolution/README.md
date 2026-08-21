# Host daily evolution (the writer)

This is the **product loop**, not a side plugin. Self-evolution for an agent second brain: seal yesterday’s log, distill, **write `provisional` the same day when the five gates pass**.

`lamp: unused` means the OS **timer is off**. It does not mean this loop is optional. This extra **ships the contract and examples**. It still does **not** start launchd/cron by itself.

| File | Role |
|---|---|
| `check.sh` | Proves the extra is present and reads `lamp:` on the vault health page. `unused` is a valid skip. Does not load launchd. |
| `PROMPT.md` | Writer contract. Pin a local CLI; pass this file to it. |
| `launchd.example.plist` | macOS example. Replace `WRITER` and `VAULT`. |
| `cron.example` | cron example. Same replacements. |

`./scripts/install.sh` and `dsh plugin add github:398894496-arch/runtime36` do **not** create a cron or launchd job. Clone default: `template/90 系统文件/自动化/日更健康.md` has `lamp: unused`.

## Prove it on the template

```bash
export OBSIDIAN_VAULT=/path/to/runtime36/template
./extras/host-daily-evolution/check.sh
```

`./scripts/first_run.sh` runs that check. Pass means the extra exists and the lamp is `unused` or `running`, not that a daily job is already scheduled.

## Contract

1. Set `OBSIDIAN_VAULT` to your vault root (the knowledge base).
2. Pin the writer binary by absolute path. Do not use a PATH-level `agent`.
3. Schedule with the OS. Cloud chat automations are not the unattended writer.
4. Write L1 logs and L2 distillation. When the five gates pass, write `provisional` the same day (no ask). Do not auto-promote to `active`.
5. Do not edit `canonical_sources.psv`.
6. On failure, leave a to-summarize note.
7. Uninstalling a Cursor / Codex / Claude Code / DSH mount does not stop this job. Disable the OS schedule yourself, then set `lamp: unused`.
