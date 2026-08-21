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
printf '%s\n' "next: export OBSIDIAN_VAULT to your vault (or $ROOT/template) then run ./scripts/first_run.sh"

if [ "$WITH_HOOKS" -eq 1 ]; then
  HOOK_DST="${KROUTER_HOOK_HOME:-$HOME/.cursor/hooks/krouter-exec-gate.py}"
  mkdir -p "$(dirname "$HOOK_DST")"
  cp "$ROOT/extras/hooks/exec-gate.py" "$HOOK_DST"
  printf '%s\n' "hook script: $HOOK_DST"
  printf '%s\n' "merge extras/hooks/hooks.json.example into ~/.cursor/hooks.json and replace the python3 path with:"
  printf '%s\n' "python3 $HOOK_DST"
  printf '%s\n' "hook process must inherit OBSIDIAN_VAULT. default install does not rewrite hooks.json."
fi
