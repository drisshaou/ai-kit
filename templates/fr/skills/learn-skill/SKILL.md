---
name: learn-skill
description: Capitalise sur une erreur récurrente ou une procédure complexe en proposant une règle pour CLAUDE.md ou une nouvelle skill (projet par défaut, partagée entre Claude Code et Codex, vérifiée par script). À utiliser seulement quand l'utilisateur le demande explicitement (`/learn-skill` dans Claude Code, `$learn-skill` dans Codex).
disable-model-invocation: true
---

# learn-skill
Analyser la session en cours (erreur, correction ou procédure complexe). Sujet : donné après le nom de la skill ; aucun → le déduire de la session, me le faire confirmer.

- `CHECK` = script du projet `.claude/skills/learn-skill/scripts/check-skill.sh` (depuis la racine du dépôt).
- `KIT` = dossier du kit : `KIT="$(dirname "$(dirname "$(readlink ~/.claude/skills/init-project)")")"`.

## 1. Support
- **Règle dans `CLAUDE.md` :** règle courte et permanente pour tout le projet (1-2 lignes). Vaut aussi pour Codex (lit `CLAUDE.md` via `AGENTS.md`).
- **Skill (`SKILL.md`) :** procédure détaillée, pattern technique précis ou piège spécifique (chargée à la demande).

## 2. Portée
- **Projet (par défaut) :** `.claude/skills/<nom>/SKILL.md` à la racine du dépôt + lien Codex `.agents/skills/<nom>`.
- **Globale (seulement si je la demande explicitement) :** `$KIT/skills/<nom>/SKILL.md` + liens `~/.claude/skills/<nom>` et `~/.agents/skills/<nom>`.
- **Nom libre (obligatoire, toute portée) :** `ls -d .claude/skills/<nom> ~/.claude/skills/<nom> ~/.agents/skills/<nom> "$KIT/skills/<nom>" ~/.claude/templates/*/skills/<nom> 2>/dev/null` ne doit rien afficher ; sinon nom pris (skill du projet, perso, du kit ou du workflow) → en proposer un autre.
- **Avant une skill globale :** elle ne doit rien citer de propre au projet (langage, framework, outil, dépendance, chemin, commande, nom de fichier). Trouvé → **pas globale** : lister les éléments, proposer la portée projet. Globale seulement si je confirme après avoir vu la liste.

## 3. Rédaction (parité Claude Code / Codex)
- En français (langue du projet), selon `~/.claude/templates/fr/SKILL.tpl.md` ; `name` = nom du dossier.
- Style : compact (puces impératives, `Clé : valeur`, sans remplissage) ; frontmatter, commandes, chemins, blocs de code gardés tels quels. Même style pour une règle de `CLAUDE.md`.
- Toute mention propre à un agent donne l'équivalent de l'autre :

| Claude Code | Codex |
|-------------|-------|
| `/<nom>` | `$<nom>` |
| `.claude/skills/` | `.agents/skills/` |
| `~/.claude/skills/` | `~/.agents/skills/` |
| `.claude/settings.json` (hooks) | `.codex/hooks.json` |

- Citer `CLAUDE.md` est autorisé (fichier de règles des deux agents). Sans équivalent → le signaler dans la proposition, jamais supprimer en silence.
- Appel de skill toujours entre backticks : `` `/<nom>` `` et `` `$<nom>` ``. Un `/nom` sans backticks est lu comme un chemin et n'est pas contrôlé.

## 4. Proposition (obligatoire)
Montrer le texte exact, le support choisi et **le chemin complet de destination**. **Ne rien écrire avant mon autorisation explicite.**

## 5. Création & vérification
Après autorisation :
- **Règle :** l'ajouter à `CLAUDE.md` (doit rester < 150 lignes).
- **Skill projet** (depuis la racine du dépôt) :
  1. écrire `.claude/skills/<nom>/SKILL.md` ;
  2. `mkdir -p .agents/skills && ln -s ../../.claude/skills/<nom> .agents/skills/<nom>` (lien relatif, valable après un clone) ;
  3. `CHECK validate .claude/skills <nom> --agents .agents/skills`
- **Skill globale :**
  1. écrire `$KIT/skills/<nom>/SKILL.md` ;
  2. `ln -s "$KIT/skills/<nom>" ~/.claude/skills/<nom> && ln -s "$KIT/skills/<nom>" ~/.agents/skills/<nom>` ;
  3. `CHECK validate "$KIT/skills" <nom> --agents ~/.agents/skills`
- Donner la sortie du script comme preuve. `FAIL` → corriger seulement les points signalés, montrer la correction, ne relancer qu'après mon accord.

## 6. Commit (+ push pour une skill globale)
Sortie `PASS` → proposer le commit, attendre l'accord (un accord « commit puis push » vaut pour les deux) :
- **Projet :** dépôt du projet, branche en cours : `.claude/skills/<nom>/`, lien `.agents/skills/<nom>`, `.claude/skills/.validated`. Le `pre-commit` du projet revérifie. Pas de push direct : part avec la PR en cours.
- **Globale :** dépôt du kit (`git -C "$KIT" …`) : `skills/<nom>/`, `skills/.validated`. Le `pre-commit` du kit revérifie. Remote présent (`git -C "$KIT" remote`) → proposer le push.
- Titre : Conventional Commits (ex. `feat(skills): add <nom>`).
