---
name: write-feature-spec
description: Rédige la spécification technique et fonctionnelle d'une feature après interview, dans docs/specs/. À utiliser seulement quand l'utilisateur le demande explicitement (`/write-feature-spec <nom>` dans Claude Code, `$write-feature-spec <nom>` dans Codex).
disable-model-invocation: true
---

# write-feature-spec
Lire : `CLAUDE.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md` ; chercher des notes utiles dans `docs/drafts/`.
Fonctionnalité : nom donné après le nom de la skill ; aucun → le demander d'abord.

1. **Challenger :** avant d'écrire, poser des questions ciblées : cas limites, sécurité, modèle de données, **hors périmètre** explicite.
2. **Fichier :** `docs/specs/NN-<slug>.md`
   - Socle technique (setup du dépôt, environnement de dev avec les conteneurs si `CLAUDE.md` en prévoit, DB, CI, `.env.example` ; ligne « Socle & infra » de `ROADMAP.md`) → toujours `docs/specs/00-setup.md`.
   - Autres fonctionnalités : `NN` = plus grand numéro de `docs/specs/` + 1, à partir de `01` (`00` réservé au socle).
   - `<slug>` : kebab-case, minuscules, sans accents ni espaces (« Authentification OAuth » → `authentification-oauth`).
   - Annoncer le nom avant d'écrire.
3. **Rédiger :** après mes réponses, strictement selon `SPEC.tpl.md` (`~/.claude/templates/fr/`).
4. Aucun code. Me demander de valider la spec.
