#!/usr/bin/env python3
"""Set a frontmatter field on the daily-evolution health page. Never writes secrets."""

from __future__ import annotations

import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit("usage: patch_health.py HEALTH_MD field value")
    path = Path(sys.argv[1])
    field = sys.argv[2]
    value = sys.argv[3]
    if field not in {"lamp", "self_evolution_key", "krouter_writer"}:
        raise SystemExit("field not allowed")
    if value not in {"running", "unused", "missing", "present", "dead", "unknown"}:
        raise SystemExit("value not allowed")
    if not path.is_file():
        raise SystemExit(0)
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---"):
        raise SystemExit(0)
    parts = text.split("---", 2)
    if len(parts) < 3:
        raise SystemExit(0)
    lines = parts[1].splitlines()
    out: list[str] = []
    found = False
    for line in lines:
        if line.startswith(field + ":"):
            out.append(f"{field}: {value}")
            found = True
        else:
            out.append(line)
    if not found:
        inserted = False
        new: list[str] = []
        for line in out:
            new.append(line)
            if line.startswith("lamp:") and not inserted:
                new.append(f"{field}: {value}")
                inserted = True
        if not inserted:
            new.append(f"{field}: {value}")
        out = new
    path.write_text("---" + "\n".join(out) + "\n---" + parts[2], encoding="utf-8")


if __name__ == "__main__":
    main()
