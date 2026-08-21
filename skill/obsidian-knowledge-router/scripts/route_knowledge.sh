#!/bin/sh
set -eu

if [ -z "${OBSIDIAN_VAULT:-}" ]; then
  printf '%s\n' "set OBSIDIAN_VAULT to your vault root" >&2
  exit 2
fi
VAULT=$OBSIDIAN_VAULT
ROUTE=${1:-}
QUERY=${2:-}

CANONICAL="$VAULT/90 系统文件/状态.md"
PREFERENCES="$VAULT/02 经验与方法/Agent/用户偏好与工作约束.md"
CORRECTIONS="$VAULT/90 系统文件/Agent记忆/纠错与取代记录.md"
MEMORY="$VAULT/90 系统文件/Agent记忆/可靠记忆索引.md"
PROJECTS="$VAULT/01 项目"
CANONICAL_MAP="$(dirname "$0")/canonical_sources.psv"

usage() {
  printf '%s\n' "usage: route_knowledge.sh {status|preference|correction|memory|project|search} [literal query]" >&2
  exit 2
}

frontmatter_value() {
  file=$1
  field=$2
  awk -v field="$field" '
    NR == 1 && $0 == "---" { in_frontmatter=1; next }
    in_frontmatter && $0 == "---" { exit }
    in_frontmatter && index($0, field ":") == 1 {
      sub("^[^:]+:[[:space:]]*", "")
      gsub(/^"|"$/, "")
      print
      exit
    }
  ' "$file"
}

file_sha256() {
  shasum -a 256 -- "$1" | awk '{ print $1 }'
}

emit_receipt() {
  source=$1
  retrieval_status=$2
  printf 'receipt_version: knowledge-route-v2\n'
  printf 'observed_at: %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf 'requested_route: %s\n' "$ROUTE"
  printf 'query: %s\n' "$QUERY"
  printf 'retrieval_status: %s\n' "$retrieval_status"
  printf 'source: %s\n' "$source"
  if [ -f "$source" ]; then
    source_status=$(frontmatter_value "$source" status)
    source_verified_at=$(frontmatter_value "$source" verified_at)
    [ -n "$source_status" ] && printf 'source_status: %s\n' "$source_status"
    [ -n "$source_verified_at" ] && printf 'source_verified_at: %s\n' "$source_verified_at"
    printf 'source_sha256: %s\n' "$(file_sha256 "$source")"
  fi
  [ -f "$CANONICAL_MAP" ] && printf 'canonical_map_sha256: %s\n' "$(file_sha256 "$CANONICAL_MAP")"
}

frontmatter_fields() {
  awk '
    NR == 1 && $0 == "---" { in_frontmatter=1; next }
    in_frontmatter && $0 == "---" { exit }
    in_frontmatter { print }
  ' "$CANONICAL"
}

bounded_search() {
  scope=$1
  [ -n "$QUERY" ] || usage
  emit_receipt "$scope" bounded-literal-search-complete
  printf 'route: %s\n' "$ROUTE"
  printf 'scope: %s\n' "$scope"
  rg -L -F -n -i -C 1 -m 4 --glob '*.md' --glob '!Clippings/**' -- "$QUERY" "$scope" \
    | awk 'NR <= 24 { print } NR == 25 { print "[truncated after 24 lines]"; exit }' || true
}

canonical_lookup() {
  [ -n "$QUERY" ] || return 1
  [ -f "$CANONICAL_MAP" ] || return 1
  compact_query=$(printf '%s' "$QUERY" | sed 's/[[:space:][:punct:]“”‘’《》【】（）？，。！：；、]//g')

  while IFS='|' read -r canonical_id aliases relative_source anchor; do
    case "$canonical_id" in ''|'#'*) continue ;; esac
    matched=false
    saved_ifs=$IFS
    IFS=';'
    for alias in $aliases; do
      compact_alias=$(printf '%s' "$alias" | sed 's/[[:space:][:punct:]“”‘’《》【】（）？，。！：；、]//g')
      case "$compact_query" in *"$compact_alias"*) matched=true; break ;; esac
    done
    IFS=$saved_ifs

    if [ "$matched" = true ]; then
      canonical_source="$VAULT/$relative_source"
      [ -f "$canonical_source" ] || {
        printf 'Canonical source missing: %s\n' "$canonical_source" >&2
        return 1
      }
      emit_receipt "$canonical_source" canonical-match
      printf 'route: canonical\ncanonical_id: %s\ncanonical_source: %s\ncanonical_match: true\n' \
        "$canonical_id" "$canonical_source"
      rg -n -i -F -m 2 -C 1 -- "$anchor" "$canonical_source" || true
      return 0
    fi
  done < "$CANONICAL_MAP"
  return 1
}

[ -d "$VAULT" ] || { printf 'Vault not found: %s\n' "$VAULT" >&2; exit 1; }

case "$ROUTE" in
  preference|correction|memory|project|search)
    canonical_lookup && exit 0
    ;;
esac

case "$ROUTE" in
  status)
    emit_receipt "$CANONICAL" requested-fields-returned
    printf 'route: status\nevidence_scope: selected-frontmatter-fields\n'
    frontmatter_fields
    ;;
  preference)
    bounded_search "$PREFERENCES"
    ;;
  correction)
    bounded_search "$CORRECTIONS"
    ;;
  memory)
    bounded_search "$MEMORY"
    ;;
  project)
    bounded_search "$PROJECTS"
    ;;
  search)
    bounded_search "$VAULT"
    ;;
  *)
    usage
    ;;
esac
