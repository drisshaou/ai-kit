# AGENTS.md — {{PROJECT_NAME}}

Project rules are in `CLAUDE.md`: read it at the start of every session and follow it, as well as the files it lists.

## Security (Codex)
- Never read or modify `.env`, `.env.*` (except `.env.example`) or any secrets file: no rule blocks your file reading, this ban relies on you.
- If a command is refused by `.codex/rules/`, tell me and ask how to proceed.

## Codex equivalents
- **Skills:** `.agents/skills/` (project) and `~/.agents/skills/` (global). They are links to `.claude/skills/` and `~/.claude/skills/`: always create or edit the real file, in `.claude/skills/` for a project skill and in `~/.claude/skills/` for a global skill.
- **Commands:** `/<name>` in `CLAUDE.md` or in a skill = `$<name>` in Codex.
- **Hooks:** `.codex/hooks.json` (Claude Code equivalent: `.claude/settings.json`).
