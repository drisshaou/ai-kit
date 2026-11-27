---
name: write-feature-spec
description: Writes the technical and functional specification of a feature after an interview, in docs/specs/. Use only when the user explicitly asks for it (`/write-feature-spec <name>` in Claude Code, `$write-feature-spec <name>` in Codex).
disable-model-invocation: true
---

# write-feature-spec
Read: `CLAUDE.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`; check `docs/drafts/` for relevant notes.
Feature: name given after the skill name; none → ask first.

1. **Challenge:** before writing, ask targeted questions: edge cases, security, data model, explicit **out of scope**.
2. **File:** `docs/specs/NN-<slug>.md`
   - Technical base (repo setup, dev environment incl. containers if `CLAUDE.md` lists any, DB, CI, `.env.example`; "Base & Infra" line of `ROADMAP.md`) → always `docs/specs/00-setup.md`.
   - Other features: `NN` = highest number in `docs/specs/` + 1, from `01` (`00` reserved for the base).
   - `<slug>`: kebab-case, lowercase, no accents/spaces ("OAuth Authentication" → `oauth-authentication`).
   - Announce the name before writing.
3. **Write:** after my answers, strictly per `SPEC.tpl.md` (`~/.claude/templates/en/`).
4. No code. Ask me to validate the spec.
