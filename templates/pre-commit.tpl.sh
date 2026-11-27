#!/usr/bin/env bash
# ai-kit pre-commit: blocks the commit if a project skill is not conformant.
# Installed by init-project in .githooks/pre-commit (git config core.hooksPath .githooks).
# Uses the checker copied into the project, so it works on any clone without the kit installed.
set -uo pipefail

root="$(git rev-parse --show-toplevel)"
check="$root/.claude/skills/learn-skill/scripts/check-skill.sh"

if [ ! -x "$check" ]; then
  echo "ai-kit: $check not found, project skills not checked." >&2
  exit 0
fi

[ -d "$root/.claude/skills" ] || exit 0

if ! "$check" check "$root/.claude/skills" --agents "$root/.agents/skills"; then
  echo "ai-kit: commit blocked, fix the FAIL items above." >&2
  exit 1
fi
