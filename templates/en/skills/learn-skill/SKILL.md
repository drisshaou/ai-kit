---
name: learn-skill
description: Captures a recurring mistake or a complex procedure by proposing a rule for CLAUDE.md or a new skill (project scope by default, shared between Claude Code and Codex, checked by script). Use only when the user explicitly asks for it (`/learn-skill` in Claude Code, `$learn-skill` in Codex).
disable-model-invocation: true
---

# learn-skill
Analyze the current session (mistake, fix or complex procedure). Topic: given after the skill name; none → infer from the session, have me confirm.

- `CHECK` = project script `.claude/skills/learn-skill/scripts/check-skill.sh` (run from repo root).
- `KIT` = kit folder: `KIT="$(dirname "$(dirname "$(readlink ~/.claude/skills/init-project)")")"`.

## 1. Medium
- **Rule in `CLAUDE.md`:** short permanent project-wide rule (1-2 lines). Applies to Codex too (reads `CLAUDE.md` via `AGENTS.md`).
- **Skill (`SKILL.md`):** detailed procedure, precise technical pattern or specific pitfall (loaded on demand).

## 2. Scope
- **Project (default):** `.claude/skills/<name>/SKILL.md` at repo root + Codex link `.agents/skills/<name>`.
- **Global (only if I explicitly ask):** `$KIT/skills/<name>/SKILL.md` + links `~/.claude/skills/<name>` and `~/.agents/skills/<name>`.
- **Free name (mandatory, any scope):** `ls -d .claude/skills/<name> ~/.claude/skills/<name> ~/.agents/skills/<name> "$KIT/skills/<name>" ~/.claude/templates/*/skills/<name> 2>/dev/null` must print nothing; else name taken (project, personal, kit or workflow skill) → propose another.
- **Before a global skill:** must cite nothing project-specific (language, framework, tool, dependency, path, command, file name). Found → **not global**: list the items, propose project scope. Global only if I confirm after seeing the list.

## 3. Writing (Claude Code / Codex parity)
- English (project language), per `~/.claude/templates/en/SKILL.tpl.md`; `name` = folder name.
- Style: compact (imperative bullets, `Key: value`, no filler); frontmatter, commands, paths, code blocks kept verbatim. Same style for a `CLAUDE.md` rule.
- Any agent-specific mention gives the other's equivalent:

| Claude Code | Codex |
|-------------|-------|
| `/<name>` | `$<name>` |
| `.claude/skills/` | `.agents/skills/` |
| `~/.claude/skills/` | `~/.agents/skills/` |
| `.claude/settings.json` (hooks) | `.codex/hooks.json` |

- Citing `CLAUDE.md` is fine (rules file of both agents). No equivalent → flag it in the proposal, never remove silently.
- Skill calls always in backticks: `` `/<name>` `` and `` `$<name>` ``. A `/name` without backticks reads as a path and is not checked.

## 4. Proposal (mandatory)
Show exact text, chosen medium and **full destination path**. **Write nothing until I explicitly authorize.**

## 5. Create & check
After authorization:
- **Rule:** add to `CLAUDE.md` (must stay < 150 lines).
- **Project skill** (from repo root):
  1. write `.claude/skills/<name>/SKILL.md`;
  2. `mkdir -p .agents/skills && ln -s ../../.claude/skills/<name> .agents/skills/<name>` (relative link, valid after a clone);
  3. `CHECK validate .claude/skills <name> --agents .agents/skills`
- **Global skill:**
  1. write `$KIT/skills/<name>/SKILL.md`;
  2. `ln -s "$KIT/skills/<name>" ~/.claude/skills/<name> && ln -s "$KIT/skills/<name>" ~/.agents/skills/<name>`;
  3. `CHECK validate "$KIT/skills" <name> --agents ~/.agents/skills`
- Give the script output as evidence. `FAIL` → fix only the reported items, show the fix, rerun only after my approval.

## 6. Commit (+ push for a global skill)
Output `PASS` → propose the commit, wait for approval ("commit then push" approval covers both):
- **Project:** project repo, current branch: `.claude/skills/<name>/`, link `.agents/skills/<name>`, `.claude/skills/.validated`. Project `pre-commit` rechecks. No direct push: ships with the current PR.
- **Global:** kit repo (`git -C "$KIT" …`): `skills/<name>/`, `skills/.validated`. Kit `pre-commit` rechecks. Remote exists (`git -C "$KIT" remote`) → propose the push.
- Title: Conventional Commits (e.g. `feat(skills): add <name>`).
