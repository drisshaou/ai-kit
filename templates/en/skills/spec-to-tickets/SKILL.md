---
name: spec-to-tickets
description: Splits a validated spec into atomic, ready-to-run tickets, with the tests to write. Use only when the user explicitly asks for it (`/spec-to-tickets <spec>` in Claude Code, `$spec-to-tickets <spec>` in Codex).
disable-model-invocation: true
---

# spec-to-tickets

**Spec to split:** the path or name given by the user after the skill name (e.g. `docs/specs/01-authentication.md` or `01`). If there is none, ask for it first.

Read this spec, `CLAUDE.md` and `docs/TESTING.md`.

Split the spec into atomic tickets (1 ticket = 1 PR = 1 session) following `TICKET.tpl.md` (in `~/.claude/templates/en/`).

- **Name of each ticket:** `docs/tickets/<spec NN>-<ticket NN>-<slug>.md` (e.g. spec `01-authentication.md` → `01-01-login-endpoint.md`, `01-02-logout-endpoint.md`).
- **Ticket order:** split and order the tickets so that each one, once merged, leaves `main` working (build and tests pass). If a ticket cannot do so on its own, flag it in the table.
- **Tests to Write:** for each ticket, fill this section with at least one test per acceptance criterion, following the location and naming of `docs/TESTING.md`.

First present the split as a table (file, title, criteria, tests). Once validated, ask me whether to save the tickets in `docs/tickets/` or create them as GitHub Issues (`gh issue create`).
