---
name: implement-ticket
description: Exécute un ticket atomique de bout en bout (branche, tests, code, vérification, suivi). À utiliser seulement quand l'utilisateur le demande explicitement (`/implement-ticket <ticket>` dans Claude Code, `$implement-ticket <ticket>` dans Codex).
disable-model-invocation: true
---

# implement-ticket

**Ticket à exécuter :** le chemin ou le nom donné par l'utilisateur après le nom de la skill (ex. `docs/tickets/01-01-login-endpoint.md`). S'il n'y en a pas, demande-le avant tout.

Lis `CLAUDE.md`, `BACKLOG.md`, `docs/TESTING.md`, ce ticket et la section de la spec liée.

1. **Clarifier d'abord :** si un point est ambigu, arrête-toi et pose tes questions avant de coder. Si le statut de `docs/TESTING.md` est « Non installé » (et que ce ticket n'est pas celui de sa mise en place), arrête-toi aussi : propose d'abord le ticket de mise en place de l'outil de test.
2. **Branche Git :** crée la branche conforme (`feat/...`, `fix/...`, `refactor/...`) depuis la branche principale à jour.
3. **Tests :** écris les tests listés dans la section « Tests à écrire » du ticket, en suivant `docs/TESTING.md`.
4. **Implémentation :** code la solution la plus simple qui répond strictement aux critères d'acceptation.
5. **Vérification :** lance la commande de test de `docs/TESTING.md` et la commande de lint de `CLAUDE.md` (section 1). Garde chaque commande exacte et son résultat pour la checklist.
6. **Suivi :** propose les modifications de documentation nécessaires (`CHANGELOG.md`, `README.md`, `BACKLOG.md`, ticket…) et attends mon accord avant de les écrire. Une sous-tâche repoussée va dans `BACKLOG.md`, section « Reporté / Incomplet » : c'est la seule écriture sans accord préalable (voir `CLAUDE.md`), signalée dans « Reports : … ». Si c'était le dernier ticket de la spec, propose aussi de passer la spec en « Implémentée » et de cocher sa ligne dans `ROADMAP.md`.
7. **Validation puis commit :** donne le résumé et la checklist d'auto-vérification (Pass/Fail avec preuve) de `CLAUDE.md` — pour le point 6, la preuve est le nom de la branche et le titre de commit proposé (Conventional Commits). Termine en proposant le commit (fichiers concernés + titre) et attends mon accord avant de le faire.
8. **Clôture :** après le commit, vérifie que tout l'avancement est écrit sur le disque (critères cochés dans le ticket, `BACKLOG.md`, `ROADMAP.md`, `CHANGELOG.md`, selon ce qui a été validé) : la session suivante repartira de ces fichiers, pas de la conversation. Termine par : « Lance `/clear` avant le ticket suivant. »
