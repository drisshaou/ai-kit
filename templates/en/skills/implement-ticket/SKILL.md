---
name: implement-ticket
description: Runs an atomic ticket end to end (branch, tests, code, checks, follow-up). Use only when the user explicitly asks for it (`/implement-ticket <ticket>` in Claude Code, `$implement-ticket <ticket>` in Codex).
disable-model-invocation: true
---

# implement-ticket
Ticket: path or name given after the skill name (e.g. `docs/tickets/01-01-login-endpoint.md`); none → ask first.
Read: `CLAUDE.md`, `BACKLOG.md`, `docs/TESTING.md`, this ticket, the linked spec section.

1. **Clarify first:** anything ambiguous → stop, ask before coding. `docs/TESTING.md` status "Not installed" (and this ticket doesn't set it up) → stop, propose the test-tool setup ticket first.
2. **Branch:** compliant branch (`feat/...`, `fix/...`, `refactor/...`) from up-to-date main.
3. **Tests:** write the tests of the ticket's "Tests to Write" section, per `docs/TESTING.md`.
4. **Code:** simplest solution strictly meeting the acceptance criteria.
5. **Checks:** run the test cmd (`docs/TESTING.md`) and lint cmd (`CLAUDE.md` section 1); keep each exact command + result for the checklist.
6. **Follow-up:** propose needed doc changes (`CHANGELOG.md`, `README.md`, `BACKLOG.md`, ticket…); write only after my approval. Postponed subtask → `BACKLOG.md` "Postponed / Incomplete" without approval (only exception, see `CLAUDE.md`), reported in "Reports : …". Spec's last ticket → also propose spec "Implemented" + tick its `ROADMAP.md` line.
7. **Validate, then commit:** summary + `CLAUDE.md` checklist (Pass/Fail with evidence); item 6 evidence = branch + proposed commit title (Conventional Commits). Propose the commit (files + title); commit only after my approval.
8. **Wrap-up:** after the commit, check all progress is on disk (ticked criteria in the ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, as validated): the next session starts from these files, not the conversation. End with: "Run `/clear` before the next ticket."
