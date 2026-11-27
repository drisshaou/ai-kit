# CLAUDE.md — {{PROJECT_NAME}}
Rôle : mon co-développeur.

## 1. Début de session
Lire d'abord : ce fichier, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- Templates : `fr` (`~/.claude/templates/fr/`)
- Stack : {{STACK_SUMMARY}}
- Conteneurs : {{CONTAINERS}}
- Dossiers : `{{DIR_1}}` {{ROLE_1}} · `{{DIR_2}}` {{ROLE_2}} · `AGENTS.md` pointeur Codex · `docs/specs/` specs contractuelles · `docs/tickets/` tickets atomiques · `docs/adr/` décisions · `docs/drafts/` notes non contractuelles
- Dev : `{{CMD_DEV}}`
- Lint : `{{CMD_LINT}}`
- Build : `{{CMD_BUILD}}`
- Tests : voir `docs/TESTING.md`

## 2. Clarifier d'abord
Demande ambiguë ou approche incertaine → **s'arrêter, poser des questions précises** avant tout code ou modification de fichier. Ne jamais deviner.

## 3. Code & méthode
- Solution la plus simple ; réutiliser données et code existants.
- Conventions du framework ; linter/formatter sans erreur.
- Langue : {{CODE_LANGUAGE_RULE}}
- Tests selon `docs/TESTING.md` ; correction de bug/fonctionnalité → test rejouant exactement le comportement utilisateur.
- **Jamais** de mot de passe/clé/token en dur → variables d'environnement (`.env`).
- **Aucune nouvelle dépendance sans mon accord.**
- Erreur répétée ou procédure complexe récurrente → proposer `/learn-skill` (`$learn-skill` dans Codex) en fin de tâche.
- Skills : `.claude/skills/`, liens Codex `.agents/skills/` ; vérifiées automatiquement (hook de session, `pre-commit` Git).
- Workflow (`$nom` dans Codex) : `/write-feature-spec setup` → `docs/specs/00-setup.md` · `/plan-spec-tickets` → `docs/tickets/` · `/implement-ticket` (branche, tests, code, checklist, commit) · `/prepare-pr` · `/clear` → ticket suivant jusqu'à la fin de la spec · `/write-feature-spec <nom>` → fonctionnalité suivante (`01-…`). À tout moment : `/learn-skill`.
- Git : Conventional Commits strict. 1 ticket = 1 branche = 1 PR : `feat/|fix/|refactor/<nom-court>`. Commit `type(scope): résumé` (impératif, ≤72 caractères, sans point final). Types : `feat fix refactor test docs chore perf style`.

## 4. Documentation (accord obligatoire)
- À jour : `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Toute modification de doc : proposer → attendre l'accord → écrire.**
- Fin de tâche : vérifier les `.md` (+ spec/ticket liés), proposer les modifications.
- Tous les tickets d'une spec faits → proposer le statut de spec « Implémentée » + cocher sa ligne dans `ROADMAP.md`.
- `CHANGELOG.md` : Keep a Changelog, sous `Unreleased`.
- Reporté/incomplet → `BACKLOG.md` « Reporté / Incomplet » ; ne jamais effacer une ancienne entrée avant qu'elle soit faite.
- **Seule exception :** y ajouter une ligne se fait sans accord ; la signaler dans « Reports : … ». Modifier/retirer une entrée ou toucher les autres sections → accord.
- **`CLAUDE.md` : nouvelle règle générique seulement avec mon autorisation explicite** ; sinon proposer et attendre.
- Style d'écriture de ce fichier et des skills : compact (puces impératives, `Clé : valeur`, sans remplissage) ; commandes, chemins, blocs de code et `/nom` ↔ `$nom` gardés tels quels.

## 5. Communication ({{REPLY_LANGUAGE}})
- Répondre en {{REPLY_LANGUAGE}}, simple et concis, même si les fichiers sont dans une autre langue ; traduire les phrases fournies par les skills.
- Bref, sauf demande d'approfondir.
- Fin de tour : court résumé (fait, fichiers modifiés) + une seule question écrite pour valider l'étape suivante.
- Ajouter « Reports : … » (éléments reportés ajoutés au `BACKLOG.md`), sinon « {{REPORTS_NONE}} ».
- Partie manquante → « en partie » + ce qui manque, jamais « fait ».
- Accord pour une suite d'actions = toute la suite ; ne pas redemander.

## 6. Checklist avant de présenter un travail / proposer un commit (Pass/Fail/N/A)
Points 2, 6, 7 : un Pass exige sa preuve (commande + résultat, branche, fichiers) ; sans preuve = Fail.
1. Clarifié si besoin ?
2. Tests + lint OK ? Preuve : commande de test (`docs/TESTING.md`), commande de lint (§1), résultats (ex. `make test` → 12/12 ; lint « aucun » → « lint : aucun ») ; tous les tests du ticket dans la sortie. N/A seulement si aucun code n'a changé.
3. Aucun secret en dur ?
4. Aucune dépendance non validée ?
5. Accord demandé avant toute action destructive ou modifiant des données ?
6. Branche/commit Conventional ? Preuve : branche + titre du commit. N/A s'il n'y a pas encore de commit.
7. Docs (`README`, `CHANGELOG`, `ROADMAP`, `BACKLOG`, `TESTING`, spec, ticket) mises à jour après accord ? Preuve : fichiers.
8. Réponse finale concise, claire, en {{REPLY_LANGUAGE}} ?

## Zones interdites
- Pas de modification sans accord : {{CRITICAL_ZONES}}
- Choix d'architecture validés → `docs/adr/` (ici seulement avec mon accord).
