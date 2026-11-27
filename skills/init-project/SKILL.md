---
name: init-project
description: Initializes a new project or converts an existing one to the ai-kit workflow, in French or English (CLAUDE.md, AGENTS.md, ROADMAP, BACKLOG, CHANGELOG, TESTING, workflow skills, hooks). Initialise ou convertit un projet au workflow ai-kit, en français ou en anglais. Use only when explicitly asked / seulement sur demande explicite (`/init-project` in Claude Code, `$init-project` in Codex).
disable-model-invocation: true
---

# init-project
Role: co-developer and software architect. Lay clean foundations; never guess what is missing.

## Phase 0: Languages
Ask first, in both languages:
1. "Langue du projet / Project language: **fr** or **en**?" → `<lang>`: language of every project file.
2. "Langue des réponses / Reply language: **fr** or **en**? (par défaut / default: `<lang>`)" → `<reply>`: talk to me in it from now on, in this skill and every later session.

- `CLAUDE.md`: `{{REPLY_LANGUAGE}}` = name of `<reply>` written in `<lang>` (fr project: « français » / « anglais »; en project: "French" / "English"); `{{REPORTS_NONE}}` = Reports : aucun nouveau if `<reply>` is fr, Reports: none if en (no quotes: the template has them).
- Templates: `~/.claude/templates/<lang>/`; shared files (`settings.tpl.json`, `codex-hooks.tpl.json`, `codex-rules.tpl.rules`, `pre-commit.tpl.sh`, `check-skill.sh`) in `~/.claude/templates/`.
- `<lang>` = **fr** → also ask the language rule for code and commits (`{{CODE_LANGUAGE_RULE}}`).

## Phase 1: Detection
Analyze the directory (`ls -la`, `git status`, config files: `package.json`, `composer.json`, `pyproject.toml`, `Cargo.toml`, `Makefile`, `CMakeLists.txt`, `Dockerfile`…) → project **NEW** or **EXISTING**. Also detect:
- **tests**: folders (`tests/`, `test/`, `__tests__/`, `spec/`…), files (`*.spec.*`, `*.test.*`, `test_*`…), tool config (`vitest.config.*`, `jest.config.*`, `pytest.ini`, `[tool.pytest]`, `test`/`check` targets of `Makefile`, `test` script of `package.json`…);
- **containers**: `Dockerfile`, `compose.yaml`/`compose.yml`/`docker-compose.yml`/`docker-compose.yaml`, `.devcontainer/`, declared services;
- **installed runtime versions** (`node -v`, `python3 --version`…), checked before proposing a version;
- **Git hooks**: `git config core.hooksPath`, `.git/hooks/` (except `*.sample`), `.husky/`, `lefthook.yml`, `.pre-commit-config.yaml`;
- kit files already present (`CLAUDE.md`, `AGENTS.md`, `ROADMAP.md`, `.claude/settings.json`, `.claude/skills/`, `.codex/hooks.json`…).

Short diagnosis (≤5 lines), incl. tests, containers, hooks.

## Phase 2: Interview (NO FILE BEFORE THE END)
Questions in blocks of 3-4 max; wait for answers before going on.
- **NEW:** 1. product goal (2 sentences) + target users; 2. required stack; 3. strict MVP (`v0.1`) + explicit out of scope; 4. non-negotiable conventions/constraints (security, CI/CD); 5. planned commands (dev, lint, build): mine, else "to be defined".
- **EXISTING:** 1. validate detected commands (dev, lint, build); 2. critical areas / tech debt not to break; 3. next 2 priority milestones; 4. implicit conventions missing from the code; 5. product goal (2 sentences), target users, explicit out of scope (for `ROADMAP.md`).
- **Tests (both):** detected → validate tool, location, naming, commands. None → propose 1-2 tools for the stack, ask tool, location, naming. **Install nothing** (new dependency → later, after approval, dedicated ticket). `docs/TESTING.md` status then "Not installed" (en) / « Non installé » (fr).
- **Containers (both):** always ask, never deduce (not even from "local dev"): containers yes/no (Docker Compose, devcontainer)? Yes → which service runs tests and lint; commands inside the container (`docker compose exec <service> …`) or on the host? Write every command exactly as run.
- **Git hooks:** existing (Husky, lefthook, pre-commit, `core.hooksPath`…) → change nothing; ask how to add the skill check (line in the existing hook, or nothing).

End with an interview summary; wait for my validation.

## Phase 3: Generation
Once validated, strictly per the templates:
1. `CLAUDE.md` from `CLAUDE.tpl.md` (< 150 lines). No linter → `{{CMD_LINT}}` = `none` (en) / `aucun` (fr). `{{CONTAINERS}}` = tool, services, where commands run (e.g. `Docker Compose (web, api), commands run in the containers`), or `none` / `aucun`.
2. `AGENTS.md` from `AGENTS.tpl.md`.
3. `ROADMAP.md`, `BACKLOG.md`, `CHANGELOG.md` from their templates.
4. `docs/TESTING.md` from `TESTING.tpl.md`, with the Tests and Containers answers.
5. `.claude/settings.json` from `settings.tpl.json` (permissions for the validated commands + `SessionStart` hook). **Remove every `allow` line whose command is unknown, empty, `none` or `aucun`** (empty `{{CMD_TEST}}` → `Bash( *)`).
6. `.codex/hooks.json` from `codex-hooks.tpl.json`; `.codex/rules/default.rules` from `codex-rules.tpl.rules`.
7. **Workflow skills in `<lang>`:** copy each folder of `~/.claude/templates/<lang>/skills/` into `.claude/skills/`; copy `~/.claude/templates/check-skill.sh` to `.claude/skills/learn-skill/scripts/check-skill.sh` (executable); per skill: `ln -s ../../.claude/skills/<name> .agents/skills/<name>`, then `.claude/skills/learn-skill/scripts/check-skill.sh validate .claude/skills <name> --agents .agents/skills`. Give the output as evidence.
8. `.githooks/pre-commit` from `pre-commit.tpl.sh` (executable), then `git config core.hooksPath .githooks`, **only if no hook existed** (else apply the Phase 2 decision).
9. Folders `docs/specs/`, `docs/adr/`, `docs/tickets/`, `docs/drafts/` (`.gitkeep` in each empty one).
10. If relevant: `docs/adr/001-stack-and-architecture.md` from `ADR.tpl.md`.
11. Add `.claude/settings.local.json` to `.gitignore` (create if missing; exists → propose the addition, wait for approval).

- Existing file → never overwrite: propose changes, wait for approval.
- At the end: remind me Codex asks once to approve the new hook (`/hooks` in Codex).
- No application code in this skill.
