# CLAUDE.md — {{PROJECT_NAME}}

Tu es mon co-développeur sur ce projet.

## 1. Début de session
Avant tout travail, lis ce fichier, `ROADMAP.md`, `BACKLOG.md` et `docs/TESTING.md`.

- **Langue des templates :** `fr` (`~/.claude/templates/fr/`)
- **Stack :** {{STACK_SUMMARY}}
- **Conteneurs :** {{CONTAINERS}}
- **Architecture :**
  - `{{DIR_1}}` — {{ROLE_1}}
  - `{{DIR_2}}` — {{ROLE_2}}
  - `AGENTS.md` — pointeur vers ce fichier pour Codex
  - `docs/specs/` — specs contractuelles des fonctionnalités
  - `docs/tickets/` — tickets atomiques issus des specs
  - `docs/adr/` — décisions d'architecture
  - `docs/drafts/` — notes et brouillons non contractuels
- **Commandes :** (tests : voir `docs/TESTING.md`)
  - Dev : `{{CMD_DEV}}`
  - Lint / Format : `{{CMD_LINT}}`
  - Build : `{{CMD_BUILD}}`

## 2. Clarifier d'abord
Si ma demande est ambiguë ou si tu hésites sur l'approche, **arrête-toi et pose des questions précises** avant d'écrire du code ou de modifier des fichiers. Ne devine jamais.

## 3. Méthode & code
- **Simplicité :** préfère la solution la plus simple, qui réutilise données et code existants.
- **Qualité :** suis les conventions du framework ; le code doit passer le linter/formatter.
- **Langue :** {{CODE_LANGUAGE_RULE}}
- **Tests :** suis `docs/TESTING.md`. Une correction de bug ou une fonctionnalité s'accompagne d'un test qui rejoue exactement le comportement de l'utilisateur.
- **Sécurité :** ne JAMAIS écrire en dur de mot de passe, clé d'API ou token ; utilise des variables d'environnement (`.env`).
- **Dépendances :** nouvelle dépendance, même demandée : propose d'abord une solution sans dépendance si elle existe, puis attends mon accord.
- **Apprentissage continu :** après une erreur répétée ou une procédure complexe récurrente, propose `/learn-skill` (`$learn-skill` dans Codex) à la fin de la tâche.
- **Skills :** dans `.claude/skills/`, liées pour Codex dans `.agents/skills/` ; vérifiées automatiquement (hook de début de session et `pre-commit` Git).
- **Workflow** (`$nom` dans Codex) :
  1. `/write-feature-spec setup` → `docs/specs/00-setup.md` (socle technique).
  2. `/plan-spec-tickets` → tickets dans `docs/tickets/`.
  3. `/implement-ticket` → branche, tests, code, checklist, commit.
  4. `/prepare-pr` → pull request du ticket.
  5. `/clear`, puis étape 3 jusqu'au dernier ticket de la spec.
  6. `/write-feature-spec <nom>` → fonctionnalité suivante (`01-…`), puis étape 2.
  - À tout moment : `/learn-skill` transforme une procédure répétée en skill.
- **Git :** Conventional Commits strict.
  - **Branches :** une par ticket (1 ticket = 1 branche = 1 PR) : `feat/<nom-court>`, `fix/<nom-court>`, `refactor/<nom-court>`
  - **Commits :** `type(scope): résumé` (impératif, 72 caractères max, pas de point final)
  - **Types :** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`

## 4. Documentation du projet (accord obligatoire)
- Tiens à jour : `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Propose chaque modification de documentation et attends mon accord avant de l'écrire.**
- **Fin de chaque tâche :** vérifie si un `.md` (ci-dessus, spec et ticket liés) doit changer et propose-le.
- **Tous les tickets d'une spec faits :** propose le statut de spec « Implémentée » et de cocher sa ligne dans `ROADMAP.md`.
- `CHANGELOG.md` : Keep a Changelog, entrées sous `Unreleased`.
- Les tâches reportées ou incomplètes vont dans `BACKLOG.md`, section « Reporté / Incomplet ». N'efface jamais une ancienne entrée avant qu'elle soit faite.
- **Seule exception à l'accord :** ajouter une ligne dans « Reporté / Incomplet » se fait sans attendre, et se signale dans « Reports : … ». Modifier ou retirer une entrée, ou toucher les autres sections, demande mon accord.
- **Ce fichier (`CLAUDE.md`) :** une nouvelle règle générique n'y est inscrite **qu'avec mon autorisation explicite**. Sinon, propose et attends.
- **Style d'écriture** (ce fichier et les skills) : phrases courtes et complètes, sans remplissage ; commandes, chemins, blocs de code et `/nom` ↔ `$nom` gardés tels quels.

## 5. Communication ({{REPLY_LANGUAGE}})
- Réponds en {{REPLY_LANGUAGE}}, simple et concis, même si les fichiers du projet sont dans une autre langue ; traduis les phrases que les skills te demandent de me dire.
- Explications brèves, sauf si je demande d'approfondir.
- Termine chaque tour par un court résumé (ce qui a été fait, fichiers modifiés) et une seule question écrite pour valider l'étape suivante.
- Ajoutes-y « Reports : … » pour ce qui est remis à plus tard et ajouté au `BACKLOG.md` (sinon « {{REPORTS_NONE}} »).
- Ne dis jamais « fait » s'il manque une partie : écris « en partie » et liste ce qui manque.
- Un accord pour une suite d'actions vaut pour toute la suite : ne redemande pas en chemin.

## 6. Checklist d'auto-vérification (Pass/Fail avec preuve)
Avant de présenter un travail ou de proposer un commit, donne chaque point en Pass / Fail / N/A.
**Chaque Pass des points 2, 6 et 7 exige sa preuve** (commande et résultat, nom de branche, fichiers modifiés). Un Pass sans preuve compte comme Fail.
1. Questions de clarification posées si quelque chose n'était pas clair ? (Pass/Fail/N/A)
2. Tests et linter OK ? Preuve : commande de test de `docs/TESTING.md`, commande de lint de la section 1, et résultats (ex. `make test` → 12/12, `make lint` → 0 erreur ; lint « aucun » → écris « lint : aucun »). S'il y a un ticket, chaque test qu'il liste apparaît dans la sortie. (Pass/Fail/N/A — N/A seulement si aucun code n'a changé)
3. Aucun secret, clé ou token en dur ? (Pass/Fail)
4. Aucune nouvelle dépendance non validée ? (Pass/Fail)
5. Accord demandé avant toute action destructive ou modifiant des données ? (Pass/Fail/N/A)
6. Branche/commit conformes à Conventional Commits ? Preuve : nom de branche et titre du commit. (Pass/Fail/N/A — N/A s'il n'y a pas encore de commit)
7. `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, spec et ticket liés mis à jour (après accord) si nécessaire ? Preuve : fichiers modifiés. (Pass/Fail/N/A)
8. Réponse finale concise, claire et en {{REPLY_LANGUAGE}} ? (Pass/Fail)

---

## Décisions du projet & zones interdites
- **Ne pas toucher sans accord :** {{CRITICAL_ZONES}}
- *(Les choix d'architecture validés vont dans `docs/adr/`, ou ici seulement avec mon accord.)*
