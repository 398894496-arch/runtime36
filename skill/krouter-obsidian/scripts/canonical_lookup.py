#!/usr/bin/env python3
"""Pick one canonical row for a literal query. Exit 1 if none or ambiguous."""
from __future__ import annotations

import argparse
import sys
import unicodedata
from pathlib import Path

PARTICLES = set("的了着过地得")


def normalize(value: str) -> str:
    chars: list[str] = []
    for char in value:
        if char in PARTICLES or char.isspace():
            continue
        if unicodedata.category(char).startswith(("P", "S")):
            continue
        chars.append(char.lower())
    return "".join(chars)


def load_rows(path: Path) -> list[tuple[str, list[str], str, str]]:
    rows: list[tuple[str, list[str], str, str]] = []
    for raw in path.read_text(encoding="utf-8").splitlines():
        if not raw or raw.startswith("#"):
            continue
        parts = raw.split("|", 3)
        if len(parts) != 4:
            raise ValueError(f"routing map row: {raw}")
        case_id, aliases_raw, source, anchor = parts
        aliases = [item.strip() for item in aliases_raw.split(";") if item.strip()]
        rows.append((case_id, aliases, source, anchor))
    return rows


def alias_score(query: str, alias: str) -> int:
    q = normalize(query)
    a = normalize(alias)
    if not q or not a:
        return 0
    if a == q:
        return 1000 + len(a)
    if a in q:
        return 500 + len(a)
    if len(q) >= 2 and q in a:
        return 100 + len(q)
    return 0


def scores_for(query: str, rows: list[tuple[str, list[str], str, str]]) -> dict[str, int]:
    scores: dict[str, int] = {}
    for case_id, aliases, _source, _anchor in rows:
        best = 0
        for alias in aliases:
            best = max(best, alias_score(query, alias))
        if best:
            scores[case_id] = best
    return scores


def pick(scores: dict[str, int], source_by_id: dict[str, str]) -> str | None:
    if not scores:
        return None
    top = max(scores.values())
    winners = [case_id for case_id, score in scores.items() if score == top]
    if len(winners) == 1:
        return winners[0]
    if len({source_by_id[case_id] for case_id in winners}) == 1:
        return sorted(winners)[0]
    return None


def lookup(query: str, rows: list[tuple[str, list[str], str, str]]) -> tuple[str, str, str] | None:
    source_by_id = {case_id: source for case_id, _aliases, source, _anchor in rows}
    winner = pick(scores_for(query, rows), source_by_id)
    if winner is None:
        token_scores: dict[str, int] = {}
        for token in query.split():
            for case_id, score in scores_for(token, rows).items():
                token_scores[case_id] = token_scores.get(case_id, 0) + score
        winner = pick(token_scores, source_by_id)
    if winner is None:
        return None
    for case_id, _aliases, source, anchor in rows:
        if case_id == winner:
            return case_id, source, anchor
    return None


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--map", required=True)
    parser.add_argument("--vault", required=True)
    parser.add_argument("--query", required=True)
    args = parser.parse_args()
    rows = load_rows(Path(args.map))
    hit = lookup(args.query, rows)
    if hit is None:
        return 1
    case_id, relative_source, anchor = hit
    source = Path(args.vault) / relative_source
    if not source.is_file():
        print(f"Canonical source missing: {source}", file=sys.stderr)
        return 1
    sys.stdout.write(f"{case_id}|{relative_source}|{anchor}\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
