# Host daily evolution (optional extra)

Self-evolution for an **agent second brain**: seal yesterday’s log, distill, and propose `provisional` methods. It is **not** installed by `dsh plugin add`. Skipping it does not delete the knowledge base or the memory-system protocol.

The DSH plugin is read-only retrieval. This extra is a host scheduler plus a pinned local agent CLI.

## Do not run this by default

`./scripts/install.sh` and `dsh plugin add github:398894496-arch/runtime36` do **not** create a cron or launchd job. If you skip this extra, set the vault lamp `90 系统文件/自动化/日更健康.md` to `unused`.

## Contract

1. Set `OBSIDIAN_VAULT` to your vault root (the knowledge base).
2. Pin the writer binary by absolute path. Do not use a PATH-level `agent`.
3. Schedule with the OS (`launchd`, `cron`, Task Scheduler). Cloud chat automations are not the unattended writer.
4. Write L1 logs and L2 distillation. Same-day reusable practice is `provisional` only. Do not auto-promote to `active`.
5. Do not edit `canonical_sources.psv`. The alias map is a separate writer.
6. On failure, leave a to-summarize note. Do not switch shells and rewrite the day.
7. Uninstalling a Cursor / Codex / DSH mount does not stop this job. Disable the OS schedule yourself.

## macOS launchd (example)

Replace `WRITER` with the absolute path of **your** CLI. Replace `VAULT` with your vault.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>local.krouter.daily-evolution</string>
  <key>ProgramArguments</key>
  <array>
    <string>WRITER</string>
    <string>-p</string>
    <string>/path/to/your/daily-evolution-prompt.md</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>9</integer>
    <key>Minute</key>
    <integer>10</integer>
  </dict>
  <key>EnvironmentVariables</key>
  <dict>
    <key>OBSIDIAN_VAULT</key>
    <string>VAULT</string>
  </dict>
</dict>
</plist>
```

Load with `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.krouter.daily-evolution.plist`. Unload to stop.

## cron (example)

```cron
10 9 * * * OBSIDIAN_VAULT=/path/to/YourVault /absolute/path/to/pinned-writer -p /path/to/prompt.md
```

## Prompt minimum

Tell the writer: one sealed note per day under `05 时间日志`; summaries never replace originals; cite KRouter receipts; do not mutate the alias map; do not call a second memory system or a vector store.

Author-vault health is private. This repository ships the empty lamp page in `template/`.
