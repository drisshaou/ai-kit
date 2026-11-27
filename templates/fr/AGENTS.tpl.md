# AGENTS.md — {{PROJECT_NAME}}
Règles du projet : `CLAUDE.md`. Le lire à chaque début de session ; le suivre, ainsi que les fichiers qu'il cite.

## Sécurité (Codex)
- Ne jamais lire/modifier `.env`, `.env.*` (sauf `.env.example`) ni aucun fichier de secrets. Aucune règle ne bloque ta lecture de fichiers : cette interdiction repose sur toi.
- Commande refusée par `.codex/rules/` → me le signaler, demander comment continuer.

## Équivalents Codex
- Skills : `.agents/skills/` (projet), `~/.agents/skills/` (globales) = liens vers `.claude/skills/`, `~/.claude/skills/`. Toujours créer/modifier le vrai fichier : `.claude/skills/` (projet) ou `~/.claude/skills/` (globale).
- `/<nom>` dans `CLAUDE.md` ou une skill = `$<nom>` dans Codex.
- Hooks : `.codex/hooks.json` (Claude Code : `.claude/settings.json`).
