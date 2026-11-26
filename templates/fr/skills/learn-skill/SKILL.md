---
name: learn-skill
description: Capitalise sur une erreur récurrente ou une procédure complexe en proposant une règle pour CLAUDE.md ou une nouvelle skill (projet par défaut, partagée entre Claude Code et Codex, vérifiée par script). À utiliser seulement quand l'utilisateur le demande explicitement (`/learn-skill` dans Claude Code, `$learn-skill` dans Codex).
disable-model-invocation: true
---

# learn-skill

Analyse la session en cours (l'erreur, la correction ou la procédure complexe rencontrée). Sujet : celui donné par l'utilisateur après le nom de la skill ; s'il n'y en a pas, déduis-le de la session et fais-le-moi confirmer.

Dans cette skill, `CHECK` désigne le script de vérification copié dans le projet :
`.claude/skills/learn-skill/scripts/check-skill.sh` (à lancer depuis la racine du dépôt).
`KIT` désigne le dossier du kit : `KIT="$(dirname "$(dirname "$(readlink ~/.claude/skills/project-init)")")"`.

## Étape 1 : Diagnostic & choix du support
- **Règle dans `CLAUDE.md`** : règle courte (1-2 lignes) permanente sur tout le projet. Elle vaut aussi pour Codex, qui lit `CLAUDE.md` via `AGENTS.md`.
- **Skill (`SKILL.md`)** : procédure détaillée, pattern technique précis ou piège spécifique (chargée à la demande).

## Étape 2 : Portée de la skill
- **Projet (par défaut)** : `.claude/skills/<nom>/SKILL.md` à la racine du dépôt, avec le lien Codex `.agents/skills/<nom>`.
- **Globale (seulement si je la demande explicitement)** : `$KIT/skills/<nom>/SKILL.md` (dans le kit), avec un lien dans `~/.claude/skills/<nom>` et un dans `~/.agents/skills/<nom>`.

**Avant une skill globale**, vérifie qu'elle ne cite rien de propre au projet : langage, framework, outil, dépendance, chemin, commande ou nom de fichier du projet. Si c'est le cas, **ne la mets pas en globale** : liste-moi les éléments trouvés et propose la portée projet. Elle ne passe en globale que si je confirme après avoir vu cette liste.

## Étape 3 : Rédaction avec parité Claude Code / Codex
Rédige la skill en français (langue du projet), en suivant `~/.claude/templates/fr/SKILL.tpl.md`. Le `name` doit être identique au nom du dossier.

Toute mention propre à l'un des deux agents doit donner l'équivalent de l'autre :

| Claude Code | Codex |
|-------------|-------|
| `/<nom>` | `$<nom>` |
| `.claude/skills/` | `.agents/skills/` |
| `~/.claude/skills/` | `~/.agents/skills/` |
| `.claude/settings.json` (hooks) | `.codex/hooks.json` |

Citer `CLAUDE.md` est autorisé : c'est le fichier de règles des deux agents. Un élément sans équivalent est signalé dans la proposition, jamais supprimé en silence.

Un appel de skill s'écrit toujours entre backticks : `` `/<nom>` `` et `` `$<nom>` ``. Un `/nom` sans backticks est lu comme un chemin de dossier et n'est pas contrôlé.

## Étape 4 : Proposition et autorisation (obligatoire)
Montre-moi le texte exact, le support choisi et **le chemin complet de destination**. **N'écris rien tant que je ne l'ai pas autorisé explicitement.**

## Étape 5 : Création et vérification
Après autorisation :
- **Règle** : ajoute-la à `CLAUDE.md` (qui doit rester < 150 lignes).
- **Skill projet** (depuis la racine du dépôt) :
  1. écris `.claude/skills/<nom>/SKILL.md` ;
  2. `mkdir -p .agents/skills && ln -s ../../.claude/skills/<nom> .agents/skills/<nom>` (lien relatif, valable après un clone) ;
  3. `CHECK validate .claude/skills <nom> --agents .agents/skills`
- **Skill globale** :
  1. écris `$KIT/skills/<nom>/SKILL.md` ;
  2. `ln -s "$KIT/skills/<nom>" ~/.claude/skills/<nom> && ln -s "$KIT/skills/<nom>" ~/.agents/skills/<nom>` ;
  3. `CHECK validate "$KIT/skills" <nom> --agents ~/.agents/skills`

Donne la sortie du script comme preuve. Si elle contient `FAIL`, corrige uniquement les points signalés, montre-moi la correction et attends mon accord avant de relancer.

## Étape 6 : Commit (et push pour une skill globale)
Une fois la sortie en `PASS`, propose le commit et attends mon accord (un accord pour « commit puis push » vaut pour les deux) :
- **Skill projet** : commit dans le dépôt du projet, sur la branche en cours, avec `.claude/skills/<nom>/`, le lien `.agents/skills/<nom>` et `.claude/skills/.validated`. Le `pre-commit` du projet revérifie la skill. Pas de push direct : la skill part avec la PR en cours.
- **Skill globale** : commit dans le dépôt du kit (`git -C "$KIT" …`), avec `skills/<nom>/` et `skills/.validated`. Le `pre-commit` du kit revérifie la skill. Puis, si le dépôt du kit a un remote (`git -C "$KIT" remote`), propose le push.
- Titre du commit au format Conventional Commits (ex. `feat(skills): add <nom>`).
