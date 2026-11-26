---
name: work-ticket
description: Runs an atomic ticket end to end (branch, tests, code, checks, follow-up). Use only when the user explicitly asks for it (`/work-ticket <ticket>` in Claude Code, `$work-ticket <ticket>` in Codex).
disable-model-invocation: true
---

# work-ticket

**Ticket to run:** the path or name given by the user after the skill name (e.g. `docs/tickets/01-01-login-endpoint.md`). If there is none, ask for it first.

Read `CLAUDE.md`, `BACKLOG.md`, `docs/TESTING.md`, this ticket and the section of the linked spec.

1. **Clarify first:** if anything is ambiguous, stop and ask your questions before coding. If the status in `docs/TESTING.md` is "Not installed" (and this ticket is not the one that sets it up), stop as well: first propose the ticket that sets up the test tool.
2. **Git branch:** create the compliant branch (`feat/...`, `fix/...`, `refactor/...`) from the up-to-date main branch.
3. **Tests:** write the tests listed in the ticket's "Tests to Write" section, following `docs/TESTING.md`.
4. **Implementation:** code the simplest solution that strictly meets the acceptance criteria.
5. **Checks:** run the test command from `docs/TESTING.md` and the lint command from `CLAUDE.md` (section 1). Keep each exact command and its result for the checklist.
6. **Follow-up:** propose the needed documentation changes (`CHANGELOG.md`, `README.md`, `BACKLOG.md`, ticket…) and wait for my approval before writing them. A postponed subtask goes to `BACKLOG.md`, "Postponed / Incomplete" section: this is the only write without prior approval (see `CLAUDE.md`), reported in "Reports : …". If this was the spec's last ticket, also propose to set the spec to "Implemented" and to tick its line in `ROADMAP.md`.
7. **Validation then commit:** give the summary and the self-verification checklist (Pass/Fail with evidence) from `CLAUDE.md` — for item 6, the evidence is the branch name and the proposed commit title (Conventional Commits). End by proposing the commit (files involved + title) and wait for my approval before making it.
8. **Wrap-up:** after the commit, check that all progress is written to disk (ticked criteria in the ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, as validated): the next session will start from these files, not from the conversation. End with: "Run `/clear` before the next ticket."
