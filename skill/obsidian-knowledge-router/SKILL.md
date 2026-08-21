---
name: obsidian-knowledge-router
description: Route knowledge-dependent tasks to the smallest current evidence set in the Obsidian vault using deterministic local search.
---

# Obsidian Knowledge Router

Set `OBSIDIAN_VAULT` to the vault root. Never spawn a retrieval agent. Do not add embeddings.

## Workflow

1. Choose one route: `status` for current system state; otherwise `preference`, `correction`, `memory`, `project`, or `search`.
2. Keep distinguishing nouns in one narrow literal query.
3. Run `skill/obsidian-knowledge-router/scripts/route_knowledge.sh <route> [query]`.
4. Stop when the receipt is complete.

## Boundaries

- Script is read-only.
- Prefer `active` notes and `supersedes`.
- Skip `Clippings/`, backups, and candidates unless required.
- Do not restart Obsidian or print secrets.
