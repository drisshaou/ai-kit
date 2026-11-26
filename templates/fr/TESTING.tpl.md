# TESTS — {{PROJECT_NAME}}

## 1. Outillage
- **Outil de test :** {{TEST_TOOL}} *(ex. Vitest, pytest, Criterion, script Makefile maison)*
- **Statut :** {{STATUT}} *(une des trois valeurs : « Existant » | « Mis en place le AAAA-MM-JJ » | « Non installé (ticket de mise en place à faire) »)*

## 2. Emplacement & nommage
- **Dossier des tests :** `{{TEST_DIR}}`
- **Nommage des fichiers :** `{{TEST_FILE_PATTERN}}` *(ex. `*.spec.ts`, `test_*.py`, `test_*.c`)*
- **Nommage des tests :** `{{TEST_NAME_PATTERN}}` *(ex. `doit <comportement> quand <condition>`)*

## 3. Commandes
- Lancer tous les tests : `{{CMD_TEST}}`
- Lancer un fichier / un test : `{{CMD_TEST_ONE}}`
- Couverture (optionnel) : `{{CMD_COVERAGE}}`

## 4. Écriture des tests
- Au moins un test par critère d'acceptation du ticket, avec les noms listés dans la section « Tests à écrire » du ticket.
- Une correction de bug s'accompagne d'un test qui reproduit d'abord le bug.
- Les tests rejouent le vrai geste ou comportement de l'utilisateur, pas des détails internes.

## 5. Format de preuve (point 2 de la checklist)
Donner la commande exacte et son résultat :
```text
`{{CMD_TEST}}` → <réussis>/<total> réussis, <échoués> échoués
```
Chaque test listé dans le ticket doit apparaître dans la sortie.
