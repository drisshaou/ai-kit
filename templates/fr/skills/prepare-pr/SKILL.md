---
name: prepare-pr
description: Prépare une Pull Request propre après audit du diff, des tests et de la documentation. À utiliser seulement quand l'utilisateur le demande explicitement (`/prepare-pr` dans Claude Code, `$prepare-pr` dans Codex).
disable-model-invocation: true
---

# prepare-pr
Analyser `git status` et `git diff main...HEAD` (adapter si la branche par défaut est `master`).

1. Aucun secret, fichier temporaire ni log de debug inutile.
2. Lancer la commande de test (`docs/TESTING.md`) et de lint (`CLAUDE.md` section 1) ; garder chaque commande exacte + résultat.
3. Vérifier si `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, la spec ou le ticket liés sont à mettre à jour (critères cochés, statut de la spec). Proposer ; n'écrire qu'après mon accord.
4. Description de PR prête à copier (ou `gh pr create` après mon accord) : titre Conventional Commits, contexte, changements, tests vérifiés (commandes + résultats), checklist Pass/Fail avec preuve.
5. **Clôture :** vérifier que tout l'avancement est sur le disque (ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, selon ce qui a été validé). Terminer par : « Lance `/clear` avant le ticket suivant. »
