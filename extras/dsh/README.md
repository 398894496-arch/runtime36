# DSH-KRouter

Read-only **DeepSeek Harness** plugin. **DeepSeek Harness memory system · Agent second brain · Obsidian knowledge base · self-evolution · Cursor / Codex / Claude Code.** It does not create a second vault. All four share `OBSIDIAN_VAULT`.

Uninstalling the plugin does not delete notes. **`dsh plugin add` is a mount, not the writer.** Self-evolution is [`extras/host-daily-evolution/`](../host-daily-evolution/). Timer on by default; the key is an API key or subscription vars.

## Local test (before `dsh plugin add`)

```bash
node extras/dsh/test-bridge.mjs
./scripts/first_run.sh
```

## Install into a DSH profile

First install the skill so the router exists:

```bash
export OBSIDIAN_VAULT=/path/to/YourVault
./scripts/install.sh
```

Then, from a machine that already runs DSH. Prefer a spare profile. Do not point experiments at a live profile that already has other plugins:

```bash
dsh plugin add github:398894496-arch/runtime36
```

Local checkout:

```bash
dsh plugin add /absolute/path/to/runtime36/extras/dsh
```

Tools: `krouter_status` (includes `host_action` when the key or writer is missing — tell the host), `krouter_preference`, `krouter_correction`, `krouter_memory`, `krouter_project`, `krouter_search`, `krouter_suggest`.

If `canonical_match` is true, open `canonical_source`. Suggestions are hints, not hits.

The alias map is not writable from these tools. Mutate it with `maintain_aliases.py` after `acquire`.
