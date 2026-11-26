# AGENTS.md — {{PROJECT_NAME}}

Les règles du projet sont dans `CLAUDE.md` : lis-le au début de chaque session et suis-le, ainsi que les fichiers qu'il cite.

## Sécurité (Codex)
- Ne lis ni ne modifie jamais `.env`, `.env.*` (sauf `.env.example`) ni aucun fichier de secrets : aucune règle ne bloque ta lecture de fichiers, cette interdiction repose sur toi.
- Si une commande est refusée par `.codex/rules/`, signale-le-moi et demande comment continuer.

## Équivalents Codex
- **Skills :** `.agents/skills/` (projet) et `~/.agents/skills/` (globales). Ce sont des liens vers `.claude/skills/` et `~/.claude/skills/` : crée ou modifie toujours le vrai fichier, dans `.claude/skills/` pour une skill projet et dans `~/.claude/skills/` pour une skill globale.
- **Commandes :** `/<nom>` dans `CLAUDE.md` ou dans une skill = `$<nom>` dans Codex.
- **Hooks :** `.codex/hooks.json` (équivalent Claude Code : `.claude/settings.json`).
