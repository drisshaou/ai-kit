# CLAUDE.md — {{PROJECT_NAME}}

You are my co-developer on this project.

## 1. Context & Starting a Session
Before starting any work, read this file, `ROADMAP.md`, `BACKLOG.md` and `docs/TESTING.md` to understand the current state, goals and how the project is tested.

- **Templates language:** `en` (`~/.claude/templates/en/`)
- **Stack:** {{STACK_SUMMARY}}
- **Containers:** {{CONTAINERS}}
- **Architecture:**
  - `{{DIR_1}}` — {{ROLE_1}}
  - `{{DIR_2}}` — {{ROLE_2}}
  - `AGENTS.md` — Pointer to this file for Codex
  - `docs/specs/` — Contractual feature specifications
  - `docs/tickets/` — Atomic tickets derived from specs
  - `docs/adr/` — Architecture decision records
  - `docs/drafts/` — Rough notes, research, and non-contractual drafts
- **Key Commands:** (tests: see `docs/TESTING.md`)
  - Dev: `{{CMD_DEV}}`
  - Lint / Format: `{{CMD_LINT}}`
  - Build: `{{CMD_BUILD}}`

## 2. Clarification First (Crucial)
If my request is ambiguous, lacks context, or if you are unsure about the best approach, **stop and ask me specific clarifying questions** before writing any code or modifying files. Do not guess or make assumptions on my behalf.

## 3. Workflow & Coding
- **Simplicity:** Look for the simplest solution using existing data/code before inventing complex mechanisms.
- **Conventions & Quality:** Follow the native conventions of the framework. Ensure all code passes the project's linter/formatter silently.
- **Language:** Write all code, commits, and technical documentation in English.
- **Tests:** Follow `docs/TESTING.md`. When fixing a bug or adding a feature, ensure a test replays the exact user gesture or behavior.
- **Security:** NEVER hardcode passwords, API keys, or tokens. Always use environment variables (`.env`).
- **Dependencies:** Never add a new dependency without my approval.
- **Continuous Learning:** If you make a repeated mistake or we establish a complex recurring procedure, suggest running `/learn-skill` (`$learn-skill` in Codex) at the end of the task.
- **Skills:** project skills live in `.claude/skills/` and are linked for Codex in `.agents/skills/`. Their conformity is checked automatically (session start hook and Git `pre-commit`).
- **Workflow** (`$name` in Codex):
  1. `/write-feature-spec setup` → `docs/specs/00-setup.md` (technical base).
  2. `/plan-spec-tickets` → small tickets in `docs/tickets/`.
  3. `/implement-ticket` → branch, tests, code, checklist, commit.
  4. `/prepare-pr` → pull request of the ticket.
  5. `/clear`, then back to step 3 until the spec's last ticket.
  6. `/write-feature-spec <name>` → next feature (`01-…`), then step 2.
  - Anytime: `/learn-skill` turns a repeated procedure into a skill.
- **Git (AI & Human reference):** Use strict "Conventional Commits".
  - **Branches:** one branch per ticket (1 ticket = 1 branch = 1 PR): `feat/<short-name>`, `fix/<short-name>`, `refactor/<short-name>`
  - **Commits:** `type(scope): summary` (imperative mood, max 72 chars, no final period)
  - **Types:** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`

## 4. Project Documentation (approval required)
- Keep every project `.md` file up to date: `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Propose each documentation change and wait for my approval before writing it.**
- **At the end of each task:** check whether a `.md` file must change (those above, the linked spec and ticket) and propose the change.
- **When all tickets of a spec are done:** propose to set its status to "Implemented" and to tick its line in `ROADMAP.md`.
- `CHANGELOG.md` follows Keep a Changelog; add entries under `Unreleased`.
- Log incomplete or postponed tasks in `BACKLOG.md` under "Postponed / Incomplete". Never delete an older entry until it is done.
- **Only exception to approval:** adding a line under "Postponed / Incomplete" is done without waiting, and reported in "Reports : …". Editing or removing an entry, or touching other sections, requires my approval.
- **This file (`CLAUDE.md`):** a new generic rule is written here **only if I explicitly authorize it**. Otherwise, propose it and wait.

## 5. Communication ({{REPLY_LANGUAGE}})
- Respond in plain, concise {{REPLY_LANGUAGE}}, even if the project files are in another language. Sentences the skills ask you to tell me are also to be translated into this language.
- Keep explanations brief unless asked for a deep dive.
- End each turn with a short summary of what was done, what files were updated, and a single written question to validate the next step.
- In that summary, add "Reports : …" for what is postponed and added to `BACKLOG.md` (otherwise "{{REPORTS_NONE}}").
- Never say "done" if a part is missing: say "partly done" and list what is missing.
- An approval given for a sequence of actions covers the whole sequence: do not ask again along the way.

## 6. Self-Verification Checklist (Pass/Fail with evidence)
Before presenting work or proposing a commit, report each item as Pass / Fail / N/A.
**Every Pass on items 2, 6 and 7 must include its evidence** (command run and its result, branch name, files updated). A Pass without evidence counts as Fail.
1. Asked clarifying questions if anything was unclear? (Pass/Fail/N/A)
2. Tests and linter pass? Evidence: test command from `docs/TESTING.md`, lint command from section 1, and their result (e.g. `make test` → 12/12, `make lint` → 0 errors; if the lint command is "none", write "lint: none"). If there is a ticket, every test it lists appears in the output. (Pass/Fail/N/A — N/A only if no code changed)
3. No hardcoded secrets, keys, or tokens? (Pass/Fail)
4. No unapproved new dependencies added? (Pass/Fail)
5. Asked explicit permission before destructive or data-modifying actions? (Pass/Fail/N/A)
6. Git branch/commit follows Conventional Commits? Evidence: branch name and commit title. (Pass/Fail/N/A)
7. `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, linked spec and ticket updated (after approval) if applicable? Evidence: files updated. (Pass/Fail/N/A)
8. Final response concise, clear, and in {{REPLY_LANGUAGE}}? (Pass/Fail)

---

## Project Decisions & Off-Limits
- **Do not touch without approval:** {{CRITICAL_ZONES}}
- *(Validated architectural choices are recorded in `docs/adr/`, or here only with my approval.)*
