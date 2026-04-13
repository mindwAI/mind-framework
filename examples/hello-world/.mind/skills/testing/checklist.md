# Testing Quality Checklist

## Before Writing Tests

- [ ] Identify the behavior being tested (not the implementation)
- [ ] List edge cases: empty input, boundary values, error conditions
- [ ] Decide: unit test (isolated) or integration test (with dependencies)

## While Writing Tests

- [ ] Each test follows AAA: Arrange, Act, Assert
- [ ] Test name describes the behavior: `should return 404 when todo not found`
- [ ] One assertion per behavior (split multi-assert tests)
- [ ] Mocks only at boundaries (external APIs, DB) — never mock internal logic
- [ ] Error scenarios have tests, not just happy paths

## After Writing Tests

- [ ] All tests pass: `npm test` / `go test ./...` / `pytest`
- [ ] No flaky tests: run 3 times, all green
- [ ] Coverage meets project threshold (check `.mind/rules/tests.md`)
- [ ] No anti-patterns: shared state, order-dependent tests, snapshot-only validation
- [ ] Each bug fix has a regression test that fails without the fix
