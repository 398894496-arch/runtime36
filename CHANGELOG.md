# Changelog

## 0.3.0 — 2026-08-21

- DSH mount: `extras/dsh` registers read-only `krouter_status`, `krouter_search`, `krouter_suggest`.
- Bridge tests on the template vault. No write routes. Uninstall does not delete the vault.
- Same `OBSIDIAN_VAULT` and alias map as Cursor and Codex.

## 0.2.0 — 2026-08-21

- CI: pytest + `first_run.sh` on every push to `main`.
- `suggest` route: prefix/overlap alias hints on a miss. Hints are not hits.
- Miss receipts include `suggestions:` so an agent can retry one noun.
- Public unit tests for exact match, same-file ties, and ambiguous miss.

## 0.1.0 — 2026-08-21

- First public template: five zones, short-noun router, install, architecture docs.
