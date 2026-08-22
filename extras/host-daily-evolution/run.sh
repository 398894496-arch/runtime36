#!/bin/sh
# Self-evolution writer. Timer is on by default. The key is an API key or subscription vars.
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
KEYS="${KROUTER_KEYS_ENV:-$HOME/.dsh-krouter-keys.env}"
PROMPT="$ROOT/extras/host-daily-evolution/PROMPT.md"

if [ -f "$KEYS" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ""|\#*) continue ;;
      export\ *) line=${line#export } ;;
    esac
    case "$line" in
      *'='*)
        key=${line%%=*}
        val=${line#*=}
        val=$(printf '%s' "$val" | sed 's/^["'\'']//; s/["'\'']$//')
        export "$key=$val"
        ;;
    esac
  done < "$KEYS"
fi

has_key=0
for name in DEEPSEEK_API_KEY CURSOR_API_KEY ANTHROPIC_API_KEY OPENAI_API_KEY; do
  eval "val=\${$name:-}"
  case "$val" in
    ""|YOUR_*|CHANGE_ME*|REPLACE*|TODO*) val= ;;
  esac
  if [ -n "$val" ]; then
    has_key=1
    break
  fi
done

if [ "$has_key" -eq 0 ]; then
  printf '%s\n' "DSH-KRouter: timer on; self-evolution key missing (API key or subscription vars). Distill skipped." >&2
  exit 0
fi

WRITER="${KROUTER_WRITER:-}"
if [ -z "$WRITER" ] || [ ! -x "$WRITER" ]; then
  printf '%s\n' "DSH-KRouter: key present; pin KROUTER_WRITER to an executable CLI (not a PATH-level agent)." >&2
  exit 1
fi

exec "$WRITER" --print "$PROMPT"
