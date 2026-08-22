#!/bin/sh
# Self-evolution writer. Timer is on by default.
# Key = vault page *_API_KEY or an already-logged-in local CLI. No extra env file.
set -eu

DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
RESOLVE="$DIR/resolve.py"

if [ -z "${OBSIDIAN_VAULT:-}" ]; then
  printf '%s\n' "DSH-KRouter: OBSIDIAN_VAULT is not set. Timer on; distill skipped." >&2
  exit 0
fi

exec python3 "$RESOLVE" --exec
