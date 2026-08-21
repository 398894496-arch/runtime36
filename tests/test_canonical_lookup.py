from pathlib import Path

import pytest

from canonical_lookup import lookup, near_score, suggestions

ROOT = Path(__file__).resolve().parents[1]
MAP = ROOT / "skill/krouter-obsidian/scripts/canonical_sources.psv"
VAULT = ROOT / "template"


@pytest.fixture(scope="module")
def rows():
    from canonical_lookup import load_rows

    return load_rows(MAP)


def test_exact_home(rows):
    hit = lookup("home", rows)
    assert hit is not None
    assert hit[0] == "Q01"
    assert hit[1] == "Agent第二大脑.md"


def test_clippings(rows):
    hit = lookup("clippings", rows)
    assert hit is not None
    assert hit[0] == "Q02"


def test_ambiguous_different_files_is_miss(tmp_path):
    from canonical_lookup import load_rows, lookup

    path = tmp_path / "map.psv"
    path.write_text("Q1|alpha|a.md|x\nQ2|alpha|b.md|y\n", encoding="utf-8")
    rows = load_rows(path)
    assert lookup("alpha", rows) is None


def test_same_file_tie_picks_lowest_id(tmp_path):
    from canonical_lookup import load_rows, lookup

    path = tmp_path / "map.psv"
    path.write_text("Q2|alpha|a.md|x\nQ1|alpha|a.md|y\n", encoding="utf-8")
    rows = load_rows(path)
    hit = lookup("alpha", rows)
    assert hit is not None
    assert hit[0] == "Q1"


def test_prefix_is_suggestion_not_hit(rows):
    assert lookup("homz", rows) is None
    ranked = suggestions("homz", rows, limit=3)
    ids = [item[1] for item in ranked]
    assert "Q01" in ids
    assert near_score("homz", "home") >= 40


def test_template_sources_exist(rows):
    for _case_id, _aliases, source, _anchor in rows:
        assert (VAULT / source).is_file(), source
