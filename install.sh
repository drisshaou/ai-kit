#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$HOME/.agents/skills"     # skills utilisateur lues par Codex
STAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$CLAUDE_DIR" "$KIT_DIR/skills"

# Remplace $dst par un lien vers $src.
# Un dossier ou fichier existant est sauvegardé sous un nom horodaté unique.
link_path() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "Sauvegarde de l'existant : $dst -> ${dst}.bak-${STAMP}"
    mv "$dst" "${dst}.bak-${STAMP}"
  fi

  ln -s "$src" "$dst"
  echo "Lien créé : $dst -> $src"
}

link_path "$KIT_DIR/templates" "$CLAUDE_DIR/templates"
link_path "$KIT_DIR/skills"    "$CLAUDE_DIR/skills"

# Codex : un lien par skill du kit dans ~/.agents/skills.
mkdir -p "$AGENTS_DIR"

# Retire les liens du kit devenus orphelins (skill supprimée ou renommée).
# Ne touche qu'aux liens morts qui pointent vers ~/.claude/skills/.
for old in "$AGENTS_DIR"/*; do
  if [ -L "$old" ] && [ ! -e "$old" ] && [[ "$(readlink "$old")" == "$CLAUDE_DIR/skills/"* ]]; then
    rm "$old"
    echo "Lien orphelin supprimé : $old"
  fi
done

for skill in "$KIT_DIR"/skills/*/; do
  [ -d "$skill" ] || continue
  name="$(basename "$skill")"
  link_path "$CLAUDE_DIR/skills/$name" "$AGENTS_DIR/$name"
done

# Scripts exécutables (un zip peut perdre les droits).
find "$KIT_DIR/skills" -path '*/scripts/*' -type f -name '*.sh' -exec chmod +x {} +
chmod +x "$KIT_DIR/.githooks/pre-commit" "$KIT_DIR/templates/pre-commit.tpl.sh"

# Pre-commit du kit : vérifie les skills globales avant chaque commit.
if git -C "$KIT_DIR" rev-parse --show-toplevel >/dev/null 2>&1 \
   && [ "$(git -C "$KIT_DIR" rev-parse --show-toplevel)" = "$KIT_DIR" ]; then
  current="$(git -C "$KIT_DIR" config core.hooksPath || true)"
  if [ -z "$current" ] || [ "$current" = ".githooks" ]; then
    git -C "$KIT_DIR" config core.hooksPath .githooks
    echo "Pre-commit du kit activé (core.hooksPath = .githooks)."
  else
    echo "Pre-commit du kit NON activé : core.hooksPath vaut déjà '$current'."
  fi
else
  echo "Kit hors dépôt Git : pre-commit non activé (relancez install.sh après git init)."
fi

echo "Installation terminée : ~/.claude/{templates,skills} configurés, skills du kit liées dans ~/.agents/skills."
