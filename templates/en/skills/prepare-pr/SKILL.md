---
name: prepare-pr
description: Prepares a clean Pull Request after auditing the diff, the tests and the documentation. Use only when the user explicitly asks for it (`/prepare-pr` in Claude Code, `$prepare-pr` in Codex).
disable-model-invocation: true
---

# prepare-pr
Analyze `git status` and `git diff main...HEAD` (adapt if the default branch is `master`).

1. No secret, temporary file or useless debug log.
2. Run the test cmd (`docs/TESTING.md`) and lint cmd (`CLAUDE.md` section 1); keep each exact command + result.
3. Check whether `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, linked spec or ticket need updating (ticked criteria, spec status). Propose; write only after my approval.
4. Ready-to-copy PR description (or `gh pr create` after my approval): Conventional Commits title, context, changes, verified tests (commands + results), Pass/Fail checklist with evidence.
5. **Wrap-up:** check all progress is on disk (ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, as validated). End with: "Run `/clear` before the next ticket."
