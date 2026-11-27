---
name: write-feature-spec
description: Writes the technical and functional specification of a feature after an interview, in docs/specs/. Use only when the user explicitly asks for it (`/write-feature-spec <name>` in Claude Code, `$write-feature-spec <name>` in Codex).
disable-model-invocation: true
---

# write-feature-spec

Read `CLAUDE.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md` and check whether `docs/drafts/` holds relevant notes.

**Feature to specify:** the name given by the user after the skill name. If there is none, ask for it first.

1. **Challenge:** before writing, ask me targeted questions about edge cases, security, the data model and what is explicitly **out of scope**.
2. **File name:** `docs/specs/NN-<slug>.md`
   - **Technical base** (repo setup, dev environment including containers if `CLAUDE.md` lists any, DB, CI, `.env.example` — the "Base & Infra" line of `ROADMAP.md`): the file is always `docs/specs/00-setup.md`.
   - **Other features:** `NN` = 2-digit number = highest existing number in `docs/specs/` + 1, starting at `01` (`00` is reserved for the base).
   - `<slug>`: the feature name in kebab-case, lowercase, no accents or spaces (e.g. "OAuth Authentication" → `oauth-authentication`).
   - Tell me the chosen name before writing.
3. **Writing:** once I have answered, create the spec strictly following `SPEC.tpl.md` (in `~/.claude/templates/en/`).
4. Do not write any code. Ask me to validate the spec.
