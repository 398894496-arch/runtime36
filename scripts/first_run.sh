#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
# Always the bundled template unless the host names another vault for this script.
# Do not inherit OBSIDIAN_VAULT; that may point at an unrelated live library.
export OBSIDIAN_VAULT="${KROUTER_FIRST_RUN_VAULT:-$ROOT/template}"
ROUTER="$ROOT/skill/krouter-obsidian/scripts/route_knowledge.sh"

if ! command -v python3 >/dev/null 2>&1; then
  printf '%s\n' "python3 required" >&2
  exit 1
fi
if ! command -v rg >/dev/null 2>&1; then
  printf '%s\n' "ripgrep (rg) required" >&2
  exit 1
fi

fail=0
assert_match() {
  query=$1
  expect_id=$2
  expect_name=$3
  out=$("$ROUTER" search "$query") || {
    printf '%s\n' "FAIL search $query (router exit)" >&2
    fail=1
    return
  }
  printf '%s\n' "$out" | grep -q "canonical_id: $expect_id" || {
    printf '%s\n' "FAIL search $query expected $expect_id" >&2
    printf '%s\n' "$out" >&2
    fail=1
    return
  }
  printf '%s\n' "$out" | grep -q "$expect_name" || {
    printf '%s\n' "FAIL search $query expected path containing $expect_name" >&2
    fail=1
    return
  }
  printf '%s\n' "ok search $query -> $expect_id"
}

printf '%s\n' "== status =="
status=$("$ROUTER" status)
printf '%s\n' "$status" | grep -q "source: $OBSIDIAN_VAULT/Agent第二大脑.md" || {
  printf '%s\n' "FAIL status did not point at Agent第二大脑.md" >&2
  printf '%s\n' "$status" >&2
  fail=1
}
printf '%s\n' "ok status -> Agent第二大脑.md"

printf '%s\n' "== short-noun routing =="
assert_match "入口" "Q01" "Agent第二大脑.md"
assert_match "剪藏" "Q02" "用户偏好与工作约束.md"
assert_match "纠正" "Q05" "纠错与取代记录.md"

printf '%s\n' "== validate template day =="
if python3 -c "import yaml" 2>/dev/null; then
  if python3 "$ROOT/scripts/validate_vault.py" --from-date 2026-01-01 --through-date 2026-01-01; then
    printf '%s\n' "ok validate_vault.py"
  else
    printf '%s\n' "FAIL validate_vault.py" >&2
    fail=1
  fi
else
  printf '%s\n' "skip validate_vault.py (install PyYAML to run it)"
fi

printf '%s\n' ""
printf '%s\n' "First run passed on $OBSIDIAN_VAULT"
printf '%s\n' "Next: copy template/ to your Obsidian vault, rewrite skill/krouter-obsidian/scripts/canonical_sources.psv with your own topics, keep OBSIDIAN_VAULT pointed at that vault."

[ "$fail" -eq 0 ]
