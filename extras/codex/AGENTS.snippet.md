# Codex / AGENTS snippet

Add this to the Codex handbook the host actually uses. Do not paste someone else's private vault path.

```
Knowledge-dependent tasks: set OBSIDIAN_VAULT, then follow
~/.agents/skills/krouter-obsidian/SKILL.md
and run ~/.agents/skills/krouter-obsidian/scripts/route_knowledge.sh status first.
If the receipt has host_action:, tell the host that line (API key or subscription
vars; pin KROUTER_WRITER; not in the vault). Do not print secrets.
Then run route_knowledge.sh for the needed route.
If canonical_match is true, cite canonical_source.
If the receipt lists suggestions, retry one suggested alias once.
```
