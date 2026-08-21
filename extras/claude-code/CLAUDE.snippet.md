# Claude Code / CLAUDE.md snippet

Add this to the Claude Code handbook the host actually uses. Do not paste someone else's private vault path.

The shared skill after `./scripts/install.sh` is `~/.agents/skills/krouter-obsidian` — Claude Code can load that path. This snippet is the mount, not a second knowledge base.

```
Knowledge-dependent tasks: set OBSIDIAN_VAULT, then follow
~/.agents/skills/krouter-obsidian/SKILL.md
and run ~/.agents/skills/krouter-obsidian/scripts/route_knowledge.sh.
If canonical_match is true, cite canonical_source.
If the receipt lists suggestions, retry one suggested alias once.
Do not add a vector store. Do not treat this snippet as daily self-evolution.
```
