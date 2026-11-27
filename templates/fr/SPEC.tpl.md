# Spec {{NN}} : {{FEATURE_TITLE}}

- **Statut :** Brouillon | Validée | Implémentée
- **Jalon :** {{MILESTONE}}
- **Date :** {{AAAA-MM-JJ}}

## 1. Objectif & contexte
{{WHY_THIS_FEATURE_EXISTS}}

## 2. User stories / cas d'usage
- En tant que **{{ROLE}}**, je veux **{{ACTION}}** afin de **{{BENEFIT}}**.
- **Flux principal :**
  1. {{STEP_1}}
  2. {{STEP_2}}

## 3. Modèle de données
- `{{TABLE_OR_MODEL}}` : `id`, `{{FIELD}}` ({{TYPE}}, {{CONSTRAINTS}})

## 4. Contrats d'interface (API / UI / CLI)
- `{{METHOD}} {{ROUTE}}`
  - **Entrée :** `{ ... }`
  - **Sortie (200/201) :** `{ ... }`
  - **Erreurs :** `400`, `401`, `403`, `404`

## 5. Cas limites & sécurité
- **Validation des entrées :** {{VALIDATION_RULES}}
- **Cas limites :** {{EDGE_CASE_1}}, {{EDGE_CASE_2}}
- **Permissions / sécurité :** {{AUTH_AND_SECURITY_RULES}}

## 6. Hors périmètre
- {{NOT_IN_THIS_SPEC_1}}

## 7. Critères de validation globale (Definition of Done)
- [ ] Tous les tests passent comme décrit dans `docs/TESTING.md` (preuve : commande + résultat).
- [ ] Aucun secret en dur ; `.env.example` et `README.md` à jour.
- [ ] Format, lint et type-check sans erreur.
- [ ] Entrée de `CHANGELOG.md` proposée sous `Unreleased`.
