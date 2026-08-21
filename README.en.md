# KRouter Obsidian

Author-vault results (2026-08-21): retrieval blind test **25/25**, canonical routing 26/26 topics and 156/156 aliases, **72** consecutive sealed days, **30** real tasks, execution gate passed, host daily evolution running.

Obsidian knowledge routing for agents. One short noun hits the page that should change this action, with a SHA-256 receipt. Corrections are written to canonical pages and retrieved on the next similar task. The vault gets sharper; the agent gets steadier. No vector index.

This repository is an installable protocol. Architecture: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). Invariants: [`PROTOCOL.md`](PROTOCOL.md). MIT.

The GitHub repository is `runtime36`. The product name is **KRouter Obsidian**.

## Four layers

Write-up maturity, then retrieval. Five folders are storage, not a substitute for the layers.

1. Full daily logs (`05`) — episodic, not results.
2. Distillation and reviews — summaries never replace originals.
3. Promotion — five gates into `provisional`; ask + accepted task to `active`.
4. Retrieval — one short noun, SHA receipt, no embeddings.

## Invariants

- The host sets `OBSIDIAN_VAULT`. This repo hard-codes nobody’s home directory.
- Queries are one contiguous noun. Do not send a full question as if spaces were AND.
- If the receipt has `canonical_match: true`, the agent **must** cite `canonical_source`. Nearby notes are not substitutes.
- Clippings originals are copied only. Do not move, edit, or delete them.
- `status` reads `Agent第二大脑.md`.
- Daily evolution and the execution hook live under `extras/` and are off by default.

Alias scoring: exact match, then alias-in-query, then query-in-alias (length ≥ 2). Tied scores resolve to the lowest id only when they point at the same file; otherwise there is no hit.

## Install

Requires `python3` and `rg`.

```bash
git clone https://github.com/398894496-arch/runtime36.git
cd runtime36
chmod +x scripts/*.sh skill/krouter-obsidian/scripts/*.sh
./scripts/first_run.sh
```

`first_run.sh` validates the bundled `template/` only. It does not inherit a host `OBSIDIAN_VAULT`. Set `KROUTER_FIRST_RUN_VAULT` to aim it elsewhere.

Pass criterion: `search 入口` yields `canonical_id: Q01`, `source` at `template/Agent第二大脑.md`, plus `source_sha256` and `canonical_map_sha256`.

```bash
cp -R template /path/to/YourVault
export OBSIDIAN_VAULT=/path/to/YourVault
./scripts/install.sh
```

Installs to `~/.agents/skills/krouter-obsidian` and `~/.cursor/rules/krouter-obsidian.mdc`. Pass `--force` to replace an existing skill. This path does not overwrite `obsidian-knowledge-router`. Then rewrite `canonical_sources.psv` with the host’s own nouns.

## Proven in the author’s vault

As of 2026-08-21: 25/25 retrieval blind test; 26/26 topics and 156/156 aliases; 72 consecutive sealed days; 30 real tasks; execution gate passed; host daily evolution running.

Corrections are written into the vault and retrieved next time. The vault gets sharper; the agent gets steadier.

Primary copy: [`README.md`](README.md).
