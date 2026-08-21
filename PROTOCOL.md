# Protocol

KRouter Obsidian. Architecture: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

1. Five zones: `01 项目` in progress; `02 经验与方法` verified reusable methods; `03 资料与证据` inputs and evidence; `04 已完成与复盘` finished results; `05 时间日志` what happened that day.
2. Four maturity layers: full logs → distillation → promotion → retrieval. Formal `02` requires the promotion gates: five conditions into `provisional` the same day; on the next similar task ask whether to adopt; host adopts and that task is accepted → `active`. Candidates stay in projects or materials.
3. On conflict: the current user instruction and the latest `supersedes` beat old logs.
4. Clippings originals are copied only. Do not move them.
5. Routing: match `canonical_sources.psv` with a short noun (exact > alias in query > query in alias; same score and same file → lowest id; otherwise no hit). Open that page. On a miss, print alias suggestions (hints only) and literal-search the route’s scope. No vector store.
6. Every route prints a receipt: time, source path, source SHA-256, map SHA-256.
7. If daily evolution uses a local agent CLI, pin the binary. Do not use a PATH-level `agent`.
8. Cursor, Codex, and DeepSeek Harness are mounts on one vault. Sharing is the vault and the alias map, not a second protocol. The DSH plugin is read-only. Uninstalling it does not delete notes.
