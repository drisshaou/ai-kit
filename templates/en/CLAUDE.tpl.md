# CLAUDE.md — {{PROJECT_NAME}}
Role: my co-developer.

## 1. Session start
Read first: this file, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- Templates: `en` (`~/.claude/templates/en/`)
- Stack: {{STACK_SUMMARY}}
- Containers: {{CONTAINERS}}
- Dirs: `{{DIR_1}}` {{ROLE_1}} · `{{DIR_2}}` {{ROLE_2}} · `AGENTS.md` Codex pointer · `docs/specs/` contractual specs · `docs/tickets/` atomic tickets · `docs/adr/` decisions · `docs/drafts/` non-contractual notes
- Dev: `{{CMD_DEV}}`
- Lint: `{{CMD_LINT}}`
- Build: `{{CMD_BUILD}}`
- Tests: see `docs/TESTING.md`

## 2. Clarify first
Ambiguous request or unsure approach → **stop, ask specific questions** before any code or file change. Never guess.

## 3. Coding & workflow
- Simplest solution; reuse existing data/code.
- Framework conventions; linter/formatter must pass.
- Code, commits, tech docs: English.
- Tests per `docs/TESTING.md`; bug fix/feature → test replaying exact user behavior.
- **Never** hardcode passwords/keys/tokens → env vars (`.env`).
- **No new dependency without my approval.**
- Repeated mistake or recurring complex procedure → suggest `/learn-skill` (`$learn-skill` in Codex) at task end.
- Skills: `.claude/skills/`, Codex links `.agents/skills/`; auto-checked (session hook, Git `pre-commit`).
- Workflow (`$name` in Codex): `/write-feature-spec setup` → `docs/specs/00-setup.md` · `/plan-spec-tickets` → `docs/tickets/` · `/implement-ticket` (branch, tests, code, checklist, commit) · `/prepare-pr` · `/clear` → next ticket until spec done · `/write-feature-spec <name>` → next feature (`01-…`). Anytime: `/learn-skill`.
- Git: strict Conventional Commits. 1 ticket = 1 branch = 1 PR: `feat/|fix/|refactor/<short-name>`. Commit `type(scope): summary` (imperative, ≤72 chars, no final period). Types: `feat fix refactor test docs chore perf style`.

## 4. Docs (approval required)
- Keep current: `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Every doc change: propose → wait for approval → write.**
- Task end: check `.md` files (+ linked spec/ticket), propose changes.
- Spec's tickets all done → propose spec status "Implemented" + tick `ROADMAP.md` line.
- `CHANGELOG.md`: Keep a Changelog, under `Unreleased`.
- Postponed/incomplete → `BACKLOG.md` "Postponed / Incomplete"; never delete old entry until done.
- **Sole exception:** adding a line there needs no approval; report it in "Reports : …". Editing/removing entries or other sections → approval.
- **`CLAUDE.md`: new generic rule only with my explicit authorization**; else propose and wait.
- Writing style for this file and skills: compact (imperative bullets, `Key: value`, no filler); keep commands, paths, code blocks and `/name` ↔ `$name` verbatim.

## 5. Communication ({{REPLY_LANGUAGE}})
- Reply in plain, concise {{REPLY_LANGUAGE}} even if files are in another language; translate skill-provided sentences.
- Brief unless asked.
- Turn end: short summary (done, files updated) + one written question to validate next step.
- Add "Reports : …" (postponed items added to `BACKLOG.md`), else "{{REPORTS_NONE}}".
- Part missing → "partly done" + what's missing, never "done".
- Approval of an action sequence covers all of it; don't re-ask.

## 6. Checklist before presenting work / proposing commit (Pass/Fail/N/A)
Items 2, 6, 7: Pass needs evidence (command + result, branch, files); no evidence = Fail.
1. Clarified if unclear?
2. Tests + lint pass? Evidence: test cmd (`docs/TESTING.md`), lint cmd (§1), results (e.g. `make test` → 12/12; lint "none" → "lint: none"); all ticket tests in output. N/A only if no code changed.
3. No hardcoded secrets?
4. No unapproved dependency?
5. Permission asked before destructive/data-modifying actions?
6. Conventional branch/commit? Evidence: branch + commit title. N/A if no commit yet.
7. Docs (`README`, `CHANGELOG`, `ROADMAP`, `BACKLOG`, `TESTING`, spec, ticket) updated after approval? Evidence: files.
8. Final reply concise, clear, {{REPLY_LANGUAGE}}?

## Off-limits
- No changes without approval: {{CRITICAL_ZONES}}
- Validated architecture choices → `docs/adr/` (here only with my approval).
