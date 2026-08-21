#!/bin/sh
# Prove the self-evolution extra is present and the vault lamp is readable.
# Does not start cron/launchd. unused is a valid skip.
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
VAULT="${OBSIDIAN_VAULT:-$ROOT/template}"
HEALTH="$VAULT/90 系统文件/自动化/日更健康.md"

if [ ! -f "$HEALTH" ]; then
  printf '%s\n' "FAIL missing health page: $HEALTH" >&2
  exit 1
fi

lamp=$(awk '
  BEGIN { in_fm=0 }
  /^---$/ { in_fm++; if (in_fm==2) exit }
  in_fm==1 && $1=="lamp:" { print $2; exit }
' "$HEALTH")
lamp=${lamp:-unset}

case "$lamp" in
  unused)
    printf '%s\n' "ok self-evolution lamp=unused on $HEALTH"
    ;;
  running)
    printf '%s\n' "ok self-evolution lamp=running on $HEALTH"
    ;;
  *)
    printf '%s\n' "FAIL lamp must be unused or running (got: $lamp) in $HEALTH" >&2
    printf '%s\n' "skip daily evolution: set lamp: unused. run it: set lamp: running after the OS scheduler is loaded." >&2
    exit 1
    ;;
esac

for f in README.md PROMPT.md check.sh launchd.example.plist cron.example; do
  p="$ROOT/extras/host-daily-evolution/$f"
  if [ ! -f "$p" ]; then
    printf '%s\n' "FAIL missing extra file: $p" >&2
    exit 1
  fi
done

printf '%s\n' "ok self-evolution extra files present (scheduler not installed by this check)"
