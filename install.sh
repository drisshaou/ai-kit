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

# Désinstallation : ./install.sh --uninstall
# Ne supprime que des liens qui pointent vers le kit, et demande avant de remettre une sauvegarde.
# Les projets déjà initialisés ne sont pas touchés (ils ont leur propre copie des skills).
uninstall() {
  local link target backup answer

  # 1. Liens Codex vers les skills globales du kit.
  for link in "$AGENTS_DIR"/*; do
    if [ -L "$link" ] && [[ "$(readlink "$link")" == "$CLAUDE_DIR/skills/"* ]]; then
      rm "$link"
      echo "Lien supprimé : $link"
    fi
  done

  # 2. Liens ~/.claude/templates et ~/.claude/skills, seulement s'ils pointent vers ce kit.
  for name in templates skills; do
    link="$CLAUDE_DIR/$name"
    target="$KIT_DIR/$name"
    if [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
      rm "$link"
      echo "Lien supprimé : $link"
    fi
  done

  # 3. Sauvegardes .bak-* : proposées une par une, seulement si l'emplacement d'origine est libre.
  for backup in "$CLAUDE_DIR"/templates.bak-* "$CLAUDE_DIR"/skills.bak-* "$AGENTS_DIR"/*.bak-*; do
    [ -e "$backup" ] || continue
    target="${backup%.bak-*}"
    if [ -e "$target" ] || [ -L "$target" ]; then
      echo "Sauvegarde conservée (emplacement occupé) : $backup"
      continue
    fi
    answer="n"
    if [ -r /dev/tty ]; then
      read -r -p "Remettre $backup à la place de $target ? [o/N] " answer < /dev/tty || answer="n"
    fi
    if [[ "$answer" =~ ^[oOyY]$ ]]; then
      mv "$backup" "$target"
      echo "Sauvegarde remise : $target"
    else
      echo "Sauvegarde conservée : $backup"
    fi
  done

  # 4. Pre-commit du kit.
  if [ "$(git -C "$KIT_DIR" config core.hooksPath 2>/dev/null || true)" = ".githooks" ]; then
    git -C "$KIT_DIR" config --unset core.hooksPath
    echo "Pre-commit du kit désactivé."
  fi

  echo "Désinstallation terminée. Le dossier du kit ($KIT_DIR) n'a pas été supprimé."
}

case "${1:-}" in
  --uninstall) uninstall; exit 0 ;;
  "") ;;
  *) echo "Usage : ./install.sh [--uninstall]" >&2; exit 2 ;;
esac

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
chmod +x "$KIT_DIR/.githooks/pre-commit" "$KIT_DIR/templates/pre-commit.tpl.sh" "$KIT_DIR/templates/check-skill.sh"

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
