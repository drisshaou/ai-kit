#!/usr/bin/env bash
# check-skill.sh — deterministic conformity checks for agent skills (Claude Code + Codex).
#
# Usage:
#   check-skill.sh check    <skills-dir> [--changed] [--agents <agents-skills-dir>]
#   check-skill.sh validate <skills-dir> <skill-name> [--agents <agents-skills-dir>]
#   check-skill.sh budget   <file> <max-lines>
#
# check     Checks every skill of <skills-dir> (a folder holding <name>/SKILL.md).
#           --changed: only skills that are new or modified since their last validation;
#                      prints nothing when there is nothing to check.
# validate  Checks one skill and, if it passes, records its fingerprint in <skills-dir>/.validated.
# --agents  Also checks that <agents-skills-dir>/<name> is a working link for Codex.
# budget    Prints a warning if <file> has more than <max-lines> lines; prints nothing otherwise.
#           Never fails (exit 0): a warning, not a block.
#
# Checks: frontmatter (name, description, name = folder), Claude/Codex parity, Codex link,
#         SKILL.md budget (warning above SKILL_MAX_LINES lines).
# Exit code: 0 = all pass, 1 = at least one failure, 2 = usage error.

set -uo pipefail

SKILL_MAX_LINES=80

usage() { sed -n '4,7p' "$0" | sed 's/^# //' >&2; exit 2; }

hash_file() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | cut -d' ' -f1
  else shasum -a 256 "$1" | cut -d' ' -f1; fi
}

# budget <file> <max>: warning only, never blocks.
budget_warn() {
  local file="$1" max="$2" n
  [ -f "$file" ] || return 0
  n="$(wc -l < "$file" | tr -d ' ')"
  if [ "$n" -gt "$max" ]; then
    echo "WARN budget: $file has $n lines (max $max)"
  fi
  return 0
}

if [ "${1:-}" = "budget" ]; then
  [ $# -eq 3 ] || usage
  budget_warn "$2" "$3"
  exit 0
fi

[ $# -ge 2 ] || usage
cmd="$1"; dir="${2%/}"; shift 2
target=""; changed=0; agents=""
if [ "$cmd" = "validate" ]; then
  [ $# -ge 1 ] || usage
  target="$1"; shift
elif [ "$cmd" != "check" ]; then
  usage
fi
while [ $# -gt 0 ]; do
  case "$1" in
    --changed) changed=1 ;;
    --agents)  [ $# -ge 2 ] || usage; agents="${2%/}"; shift ;;
    *) usage ;;
  esac
  shift
done

validated_file="$dir/.validated"

# Fingerprint recorded at last validation (empty if none).
recorded_hash() {
  [ -f "$validated_file" ] || return 0
  awk -v n="$1" '$2 == n { print $1 }' "$validated_file" | tail -n1
}

# Is <name> a known skill (this folder or the user's global skills)?
is_skill() {
  [ -f "$dir/$1/SKILL.md" ] || [ -f "$HOME/.claude/skills/$1/SKILL.md" ]
}

# Checks one skill. Prints "PASS <name>" or "FAIL <name>: <reasons>". Returns 0/1.
check_one() {
  local name="$1" file="$dir/$1/SKILL.md"
  local fails=() fm fm_name s link

  if [ ! -f "$file" ]; then
    echo "FAIL $name: SKILL.md not found"
    return 1
  fi

  # 1. Frontmatter
  if [ "$(head -n1 "$file")" != "---" ]; then
    fails+=("frontmatter: missing opening ---")
  else
    fm="$(awk 'NR == 1 { next } /^---[[:space:]]*$/ { exit } { print }' "$file")"
    grep -q '^name:' <<<"$fm"        || fails+=("frontmatter: missing name")
    grep -q '^description:' <<<"$fm" || fails+=("frontmatter: missing description")
    fm_name="$(sed -n 's/^name:[[:space:]]*//p' <<<"$fm" | head -n1 | tr -d '"'"'"' ')"
    if [ -n "$fm_name" ] && [ "$fm_name" != "$name" ]; then
      fails+=("frontmatter: name '$fm_name' differs from folder '$name'")
    fi
  fi

  # 2. Claude/Codex parity
  if grep -q '\.claude/skills' "$file" && ! grep -q '\.agents/skills' "$file"; then
    fails+=("parity: .claude/skills cited without .agents/skills")
  fi
  if grep -q '\.claude/commands' "$file"; then
    fails+=("parity: .claude/commands has no Codex equivalent (use a skill)")
  fi
  # A skill call is written between backticks: `/name`. A bare /name is a path and is ignored.
  # Only names of known skills count.
  # The name is followed by the closing backtick or by a space (argument): `/write-feature-spec <name>`.
  for s in $(grep -oE '`/[a-z][a-z0-9-]*[` ]' "$file" | sed -E 's/^`\///; s/[` ]$//' | sort -u); do
    if is_skill "$s" && ! grep -qF "\$$s" "$file"; then
      fails+=("parity: /$s cited without \$$s")
    fi
  done

  # 3. Codex link
  if [ -n "$agents" ]; then
    link="$agents/$name"
    if [ ! -L "$link" ]; then
      fails+=("link: $link missing")
    elif [ ! -f "$link/SKILL.md" ]; then
      fails+=("link: $link broken")
    fi
  fi

  if [ ${#fails[@]} -eq 0 ]; then
    echo "PASS $name"
    return 0
  fi
  local IFS=';'
  echo "FAIL $name: ${fails[*]}"
  return 1
}

if [ "$cmd" = "validate" ]; then
  check_one "$target" || exit 1
  budget_warn "$dir/$target/SKILL.md" "$SKILL_MAX_LINES"
  tmp="$(mktemp)"
  [ -f "$validated_file" ] && awk -v n="$target" '$2 != n' "$validated_file" > "$tmp"
  echo "$(hash_file "$dir/$target/SKILL.md") $target" >> "$tmp"
  mv "$tmp" "$validated_file"
  echo "VALIDATED $target"
  exit 0
fi

# check
[ -d "$dir" ] || { [ $changed -eq 1 ] || echo "0 skill to check ($dir not found)"; exit 0; }

total=0; failed=0
for skill_dir in "$dir"/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue
  name="$(basename "$skill_dir")"
  current="$(hash_file "$skill_dir/SKILL.md")"
  recorded="$(recorded_hash "$name")"
  if [ $changed -eq 1 ] && [ "$current" = "$recorded" ]; then
    continue
  fi
  total=$((total + 1))
  state="validated"
  [ "$current" = "$recorded" ] || state="not validated"
  if out="$(check_one "$name")"; then :; else failed=$((failed + 1)); fi
  echo "$out ($state)"
  budget_warn "${skill_dir%/}/SKILL.md" "$SKILL_MAX_LINES"
done

if [ $total -eq 0 ]; then
  [ $changed -eq 1 ] || echo "0 skill to check"
  exit 0
fi
echo "$total skill(s) checked, $failed failed. Validate a reviewed skill with: check-skill.sh validate $dir <name>"
[ $failed -eq 0 ]
