---
name: spec-to-tickets
description: Découpe une spec validée en tickets atomiques prêts à être exécutés, avec les tests à écrire. À utiliser seulement quand l'utilisateur le demande explicitement (`/spec-to-tickets <spec>` dans Claude Code, `$spec-to-tickets <spec>` dans Codex).
disable-model-invocation: true
---

# spec-to-tickets

**Spec à découper :** le chemin ou le nom donné par l'utilisateur après le nom de la skill (ex. `docs/specs/01-authentification.md` ou `01`). S'il n'y en a pas, demande-le avant tout.

Lis cette spec, `CLAUDE.md` et `docs/TESTING.md`.

Découpe la spec en tickets atomiques (1 ticket = 1 PR = 1 session) en suivant `TICKET.tpl.md` (dans `~/.claude/templates/<langue du projet>/`).

- **Nom de chaque ticket :** `docs/tickets/<NN spec>-<NN ticket>-<slug>.md` (ex. spec `01-authentification.md` → `01-01-login-endpoint.md`, `01-02-logout-endpoint.md`).
- **Ordre des tickets :** découpe et ordonne les tickets pour que chacun, une fois fusionné, laisse `main` fonctionnel (build et tests OK). Si un ticket ne peut pas l'être seul, signale-le dans le tableau.
- **Tests à écrire :** pour chaque ticket, remplis la section avec au moins un test par critère d'acceptation, en respectant l'emplacement et le nommage de `docs/TESTING.md`.

Présente d'abord le découpage sous forme de tableau (fichier, titre, critères, tests). Après validation, demande-moi si je veux enregistrer les tickets dans `docs/tickets/` ou les créer en Issues GitHub (`gh issue create`).
