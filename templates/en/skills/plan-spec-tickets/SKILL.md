---
name: plan-spec-tickets
description: Plans the tickets of a validated spec - splits it into atomic tickets (1 ticket = 1 branch = 1 PR), each with the tests to write. Use only when the user explicitly asks for it (`/plan-spec-tickets <spec>` in Claude Code, `$plan-spec-tickets <spec>` in Codex).
disable-model-invocation: true
---

# plan-spec-tickets
Spec: path or name given after the skill name (e.g. `docs/specs/01-authentication.md` or `01`); none → ask first.
Read: this spec, `CLAUDE.md`, `docs/TESTING.md`.

Split into atomic tickets (1 ticket = 1 PR = 1 session) per `TICKET.tpl.md` (`~/.claude/templates/en/`).
- Name: `docs/tickets/<spec NN>-<ticket NN>-<slug>.md` (spec `01-authentication.md` → `01-01-login-endpoint.md`, `01-02-logout-endpoint.md`).
- Order: each ticket, once merged, leaves `main` working (build + tests pass). Can't on its own → flag it in the table.
- Tests to Write: ≥1 test per acceptance criterion, location and naming per `docs/TESTING.md`.

First show the split as a table (file, title, criteria, tests). Once validated, ask: save in `docs/tickets/` or create GitHub Issues (`gh issue create`)?
