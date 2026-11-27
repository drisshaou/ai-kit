# CLAUDE.md — {{PROJECT_NAME}}

You are my co-developer on this project.

## 1. Session Start
Before any work, read this file, `ROADMAP.md`, `BACKLOG.md` and `docs/TESTING.md`.

- **Templates language:** `en` (`~/.claude/templates/en/`)
- **Stack:** {{STACK_SUMMARY}}
- **Containers:** {{CONTAINERS}}
- **Architecture:**
  - `{{DIR_1}}` — {{ROLE_1}}
  - `{{DIR_2}}` — {{ROLE_2}}
  - `AGENTS.md` — pointer to this file for Codex
  - `docs/specs/` — contractual feature specs
  - `docs/tickets/` — atomic tickets derived from specs
  - `docs/adr/` — architecture decision records
  - `docs/drafts/` — non-contractual notes and drafts
- **Commands:** (tests: see `docs/TESTING.md`)
  - Dev: `{{CMD_DEV}}`
  - Format: `{{CMD_FORMAT}}`
  - Lint: `{{CMD_LINT}}`
  - Type-check: `{{CMD_TYPECHECK}}`
  - Build: `{{CMD_BUILD}}`

## 2. Clarify First
If my request is ambiguous or you are unsure of the approach, **stop and ask specific questions** before writing code or modifying files. Never guess.

## 3. Workflow & Coding
- **Simplicity:** prefer the simplest solution reusing existing data/code.
- **Quality:** follow framework conventions; code must pass lint and type-check.
- **Formatting:** never fix formatting by hand; run the format command before proposing a commit.
- **Language:** all code, commits and technical docs in English.
- **Tests:** follow `docs/TESTING.md`. A bug fix or feature comes with a test replaying the exact user behavior.
- **Security:** NEVER hardcode passwords, API keys or tokens; use environment variables (`.env`).
- **Dependencies:** new dependency, even when requested: first propose a solution without it if one exists, then wait for my approval.
- **Continuous Learning:** after a repeated mistake or a complex recurring procedure, suggest `/learn-skill` (`$learn-skill` in Codex) at the end of the task.
- **Skills:** in `.claude/skills/`, linked for Codex in `.agents/skills/`; checked automatically (session start hook and Git `pre-commit`).
- **Workflow** (`$name` in Codex):
  1. `/write-feature-spec setup` → `docs/specs/00-setup.md` (technical base).
  2. `/plan-spec-tickets` → tickets in `docs/tickets/`.
  3. `/implement-ticket` → branch, tests, code, checklist, commit.
  4. `/prepare-pr` → pull request of the ticket.
  5. `/clear`, then step 3 until the spec's last ticket.
  6. `/write-feature-spec <name>` → next feature (`01-…`), then step 2.
  - Anytime: `/learn-skill` turns a repeated procedure into a skill.
- **Git:** strict Conventional Commits.
  - **Branches:** one per ticket (1 ticket = 1 branch = 1 PR): `feat/<short-name>`, `fix/<short-name>`, `refactor/<short-name>`
  - **Commits:** `type(scope): summary` (imperative, max 72 chars, no final period)
  - **Types:** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`

## 4. Project Documentation (approval required)
- Keep up to date: `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Propose each documentation change and wait for my approval before writing it.**
- **End of each task:** check whether a `.md` file (above, linked spec and ticket) must change and propose it.
- **All tickets of a spec done:** propose the spec status "Implemented" and ticking its `ROADMAP.md` line.
- `CHANGELOG.md`: Keep a Changelog, entries under `Unreleased`.
- Postponed or incomplete tasks go in `BACKLOG.md` under "Postponed / Incomplete". Never delete an older entry until done.
- **Only exception to approval:** adding a line under "Postponed / Incomplete" is done without waiting, and reported in "Reports : …". Editing or removing an entry, or other sections, needs approval.
- **This file (`CLAUDE.md`):** a new generic rule is written here **only with my explicit authorization**. Otherwise propose and wait.
- **Writing style** (this file and skills): short complete sentences, no filler; keep commands, paths, code blocks and `/name` ↔ `$name` verbatim.

## 5. Communication ({{REPLY_LANGUAGE}})
- Reply in plain, concise {{REPLY_LANGUAGE}}, even if project files are in another language; translate sentences the skills ask you to tell me.
- Brief explanations unless asked for depth.
- End each turn with a short summary (what was done, files updated) and a single written question to validate the next step.
- In it, add "Reports : …" for what is postponed and added to `BACKLOG.md` (otherwise "{{REPORTS_NONE}}").
- Never say "done" if a part is missing: say "partly done" and list what is missing.
- An approval for a sequence of actions covers the whole sequence: do not ask again along the way.

## 6. Self-Verification Checklist (Pass/Fail with evidence)
Before presenting work or proposing a commit, report each item as Pass / Fail / N/A.
**Every Pass on items 2, 6 and 7 needs evidence** (command and result, branch name, files updated). A Pass without evidence counts as Fail.
1. Asked clarifying questions if anything was unclear? (Pass/Fail/N/A)
2. Tests, lint and type-check pass (format command run)? Evidence: test command from `docs/TESTING.md`, format, lint and type-check commands from section 1, and results (e.g. `make test` → 12/12, `make lint` → 0 errors, `tsc --noEmit` → 0 errors; a command "none" → write e.g. "type-check: none"). With a ticket, every test it lists appears in the output. (Pass/Fail/N/A — N/A only if no code changed)
3. No hardcoded secrets, keys or tokens? (Pass/Fail)
4. No unapproved new dependency? (Pass/Fail)
5. Asked permission before destructive or data-modifying actions? (Pass/Fail/N/A)
6. Branch/commit follow Conventional Commits? Evidence: branch name and commit title. (Pass/Fail/N/A — N/A if no commit yet)
7. `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, linked spec and ticket updated (after approval) if applicable? Evidence: files updated. (Pass/Fail/N/A)
8. Final response concise, clear, in {{REPLY_LANGUAGE}}? (Pass/Fail)

---

## Project Decisions & Off-Limits
- **Do not touch without approval:** {{CRITICAL_ZONES}}
- *(Validated architecture choices go in `docs/adr/`, or here only with my approval.)*
