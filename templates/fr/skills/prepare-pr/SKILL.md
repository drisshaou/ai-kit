---
name: prepare-pr
description: Prépare une Pull Request propre après audit du diff, des tests et de la documentation. À utiliser seulement quand l'utilisateur le demande explicitement (`/prepare-pr` dans Claude Code, `$prepare-pr` dans Codex).
disable-model-invocation: true
---

# prepare-pr

Analyse `git status` et `git diff main...HEAD` (adapte si la branche par défaut est `master`).

1. Vérifie qu'aucun secret, fichier temporaire ou log de debug inutile n'est présent.
2. Lance la commande de format, puis la commande de test de `docs/TESTING.md` et les commandes de lint et de type-check de `CLAUDE.md` (section 1), et garde chaque commande exacte et son résultat.
3. Vérifie si `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, la spec ou le ticket liés doivent être mis à jour (critères cochés, statut de la spec). Propose les modifications et attends mon accord avant de les écrire.
4. Rédige une description de PR prête à copier (ou via `gh pr create`, après mon accord) avec : titre Conventional Commits, contexte, changements, tests vérifiés (commandes + résultats) et checklist Pass/Fail avec preuve.
5. **Clôture :** vérifie que tout l'avancement est écrit sur le disque (ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, selon ce qui a été validé), puis termine par : « Lance `/clear` avant le ticket suivant. »
