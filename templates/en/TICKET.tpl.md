# {{TYPE}}({{SCOPE}}): {{SHORT_TITLE}}

- **Linked spec:** `docs/specs/{{SPEC_FILE}}` (Section {{SECTION}})
- **Milestone:** {{MILESTONE}}
- **Suggested branch:** `{{TYPE}}/{{SLUG}}`

## Technical Scope
- Impacted files / layers: {{FILES_OR_LAYERS}}

## Task
{{CLEAR_DESCRIPTION}}

## Acceptance Criteria
- [ ] AC1 — {{CRITERION_1}}
- [ ] AC2 — {{CRITERION_2}}

## Tests to Write
*(At least one test per criterion. Names must appear in the test output — see `docs/TESTING.md`.)*

| Criterion | Test file | Test name |
|-----------|-----------|-----------|
| AC1 | `{{TEST_FILE}}` | `{{TEST_NAME_1}}` |
| AC2 | `{{TEST_FILE}}` | `{{TEST_NAME_2}}` |

## Definition of Done
- [ ] All tests above written and passing (evidence: `{{CMD_TEST}}` → result).
- [ ] Linter passes: `{{CMD_LINT}}`.
- [ ] Type-check passes: `{{CMD_TYPECHECK}}`.
- [ ] Documentation changes proposed and approved (`README.md`, `CHANGELOG.md`, `BACKLOG.md`…).
