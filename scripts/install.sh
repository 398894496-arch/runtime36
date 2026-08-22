#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
FORCE=0
WITH_HOOKS=0
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --with-hooks) WITH_HOOKS=1 ;;
    -h|--help)
      printf '%s\n' "usage: install.sh [--force] [--with-hooks]"
      printf '%s\n' "copies the KRouter Obsidian skill to ~/.agents/skills/krouter-obsidian"
      printf '%s\n' "copies a Cursor always-on rule to ~/.cursor/rules/"
      printf '%s\n' "self-evolution timer is on by default; key is the vault page or a logged-in CLI"
      printf '%s\n' "does not overwrite an existing skill unless --force"
      printf '%s\n' "does not enable hooks unless --with-hooks"
      exit 0
      ;;
  esac
done

SKILL_SRC="$ROOT/skill/krouter-obsidian"
SKILL_DST="${KROUTER_SKILL_HOME:-$HOME/.agents/skills/krouter-obsidian}"
RULE_DST="${KROUTER_CURSOR_RULE:-$HOME/.cursor/rules/krouter-obsidian.mdc}"

if [ -e "$SKILL_DST" ] && [ "$FORCE" -ne 1 ]; then
  printf '%s\n' "skill already exists: $SKILL_DST"
  printf '%s\n' "pass --force to replace. Refusing so a live map is not overwritten by the 8-topic template."
  exit 1
fi

mkdir -p "$(dirname "$SKILL_DST")" "$(dirname "$RULE_DST")"
rm -rf "$SKILL_DST"
cp -R "$SKILL_SRC" "$SKILL_DST"
chmod +x "$SKILL_DST/scripts/route_knowledge.sh" "$SKILL_DST/scripts/canonical_lookup.py"
cp "$ROOT/extras/cursor/krouter-obsidian.mdc" "$RULE_DST"

printf '%s\n' "skill: $SKILL_DST"
printf '%s\n' "cursor rule: $RULE_DST"
printf '%s\n' "Codex snippet: $ROOT/extras/codex/AGENTS.snippet.md"
printf '%s\n' "Claude Code snippet: $ROOT/extras/claude-code/CLAUDE.snippet.md"

RUN_SH="$ROOT/extras/host-daily-evolution/run.sh"
chmod +x "$RUN_SH" "$ROOT/extras/host-daily-evolution/check.sh" "$ROOT/extras/host-daily-evolution/resolve.py"
printf '%s\n' "self-evolution writer: $RUN_SH"
printf '%s\n' "timer on by default. paste *_API_KEY on the vault page, or already-logged-in grok/codex/claude."
printf '%s\n' "mounted agent runs status and must tell the host if host_action is present."
if [ -z "${OBSIDIAN_VAULT:-}" ]; then
  printf '%s\n' "timer not loaded: export OBSIDIAN_VAULT to YOUR vault (copy template/ there first), then re-run install.sh."
  printf '%s\n' "do not point the timer at the clone template."
else
  VAULT=$OBSIDIAN_VAULT
  case "$(uname -s)" in
    Darwin)
      DST="$HOME/Library/LaunchAgents/local.dsh-krouter.daily-evolution.plist"
      mkdir -p "$HOME/Library/LaunchAgents"
      sed -e "s|__RUN_SH__|$RUN_SH|g" -e "s|__VAULT__|$VAULT|g" -e "s|__HOME__|$HOME|g" \
        "$ROOT/extras/host-daily-evolution/launchd.example.plist" > "$DST"
      uid=$(id -u)
      launchctl bootout "gui/$uid/local.dsh-krouter.daily-evolution" >/dev/null 2>&1 || true
      if launchctl bootstrap "gui/$uid" "$DST" >/dev/null 2>&1 || launchctl load "$DST" >/dev/null 2>&1; then
        printf '%s\n' "self-evolution timer loaded: $DST vault=$VAULT"
      else
        printf '%s\n' "self-evolution timer plist written: $DST"
      fi
      ;;
    *)
      printf '%s\n' "install extras/host-daily-evolution/cron.example with OBSIDIAN_VAULT=$VAULT"
      ;;
  esac
  python3 "$ROOT/extras/host-daily-evolution/resolve.py" --sync-health --offline >/dev/null || true
fi
printf '%s\n' "next: run ./scripts/first_run.sh against the template, then point OBSIDIAN_VAULT at your vault."

if [ "$WITH_HOOKS" -eq 1 ]; then
  HOOK_DST="${KROUTER_HOOK_HOME:-$HOME/.cursor/hooks/krouter-exec-gate.py}"
  mkdir -p "$(dirname "$HOOK_DST")"
  cp "$ROOT/extras/hooks/exec-gate.py" "$HOOK_DST"
  printf '%s\n' "hook script: $HOOK_DST"
  printf '%s\n' "merge extras/hooks/hooks.json.example into ~/.cursor/hooks.json and replace the python3 path with:"
  printf '%s\n' "python3 $HOOK_DST"
  printf '%s\n' "hook process must inherit OBSIDIAN_VAULT. default install does not rewrite hooks.json."
fi
