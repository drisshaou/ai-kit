# {{TYPE}}({{SCOPE}}): {{SHORT_TITLE}}

- **Spec liée :** `docs/specs/{{SPEC_FILE}}` (section {{SECTION}})
- **Jalon :** {{MILESTONE}}
- **Branche suggérée :** `{{TYPE}}/{{SLUG}}`

## Périmètre technique
- Fichiers / couches impactés : {{FILES_OR_LAYERS}}

## Tâche
{{CLEAR_DESCRIPTION}}

## Critères d'acceptation
- [ ] CA1 — {{CRITERION_1}}
- [ ] CA2 — {{CRITERION_2}}

## Tests à écrire
*(Au moins un test par critère. Les noms doivent apparaître dans la sortie des tests — voir `docs/TESTING.md`.)*

| Critère | Fichier de test | Nom du test |
|---------|-----------------|-------------|
| CA1 | `{{TEST_FILE}}` | `{{TEST_NAME_1}}` |
| CA2 | `{{TEST_FILE}}` | `{{TEST_NAME_2}}` |

## Definition of Done
- [ ] Tous les tests ci-dessus écrits et réussis (preuve : `{{CMD_TEST}}` → résultat).
- [ ] Linter OK : `{{CMD_LINT}}`.
- [ ] Type-check OK : `{{CMD_TYPECHECK}}`.
- [ ] Modifications de documentation proposées et validées (`README.md`, `CHANGELOG.md`, `BACKLOG.md`…).
