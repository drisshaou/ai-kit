---
name: project-init
description: Initialise un nouveau projet ou convertit un projet existant au workflow ai-kit (CLAUDE.md, AGENTS.md, ROADMAP, BACKLOG, CHANGELOG, TESTING, hooks, dossiers docs). À utiliser seulement quand l'utilisateur le demande explicitement (`/project-init` dans Claude Code, `$project-init` dans Codex).
disable-model-invocation: true
---

# project-init

Tu es mon co-développeur et architecte logiciel. Ta mission est de poser les bases propres de ce projet sans jamais deviner ce qui manque.

## Phase 0 : Langue des templates
Demande-moi la langue des fichiers du projet : **fr** ou **en**. Tous les templates viennent ensuite de `~/.claude/templates/<langue>/` ; les fichiers communs (`settings.tpl.json`, `codex-hooks.tpl.json`, `codex-rules.tpl.rules`, `pre-commit.tpl.sh`) sont dans `~/.claude/templates/`.
Si je choisis **fr**, demande aussi la règle de langue pour le code et les commits (placeholder `{{CODE_LANGUAGE_RULE}}`).

## Phase 1 : Détection du contexte
Analyse le répertoire courant (`ls -la`, `git status`, fichiers de config : `package.json`, `composer.json`, `pyproject.toml`, `Cargo.toml`, `Makefile`, `CMakeLists.txt`, `Dockerfile`, etc.) et détermine si le projet est **NOUVEAU** ou **EXISTANT**.

Détecte aussi :
- les **tests existants** : dossiers (`tests/`, `test/`, `__tests__/`, `spec/`…), fichiers (`*.spec.*`, `*.test.*`, `test_*`…), configuration de l'outil (`vitest.config.*`, `jest.config.*`, `pytest.ini`, `[tool.pytest]`, cibles `test`/`check` du `Makefile`, script `test` du `package.json`…) ;
- les **hooks Git existants** : `git config core.hooksPath`, `.git/hooks/` (hors `*.sample`), `.husky/`, `lefthook.yml`, `.pre-commit-config.yaml` ;
- les fichiers du kit déjà présents (`CLAUDE.md`, `AGENTS.md`, `ROADMAP.md`, `.claude/settings.json`, `.codex/hooks.json`…).

Affiche un diagnostic synthétique (5 lignes max), avec ce qui a été trouvé pour les tests et les hooks.

## Phase 2 : Interview guidée (NE GÉNÈRE AUCUN FICHIER AVANT LA FIN)
Pose tes questions par blocs de 3 à 4 questions maximum et attends mes réponses avant de continuer.

- **Si NOUVEAU :**
  1. Objectif du produit en 2 phrases et utilisateurs cibles.
  2. Stack technique imposée (langages, frameworks, DB, hébergement).
  3. Périmètre strict du MVP (`v0.1`) et ce qui est explicitement hors périmètre.
  4. Conventions ou contraintes non négociables (sécurité, CI/CD).
  5. Commandes prévues (dev, lint, build) : celles que je donne, sinon « à définir ».

- **Si EXISTANT :**
  1. Valide avec moi les commandes réelles détectées (dev, lint, build).
  2. Quelles sont les zones critiques ou la dette technique à ne pas casser ?
  3. Quels sont les 2 prochains jalons prioritaires ?
  4. Y a-t-il des conventions implicites absentes du code ?
  5. Objectif du produit en 2 phrases, utilisateurs cibles et ce qui est explicitement hors périmètre (pour `ROADMAP.md`).

- **Tests (dans les deux cas) :**
  - **Tests détectés :** valide avec moi l'outil, l'emplacement, le nommage et les commandes trouvés.
  - **Aucun test :** propose 1 à 2 outils adaptés à la stack, puis demande l'outil, l'emplacement et le nommage. **N'installe rien** : l'installation d'un outil est une nouvelle dépendance, elle se fait plus tard, après mon accord, dans un ticket dédié. Dans `docs/TESTING.md`, le statut sera « Non installé (ticket de mise en place à faire) ».

- **Hooks Git :** si des hooks existent déjà (Husky, lefthook, pre-commit, `core.hooksPath`…), ne change rien et demande-moi comment ajouter la vérification des skills (ajout d'une ligne au hook existant ou rien).

Termine par un résumé de l'interview et attends ma validation.

## Phase 3 : Génération de la structure
Une fois le résumé validé, génère en suivant strictement les modèles :
1. `CLAUDE.md` depuis `CLAUDE.tpl.md` (strictement < 150 lignes). Si le projet n'a pas de linter, écris `aucun` (projet fr) ou `none` (projet en) pour `{{CMD_LINT}}`.
2. `AGENTS.md` depuis `AGENTS.tpl.md` (pointeur vers `CLAUDE.md` pour Codex).
3. `ROADMAP.md` depuis `ROADMAP.tpl.md`.
4. `BACKLOG.md` depuis `BACKLOG.tpl.md`.
5. `CHANGELOG.md` depuis `CHANGELOG.tpl.md`.
6. `docs/TESTING.md` depuis `TESTING.tpl.md`, rempli avec les réponses de la partie Tests.
7. `.claude/settings.json` depuis `settings.tpl.json` (permissions adaptées aux commandes validées + hook `SessionStart` de vérification des skills). **Retire toute ligne `allow` dont la commande est inconnue, vide, `aucun` ou `none`** : un `{{CMD_TEST}}` vide donnerait `Bash( *)`.
8. `.codex/hooks.json` depuis `codex-hooks.tpl.json` (hook `SessionStart` équivalent pour Codex), et `.codex/rules/default.rules` depuis `codex-rules.tpl.rules` (mêmes commandes interdites que les `deny` de `.claude/settings.json`).
9. `.githooks/pre-commit` depuis `pre-commit.tpl.sh`, rendu exécutable, puis `git config core.hooksPath .githooks` — **seulement si aucun hook n'existait** (sinon, appliquer ce qui a été décidé en Phase 2).
10. Les dossiers `docs/specs/`, `docs/adr/`, `docs/tickets/`, `docs/drafts/`, `.claude/skills/` et `.agents/skills/` (avec un `.gitkeep` dans chaque dossier vide).
11. Si pertinent, `docs/adr/001-stack-and-architecture.md` depuis `ADR.tpl.md`.
12. Ajoute `.claude/settings.local.json` au `.gitignore` du projet (crée le fichier s'il n'existe pas ; s'il existe, propose l'ajout et attends mon accord).

Si un de ces fichiers existe déjà, ne l'écrase pas : propose les modifications et attends mon accord.
Rappelle-moi à la fin que Codex demandera d'approuver le nouveau hook une fois (`/hooks` dans Codex).
N'écris aucun code applicatif durant cette skill.
