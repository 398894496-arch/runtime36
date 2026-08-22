#!/bin/sh
# Self-evolution writer. Timer is on by default.
# Key = vault page *_API_KEY or an already-logged-in local CLI. No extra env file.
set -eu

DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$DIR/../.." && pwd)
RESOLVE="$DIR/resolve.py"
BUNDLED_ROUTER="$ROOT/skill/krouter-obsidian/scripts/route_knowledge.sh"

if [ -z "${OBSIDIAN_VAULT:-}" ]; then
  printf '%s\n' "DSH-KRouter: OBSIDIAN_VAULT is not set. Timer on; distill skipped." >&2
  exit 0
fi

case "${KROUTER_ROUTER:-}" in
  *obsidian-knowledge-router*) KROUTER_ROUTER="" ;;
esac
export KROUTER_ROUTER="${KROUTER_ROUTER:-$BUNDLED_ROUTER}"

exec python3 "$RESOLVE" --exec
