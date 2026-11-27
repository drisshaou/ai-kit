# CLAUDE.md — {{PROJECT_NAME}}

Tu es mon co-développeur sur ce projet.

## 1. Contexte & début de session
Avant tout travail, lis ce fichier, `ROADMAP.md`, `BACKLOG.md` et `docs/TESTING.md` pour connaître l'état actuel, les objectifs et la façon dont le projet est testé.

- **Langue des templates :** `fr` (`~/.claude/templates/fr/`)
- **Stack :** {{STACK_SUMMARY}}
- **Conteneurs :** {{CONTAINERS}}
- **Architecture :**
  - `{{DIR_1}}` — {{ROLE_1}}
  - `{{DIR_2}}` — {{ROLE_2}}
  - `AGENTS.md` — Pointeur vers ce fichier pour Codex
  - `docs/specs/` — Spécifications contractuelles des fonctionnalités
  - `docs/tickets/` — Tickets atomiques issus des specs
  - `docs/adr/` — Décisions d'architecture
  - `docs/drafts/` — Notes brutes, recherches et brouillons non contractuels
- **Commandes clés :** (tests : voir `docs/TESTING.md`)
  - Dev : `{{CMD_DEV}}`
  - Lint / Format : `{{CMD_LINT}}`
  - Build : `{{CMD_BUILD}}`

## 2. Clarifier d'abord (essentiel)
Si ma demande est ambiguë, manque de contexte, ou si tu hésites sur la meilleure approche, **arrête-toi et pose-moi des questions précises** avant d'écrire du code ou de modifier des fichiers. Ne devine pas et ne fais pas d'hypothèses à ma place.

## 3. Méthode & code
- **Simplicité :** cherche la solution la plus simple, qui réutilise les données et le code existants, avant d'inventer des mécanismes complexes.
- **Conventions & qualité :** suis les conventions natives du framework. Le code doit passer le linter/formatter sans erreur.
- **Langue :** {{CODE_LANGUAGE_RULE}}
- **Tests :** suis `docs/TESTING.md`. Pour une correction de bug ou une nouvelle fonctionnalité, un test doit rejouer exactement le geste ou le comportement de l'utilisateur.
- **Sécurité :** ne JAMAIS écrire en dur de mot de passe, clé d'API ou token. Toujours utiliser des variables d'environnement (`.env`).
- **Dépendances :** aucune nouvelle dépendance sans mon accord.
- **Apprentissage continu :** si tu répètes une erreur ou si nous établissons une procédure complexe récurrente, propose `/learn-skill` (`$learn-skill` dans Codex) à la fin de la tâche.
- **Skills :** les skills du projet sont dans `.claude/skills/` et liées pour Codex dans `.agents/skills/`. Leur conformité est vérifiée automatiquement (hook de début de session et `pre-commit` Git).
- **Workflow** (`$nom` dans Codex) :
  1. `/write-feature-spec setup` → `docs/specs/00-setup.md` (socle technique).
  2. `/plan-spec-tickets` → petits tickets dans `docs/tickets/`.
  3. `/implement-ticket` → branche, tests, code, checklist, commit.
  4. `/prepare-pr` → pull request du ticket.
  5. `/clear`, puis retour à l'étape 3 jusqu'au dernier ticket de la spec.
  6. `/write-feature-spec <nom>` → fonctionnalité suivante (`01-…`), puis étape 2.
  - À tout moment : `/learn-skill` transforme une procédure répétée en skill.
- **Git (référence IA & humain) :** « Conventional Commits » strict.
  - **Branches :** une branche par ticket (1 ticket = 1 branche = 1 PR) : `feat/<nom-court>`, `fix/<nom-court>`, `refactor/<nom-court>`
  - **Commits :** `type(scope): résumé` (impératif, 72 caractères max, pas de point final)
  - **Types :** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`

## 4. Documentation du projet (accord obligatoire)
- Tiens à jour tous les fichiers `.md` du projet : `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`.
- **Propose chaque modification de documentation et attends mon accord avant de l'écrire.**
- **À la fin de chaque tâche :** vérifie si un `.md` doit changer (ceux ci-dessus, la spec et le ticket liés) et propose la modification.
- **Quand tous les tickets d'une spec sont faits :** propose de passer son statut à « Implémentée » et de cocher sa ligne dans `ROADMAP.md`.
- `CHANGELOG.md` suit Keep a Changelog ; ajoute les entrées sous `Unreleased`.
- Note les tâches incomplètes ou reportées dans `BACKLOG.md`, section « Reporté / Incomplet ». N'efface jamais une ancienne entrée tant qu'elle n'est pas faite.
- **Seule exception à l'accord :** ajouter une ligne dans « Reporté / Incomplet » se fait sans attendre, et se signale dans « Reports : … ». Modifier ou retirer une entrée, ou toucher les autres sections, demande mon accord.
- **Ce fichier (`CLAUDE.md`) :** une nouvelle règle générique n'y est inscrite **que si je l'autorise explicitement**. Sinon, propose-la et attends.

## 5. Communication ({{REPLY_LANGUAGE}})
- Réponds en {{REPLY_LANGUAGE}}, de façon simple et concise, même si les fichiers du projet sont dans une autre langue. Les phrases que les skills te demandent de me dire sont aussi à traduire dans cette langue.
- Explications brèves, sauf si je demande d'approfondir.
- Termine chaque tour par un court résumé de ce qui a été fait, des fichiers modifiés, et une seule question écrite pour valider l'étape suivante.
- Dans ce résumé, ajoute « Reports : … » pour ce qui est remis à plus tard et ajouté au `BACKLOG.md` (sinon « {{REPORTS_NONE}} »).
- Ne dis jamais « fait » s'il manque une partie : écris « en partie » et liste ce qui manque.
- Un accord donné pour une suite d'actions vaut pour toute la suite : ne redemande pas en chemin.

## 6. Checklist d'auto-vérification (Pass/Fail avec preuve)
Avant de présenter un travail ou de proposer un commit, donne chaque point en Pass / Fail / N/A.
**Chaque Pass des points 2, 6 et 7 doit donner sa preuve** (commande lancée et résultat, nom de branche, fichiers modifiés). Un Pass sans preuve compte comme Fail.
1. Questions de clarification posées si quelque chose n'était pas clair ? (Pass/Fail/N/A)
2. Tests et linter OK ? Preuve : commande de test de `docs/TESTING.md`, commande de lint de la section 1, et leur résultat (ex. `make test` → 12/12, `make lint` → 0 erreur ; si la commande de lint est « aucun », écris « lint : aucun »). S'il y a un ticket, chaque test qu'il liste apparaît dans la sortie. (Pass/Fail/N/A — N/A seulement si aucun code n'a changé)
3. Aucun secret, clé ou token en dur ? (Pass/Fail)
4. Aucune nouvelle dépendance non validée ? (Pass/Fail)
5. Accord explicite demandé avant toute action destructive ou modifiant des données ? (Pass/Fail/N/A)
6. Branche/commit conformes à Conventional Commits ? Preuve : nom de branche et titre du commit. (Pass/Fail/N/A)
7. `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `BACKLOG.md`, `docs/TESTING.md`, spec et ticket liés mis à jour (après accord) si nécessaire ? Preuve : fichiers modifiés. (Pass/Fail/N/A)
8. Réponse finale concise, claire et en {{REPLY_LANGUAGE}} ? (Pass/Fail)

---

## Décisions du projet & zones interdites
- **Ne pas toucher sans accord :** {{CRITICAL_ZONES}}
- *(Les choix d'architecture validés sont notés dans `docs/adr/`, ou ici seulement avec mon accord.)*
