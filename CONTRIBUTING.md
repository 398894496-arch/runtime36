# Contributing

This repo stays a deterministic router. Do not add a vector index, embedding daemon, or retrieval subprocess as the default path.

1. `python3 -m pip install -r requirements.txt -r requirements-dev.txt`
2. `python3 -m pytest -q`
3. `./scripts/first_run.sh`

A miss may print alias **suggestions**. Those are hints to add or retry a noun. They are not `canonical_match: true`.
