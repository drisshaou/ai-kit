# AGENTS.md — {{PROJECT_NAME}}
Project rules: `CLAUDE.md`. Read it at every session start; follow it and the files it lists.

## Security (Codex)
- Never read/modify `.env`, `.env.*` (except `.env.example`) or any secrets file. No rule blocks your file reading: this ban relies on you.
- Command refused by `.codex/rules/` → tell me, ask how to proceed.

## Codex equivalents
- Skills: `.agents/skills/` (project), `~/.agents/skills/` (global) = links to `.claude/skills/`, `~/.claude/skills/`. Always create/edit the real file: `.claude/skills/` (project) or `~/.claude/skills/` (global).
- `/<name>` in `CLAUDE.md` or a skill = `$<name>` in Codex.
- Hooks: `.codex/hooks.json` (Claude Code: `.claude/settings.json`).
