---
name: prepare-pr
description: Prepares a clean Pull Request after auditing the diff, the tests and the documentation. Use only when the user explicitly asks for it (`/prepare-pr` in Claude Code, `$prepare-pr` in Codex).
disable-model-invocation: true
---

# prepare-pr

Analyze `git status` and `git diff main...HEAD` (adapt if the default branch is `master`).

1. Check that no secret, temporary file or useless debug log is present.
2. Run the format command, then the test command from `docs/TESTING.md` and the lint and type-check commands from `CLAUDE.md` (section 1), and keep each exact command and its result.
3. Check whether `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, the linked spec or ticket need updating (ticked criteria, spec status). Propose the changes and wait for my approval before writing them.
4. Write a ready-to-copy PR description (or via `gh pr create`, after my approval) with: Conventional Commits title, context, changes, verified tests (commands + results) and Pass/Fail checklist with evidence.
5. **Wrap-up:** check that all progress is written to disk (ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, as validated), then end with: "Run `/clear` before the next ticket."
