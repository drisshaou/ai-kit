---
name: project-init
description: Initializes a new project or converts an existing one to the ai-kit workflow, in French or English (CLAUDE.md, AGENTS.md, ROADMAP, BACKLOG, CHANGELOG, TESTING, workflow skills, hooks). Initialise ou convertit un projet au workflow ai-kit, en français ou en anglais. Use only when explicitly asked / seulement sur demande explicite (`/project-init` in Claude Code, `$project-init` in Codex).
disable-model-invocation: true
---

# project-init

You are my co-developer and software architect. Your mission is to lay clean foundations for this project without ever guessing what is missing.

## Phase 0: Languages
Ask first, in both languages, two questions:
1. "Langue du projet / Project language: **fr** or **en**?" → `<lang>`: every project file is written in this language.
2. "Langue des réponses / Reply language: **fr** or **en**? (par défaut / default: `<lang>`)" → `<reply>`: from then on, talk to me in this language, during this skill and in every later session.

In `CLAUDE.md`, fill `{{REPLY_LANGUAGE}}` with the name of `<reply>` written in `<lang>` (fr project: « français » / « anglais »; en project: "French" / "English"), and `{{REPORTS_NONE}}` with Reports : aucun nouveau if `<reply>` is fr, Reports: none if it is en (no quotes: the template already has them).
- All templates come from `~/.claude/templates/<lang>/`; shared files (`settings.tpl.json`, `codex-hooks.tpl.json`, `codex-rules.tpl.rules`, `pre-commit.tpl.sh`, `check-skill.sh`) are in `~/.claude/templates/`.
- If `<lang>` is **fr**, also ask for the language rule for code and commits (placeholder `{{CODE_LANGUAGE_RULE}}`).

## Phase 1: Context detection
Analyze the current directory (`ls -la`, `git status`, config files: `package.json`, `composer.json`, `pyproject.toml`, `Cargo.toml`, `Makefile`, `CMakeLists.txt`, `Dockerfile`, etc.) and decide whether the project is **NEW** or **EXISTING**. Also detect:
- **existing tests**: folders (`tests/`, `test/`, `__tests__/`, `spec/`…), files (`*.spec.*`, `*.test.*`, `test_*`…), tool config (`vitest.config.*`, `jest.config.*`, `pytest.ini`, `[tool.pytest]`, `test`/`check` targets of the `Makefile`, `test` script of `package.json`…);
- **containers**: `Dockerfile`, `compose.yaml`/`compose.yml`/`docker-compose.yml`/`docker-compose.yaml`, `.devcontainer/`, and the declared services;
- **installed runtime versions** of the stack (`node -v`, `python3 --version`…), to check before proposing a version;
- **existing Git hooks**: `git config core.hooksPath`, `.git/hooks/` (except `*.sample`), `.husky/`, `lefthook.yml`, `.pre-commit-config.yaml`;
- kit files already present (`CLAUDE.md`, `AGENTS.md`, `ROADMAP.md`, `.claude/settings.json`, `.claude/skills/`, `.codex/hooks.json`…).

Show a short diagnosis (5 lines max), including what was found for tests, containers and hooks.

## Phase 2: Guided interview (GENERATE NO FILE BEFORE THE END)
Ask your questions in blocks of 3 to 4 at most and wait for my answers before going on.
- **If NEW:** 1. product goal in 2 sentences and target users; 2. required tech stack; 3. strict MVP scope (`v0.1`) and what is explicitly out of scope; 4. non-negotiable conventions or constraints (security, CI/CD); 5. planned commands (dev, lint, build): those I give, otherwise "to be defined".
- **If EXISTING:** 1. validate the real commands detected (dev, lint, build); 2. critical areas or tech debt not to break; 3. the next 2 priority milestones; 4. implicit conventions missing from the code; 5. product goal in 2 sentences, target users and what is explicitly out of scope (for `ROADMAP.md`).
- **Tests (both cases):** tests detected → validate the tool, location, naming and commands found with me. No tests → propose 1 to 2 tools suited to the stack, then ask for the tool, location and naming. **Install nothing**: installing a tool is a new dependency, done later, after my approval, in a dedicated ticket. The status in `docs/TESTING.md` will then be "Not installed" (en) / « Non installé » (fr).
- **Containers (both cases):** always ask, never deduce the answer (not even from "local dev"): containers yes or no (Docker Compose, devcontainer)? If yes: which service runs tests and lint, and do the commands run inside the container (`docker compose exec <service> …`) or on the host? Write every command exactly as it will be run.
- **Git hooks:** if hooks already exist (Husky, lefthook, pre-commit, `core.hooksPath`…), change nothing and ask me how to add the skill check (a line added to the existing hook, or nothing).

End with a summary of the interview and wait for my validation.

## Phase 3: Generating the structure
Once the summary is validated, generate, strictly following the templates:
1. `CLAUDE.md` from `CLAUDE.tpl.md` (strictly < 150 lines). If the project has no linter, write `none` (en) / `aucun` (fr) for `{{CMD_LINT}}`. `{{CONTAINERS}}`: the tool and services, and where commands run (e.g. `Docker Compose (web, api), commands run in the containers`), or `none` / `aucun`.
2. `AGENTS.md` from `AGENTS.tpl.md`.
3. `ROADMAP.md`, `BACKLOG.md`, `CHANGELOG.md` from their templates.
4. `docs/TESTING.md` from `TESTING.tpl.md`, filled with the answers of the Tests and Containers parts.
5. `.claude/settings.json` from `settings.tpl.json` (permissions adapted to the validated commands + `SessionStart` hook). **Remove every `allow` line whose command is unknown, empty, `none` or `aucun`**: an empty `{{CMD_TEST}}` would give `Bash( *)`.
6. `.codex/hooks.json` from `codex-hooks.tpl.json`, and `.codex/rules/default.rules` from `codex-rules.tpl.rules`.
7. **Workflow skills, in `<lang>`:** copy each folder of `~/.claude/templates/<lang>/skills/` into `.claude/skills/`, copy `~/.claude/templates/check-skill.sh` to `.claude/skills/learn-skill/scripts/check-skill.sh` (executable), then for each skill create the Codex link `ln -s ../../.claude/skills/<name> .agents/skills/<name>` and run `.claude/skills/learn-skill/scripts/check-skill.sh validate .claude/skills <name> --agents .agents/skills`. Give the output as evidence.
8. `.githooks/pre-commit` from `pre-commit.tpl.sh`, made executable, then `git config core.hooksPath .githooks` — **only if no hook existed** (otherwise apply what was decided in Phase 2).
9. The folders `docs/specs/`, `docs/adr/`, `docs/tickets/`, `docs/drafts/` (with a `.gitkeep` in each empty folder).
10. If relevant, `docs/adr/001-stack-and-architecture.md` from `ADR.tpl.md`.
11. Add `.claude/settings.local.json` to the project's `.gitignore` (create the file if missing; if it exists, propose the addition and wait for my approval).

If one of these files already exists, do not overwrite it: propose the changes and wait for my approval.
At the end, remind me that Codex will ask to approve the new hook once (`/hooks` in Codex).
Write no application code during this skill.
