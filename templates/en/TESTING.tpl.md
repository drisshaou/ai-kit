# TESTING — {{PROJECT_NAME}}

## 1. Tooling
- **Test tool:** {{TEST_TOOL}} *(e.g. Vitest, pytest, Criterion, custom Makefile script)*
- **Status:** {{STATUS}} *(one of three values: "Existing" | "Set up on YYYY-MM-DD" | "Not installed (setup ticket to do)")*
- **Runs in:** {{TEST_ENV}} *("host" | "container `<service>`")*

## 2. Location & Naming
- **Test directory:** `{{TEST_DIR}}`
- **File naming:** `{{TEST_FILE_PATTERN}}` *(e.g. `*.spec.ts`, `test_*.py`, `test_*.c`)*
- **Test naming:** `{{TEST_NAME_PATTERN}}` *(e.g. `should <behavior> when <condition>`)*

## 3. Commands
- Run all tests: `{{CMD_TEST}}`
- Run one file / one test: `{{CMD_TEST_ONE}}`
- Coverage (optional): `{{CMD_COVERAGE}}`

## 4. Writing Tests
- One test (at least) per acceptance criterion of the ticket, using the names listed in the ticket's "Tests to write" section.
- A bug fix comes with a test that reproduces the bug first.
- Tests replay the real user gesture or behavior, not internal details.

## 5. Evidence Format (Checklist item 2)
Report the exact command and its result:
```text
`{{CMD_TEST}}` → <passed>/<total> passed, <failed> failed
```
Every test listed in the ticket must appear in the output.
