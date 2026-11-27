# Spec {{NN}}: {{FEATURE_TITLE}}

- **Status:** Draft | Validated | Implemented
- **Milestone:** {{MILESTONE}}
- **Date:** {{YYYY-MM-DD}}

## 1. Goal & Context
{{WHY_THIS_FEATURE_EXISTS}}

## 2. User Stories / Use Cases
- As a **{{ROLE}}**, I want **{{ACTION}}** so that **{{BENEFIT}}**.
- **Main flow:**
  1. {{STEP_1}}
  2. {{STEP_2}}

## 3. Data Model
- `{{TABLE_OR_MODEL}}`: `id`, `{{FIELD}}` ({{TYPE}}, {{CONSTRAINTS}})

## 4. Interface Contracts (API / UI / CLI)
- `{{METHOD}} {{ROUTE}}`
  - **Input:** `{ ... }`
  - **Output (200/201):** `{ ... }`
  - **Errors:** `400`, `401`, `403`, `404`

## 5. Edge Cases & Security
- **Input validation:** {{VALIDATION_RULES}}
- **Edge cases:** {{EDGE_CASE_1}}, {{EDGE_CASE_2}}
- **Permissions / Security:** {{AUTH_AND_SECURITY_RULES}}

## 6. Out of Scope
- {{NOT_IN_THIS_SPEC_1}}

## 7. Global Definition of Done
- [ ] All tests pass as described in `docs/TESTING.md` (evidence: command + result).
- [ ] No hardcoded secrets; `.env.example` and `README.md` up to date.
- [ ] Format, lint and type-check pass with no errors.
- [ ] `CHANGELOG.md` entry proposed under `Unreleased`.
