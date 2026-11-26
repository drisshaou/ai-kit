---
name: learn-skill
description: Captures a recurring mistake or a complex procedure by proposing a rule for CLAUDE.md or a new skill (project scope by default, shared between Claude Code and Codex, checked by script). Use only when the user explicitly asks for it (`/learn-skill` in Claude Code, `$learn-skill` in Codex).
disable-model-invocation: true
---

# learn-skill

Analyze the current session (the mistake, the fix or the complex procedure encountered). Topic: the one given by the user after the skill name; if there is none, infer it from the session and have me confirm it.

In this skill, `CHECK` means the verification script copied into the project:
`.claude/skills/learn-skill/scripts/check-skill.sh` (run from the repository root).

## Step 1: Diagnosis & choice of medium
- **Rule in `CLAUDE.md`**: short permanent rule (1-2 lines) for the whole project. It also applies to Codex, which reads `CLAUDE.md` through `AGENTS.md`.
- **Skill (`SKILL.md`)**: detailed procedure, precise technical pattern or specific pitfall (loaded on demand).

## Step 2: Skill scope
- **Project (default)**: `.claude/skills/<name>/SKILL.md` at the repository root, with the Codex link `.agents/skills/<name>`.
- **Global (only if I explicitly ask)**: `~/.claude/skills/<name>/SKILL.md`, with the Codex link `~/.agents/skills/<name>`.

**Before a global skill**, check that it cites nothing specific to the project: language, framework, tool, dependency, path, command or file name of the project. If it does, **do not make it global**: list the items found and propose the project scope. It only becomes global if I confirm after seeing this list.

## Step 3: Writing with Claude Code / Codex parity
Write the skill in English (project language), following `~/.claude/templates/en/SKILL.tpl.md`. The `name` must match the folder name.

Any mention specific to one of the two agents must give the other's equivalent:

| Claude Code | Codex |
|-------------|-------|
| `/<name>` | `$<name>` |
| `.claude/skills/` | `.agents/skills/` |
| `~/.claude/skills/` | `~/.agents/skills/` |
| `.claude/settings.json` (hooks) | `.codex/hooks.json` |

Citing `CLAUDE.md` is allowed: it is the rules file of both agents. An item with no equivalent is flagged in the proposal, never silently removed.

A skill call is always written between backticks: `` `/<name>` `` and `` `$<name>` ``. A `/name` without backticks is read as a folder path and is not checked.

## Step 4: Proposal and authorization (mandatory)
Show me the exact text, the chosen medium and **the full destination path**. **Write nothing until I have explicitly authorized it.**

## Step 5: Creation and check
After authorization:
- **Rule**: add it to `CLAUDE.md` (which must stay under 150 lines).
- **Project skill** (from the repository root):
  1. write `.claude/skills/<name>/SKILL.md`;
  2. `mkdir -p .agents/skills && ln -s ../../.claude/skills/<name> .agents/skills/<name>` (relative link, still valid after a clone);
  3. `CHECK validate .claude/skills <name> --agents .agents/skills`
- **Global skill**:
  1. write `~/.claude/skills/<name>/SKILL.md`;
  2. `mkdir -p ~/.agents/skills && ln -s ~/.claude/skills/<name> ~/.agents/skills/<name>`;
  3. `CHECK validate ~/.claude/skills <name> --agents ~/.agents/skills`

Give the script output as evidence. If it contains `FAIL`, fix only the reported items, show me the fix and wait for my approval before running it again.

## Step 6: Commit (and push for a global skill)
Once the output is `PASS`, propose the commit and wait for my approval (an approval for "commit then push" covers both):
- **Project skill**: commit in the project repository, on the current branch, with `.claude/skills/<name>/`, the link `.agents/skills/<name>` and `.claude/skills/.validated`. The project `pre-commit` checks the skill again. No direct push: the skill ships with the current PR.
- **Global skill**: commit in the kit repository (`git -C ~/.claude/skills …`, which points to the kit), with `skills/<name>/` and `skills/.validated`. The kit `pre-commit` checks the skill again. Then, if the kit repository has a remote (`git -C ~/.claude/skills remote`), propose the push.
- Commit title in Conventional Commits format (e.g. `feat(skills): add <name>`).
