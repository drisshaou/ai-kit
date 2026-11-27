---
name: plan-spec-tickets
description: Planifie les tickets d'une spec validée - la découpe en tickets atomiques (1 ticket = 1 branche = 1 PR), chacun avec les tests à écrire. À utiliser seulement quand l'utilisateur le demande explicitement (`/plan-spec-tickets <spec>` dans Claude Code, `$plan-spec-tickets <spec>` dans Codex).
disable-model-invocation: true
---

# plan-spec-tickets
Spec : chemin ou nom donné après le nom de la skill (ex. `docs/specs/01-authentification.md` ou `01`) ; aucun → le demander d'abord.
Lire : cette spec, `CLAUDE.md`, `docs/TESTING.md`.

Découper en tickets atomiques (1 ticket = 1 PR = 1 session) selon `TICKET.tpl.md` (`~/.claude/templates/fr/`).
- Nom : `docs/tickets/<NN de la spec>-<NN du ticket>-<slug>.md` (spec `01-authentification.md` → `01-01-login-endpoint.md`, `01-02-logout-endpoint.md`).
- Ordre : chaque ticket, une fois fusionné, laisse `main` fonctionnel (build + tests OK). Impossible seul → le signaler dans le tableau.
- Tests à écrire : ≥1 test par critère d'acceptation, emplacement et nommage selon `docs/TESTING.md`.

Présenter d'abord le découpage en tableau (fichier, titre, critères, tests). Une fois validé, demander : enregistrer dans `docs/tickets/` ou créer des GitHub Issues (`gh issue create`) ?
