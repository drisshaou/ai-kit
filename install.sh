#!/usr/bin/env bash
# ai-kit — installation : ./install.sh   ·   désinstallation : ./install.sh --uninstall
#
# ~/.claude/skills et ~/.agents/skills restent des dossiers à vous (vos skills, celles que
# Claude synchronise depuis claude.ai…) : le kit n'y ajoute qu'un lien par skill globale du kit.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SKILLS="$CLAUDE_DIR/skills"      # skills utilisateur lues par Claude Code
AGENTS_DIR="$HOME/.agents/skills"       # skills utilisateur lues par Codex
STAMP="$(date +%Y%m%d-%H%M%S)"

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

# Supprime, dans le dossier $1, les liens qui pointent vers une skill du kit.
# $2 = "dead" pour ne retirer que les liens orphelins (skill supprimée ou renommée).
remove_kit_links() {
  local dir="$1" mode="${2:-all}" link
  for link in "$dir"/*; do
    [ -L "$link" ] || continue
    [[ "$(readlink "$link")" == "$KIT_DIR/skills/"* ]] || continue
    if [ "$mode" = "dead" ] && [ -e "$link" ]; then
      continue
    fi
    rm "$link"
    if [ "$mode" = "dead" ]; then
      echo "Lien orphelin supprimé : $link"
    else
      echo "Lien supprimé : $link"
    fi
  done
}

# Propose de remettre une sauvegarde .bak-*, seulement si son emplacement d'origine est libre.
offer_restore() {
  local backup="$1" target answer
  [ -e "$backup" ] || return 0
  target="${backup%.bak-*}"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Sauvegarde conservée (emplacement occupé) : $backup"
    return 0
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
}

# Désinstallation : ne supprime que des liens qui pointent vers ce kit, et demande avant de
# remettre une sauvegarde. Les projets déjà initialisés ne sont pas touchés.
uninstall() {
  local backup

  # 1. Liens vers les skills du kit (Claude et Codex).
  remove_kit_links "$CLAUDE_SKILLS"
  remove_kit_links "$AGENTS_DIR"

  # 2. Lien ~/.claude/templates, et ancien lien ~/.claude/skills vers le kit s'il existe encore.
  if [ -L "$CLAUDE_DIR/templates" ] && [ "$(readlink "$CLAUDE_DIR/templates")" = "$KIT_DIR/templates" ]; then
    rm "$CLAUDE_DIR/templates"
    echo "Lien supprimé : $CLAUDE_DIR/templates"
  fi
  if [ -L "$CLAUDE_SKILLS" ] && [ "$(readlink "$CLAUDE_SKILLS")" = "$KIT_DIR/skills" ]; then
    rm "$CLAUDE_SKILLS"
    echo "Lien supprimé : $CLAUDE_SKILLS"
  fi

  # 3. Sauvegardes .bak-* (dossiers entiers, ou une skill de même nom qu'une skill du kit).
  for backup in "$CLAUDE_DIR"/templates.bak-* "$CLAUDE_DIR"/skills.bak-* \
                "$CLAUDE_SKILLS"/*.bak-* "$AGENTS_DIR"/*.bak-*; do
    offer_restore "$backup"
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

mkdir -p "$CLAUDE_DIR" "$KIT_DIR/skills"

# Templates : un seul lien vers le dossier du kit.
link_path "$KIT_DIR/templates" "$CLAUDE_DIR/templates"

# Ancienne installation où ~/.claude/skills entier pointait vers le kit : on le redonne à l'utilisateur.
if [ -L "$CLAUDE_SKILLS" ] && [ "$(readlink "$CLAUDE_SKILLS")" = "$KIT_DIR/skills" ]; then
  rm "$CLAUDE_SKILLS"
  echo "Ancien lien supprimé : $CLAUDE_SKILLS (le dossier redevient le vôtre)"
fi
mkdir -p "$CLAUDE_SKILLS" "$AGENTS_DIR"

# Liens orphelins (skill du kit supprimée ou renommée).
remove_kit_links "$CLAUDE_SKILLS" dead
remove_kit_links "$AGENTS_DIR" dead

# Un lien par skill globale du kit, pour Claude et pour Codex.
for skill in "$KIT_DIR"/skills/*/; do
  [ -f "$skill/SKILL.md" ] || continue
  name="$(basename "$skill")"
  link_path "$KIT_DIR/skills/$name" "$CLAUDE_SKILLS/$name"
  link_path "$KIT_DIR/skills/$name" "$AGENTS_DIR/$name"
done

# Scripts exécutables (un zip peut perdre les droits).
find "$KIT_DIR/skills" -path '*/scripts/*' -type f -name '*.sh' -exec chmod +x {} +
chmod +x "$KIT_DIR/.githooks/pre-commit" "$KIT_DIR/templates/pre-commit.tpl.sh" "$KIT_DIR/templates/check-skill.sh"

# Pre-commit du kit : vérifie les skills avant chaque commit.
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

echo "Installation terminée : ~/.claude/templates lié au kit, un lien par skill du kit dans ~/.claude/skills et ~/.agents/skills."
