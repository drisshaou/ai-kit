---
name: implement-ticket
description: Exécute un ticket atomique de bout en bout (branche, tests, code, vérification, suivi). À utiliser seulement quand l'utilisateur le demande explicitement (`/implement-ticket <ticket>` dans Claude Code, `$implement-ticket <ticket>` dans Codex).
disable-model-invocation: true
---

# implement-ticket
Ticket : chemin ou nom donné après le nom de la skill (ex. `docs/tickets/01-01-login-endpoint.md`) ; aucun → le demander d'abord.
Lire : `CLAUDE.md`, `BACKLOG.md`, `docs/TESTING.md`, ce ticket, la section de la spec liée.

1. **Clarifier d'abord :** point ambigu → s'arrêter, poser les questions avant de coder. Statut de `docs/TESTING.md` « Non installé » (et ce ticket n'est pas sa mise en place) → s'arrêter, proposer d'abord le ticket de mise en place de l'outil de test.
2. **Branche :** branche conforme (`feat/...`, `fix/...`, `refactor/...`) depuis la branche principale à jour.
3. **Tests :** écrire les tests de la section « Tests à écrire » du ticket, selon `docs/TESTING.md`.
4. **Code :** solution la plus simple répondant strictement aux critères d'acceptation.
5. **Vérification :** lancer la commande de test (`docs/TESTING.md`) et de lint (`CLAUDE.md` section 1) ; garder chaque commande exacte + résultat pour la checklist.
6. **Suivi :** proposer les modifications de doc nécessaires (`CHANGELOG.md`, `README.md`, `BACKLOG.md`, ticket…) ; n'écrire qu'après mon accord. Sous-tâche reportée → `BACKLOG.md` « Reporté / Incomplet » sans accord (seule exception, voir `CLAUDE.md`), signalée dans « Reports : … ». Dernier ticket de la spec → proposer aussi la spec « Implémentée » + cocher sa ligne dans `ROADMAP.md`.
7. **Valider, puis commiter :** résumé + checklist de `CLAUDE.md` (Pass/Fail avec preuve) ; preuve du point 6 = branche + titre de commit proposé (Conventional Commits). Proposer le commit (fichiers + titre) ; ne commiter qu'après mon accord.
8. **Clôture :** après le commit, vérifier que tout l'avancement est sur le disque (critères cochés dans le ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, selon ce qui a été validé) : la session suivante repart de ces fichiers, pas de la conversation. Terminer par : « Lance `/clear` avant le ticket suivant. »
