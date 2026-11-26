---
name: spec-feature
description: Rédige la spécification technique et fonctionnelle d'une feature après interview, dans docs/specs/. À utiliser seulement quand l'utilisateur le demande explicitement (`/spec-feature <nom>` dans Claude Code, `$spec-feature <nom>` dans Codex).
disable-model-invocation: true
---

# spec-feature

Lis `CLAUDE.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md` et vérifie s'il existe des notes pertinentes dans `docs/drafts/`.

**Feature à spécifier :** le nom donné par l'utilisateur après le nom de la skill. S'il n'y en a pas, demande-le avant tout.

1. **Challenge :** avant d'écrire, pose-moi des questions ciblées sur les cas limites (*edge cases*), la sécurité, le modèle de données et ce qui reste explicitement **hors périmètre**.
2. **Nom du fichier :** `docs/specs/NN-<slug>.md`
   - **Socle technique** (setup du dépôt, DB, CI, `.env.example` — la ligne « Socle & infra » de `ROADMAP.md`) : le fichier est toujours `docs/specs/00-setup.md`.
   - **Autres features :** `NN` = numéro à 2 chiffres = plus grand numéro existant dans `docs/specs/` + 1, en commençant à `01` (le `00` est réservé au socle).
   - `<slug>` : le nom de la feature en kebab-case, minuscules, sans accents ni espaces (ex. « Authentification OAuth » → `authentification-oauth`).
   - Annonce-moi le nom choisi avant d'écrire.
3. **Rédaction :** une fois mes réponses obtenues, crée la spec en suivant strictement `SPEC.tpl.md` (dans `~/.claude/templates/<langue du projet>/`).
4. Ne code rien. Demande ma validation sur la spec.
