# Tests

Test standards applicable to the entire project. Agents must create and maintain tests according to these conventions.

## Principles

- **Independence:** Each test must run independently. No shared state between tests.
- **AAA/GWT structure:** Every test follows Arrange-Act-Assert or Given-When-Then.
- **One behavior per test:** Small, focused tests. If the name needs "and", break it in two.
- **Descriptive names:** Start with "should" — `should return error when input is empty`.

## Execution

- Tests must pass with the project's standard command (e.g., `npm test`, `go test ./...`, `pytest`).
- Tests must run without external dependencies (database, API, network) unless they are explicitly integration tests.

## Mocks and Time

- Mock to isolate boundaries (external APIs, database, filesystem) — never for internal logic.
- For time-dependent tests, use Date/Clock mocking (e.g., `jest.spyOn(Date, 'now')`, mocked `time.Now()`).

## Coverage

- Configure minimum coverage threshold (recommended: 80%).
- Coverage without quality is worse than no coverage — each test must validate real behavior.

## Assertions

- Verify **all critical fields** of the result, not just one.
- Prefer specific assertions over generic ones:
  ```
  // Bad
  expect(result).toBeTruthy()
  
  // Good
  expect(result.status).toBe('active')
  expect(result.userId).toBe('user-123')
  ```

## Anti-patterns (Avoid)

| Anti-pattern | Problem | Solution |
|-------------|---------|----------|
| Test that only verifies "it ran" | Doesn't validate real behavior | Add result assertions |
| Mock that replicates implementation logic | Test tests the mock, not the code | Mock only at boundaries |
| Broad snapshot without field verification | Changes go unnoticed | Verify critical fields explicitly |
| Tests dependent on order | Fail randomly | Isolate state per test |
| Happy path only | Edge cases and errors uncovered | Add error and boundary scenarios |
| Coverage without regression | Bugs return undetected | Each fixed bug gets a regression test |

## Quality Checklist

- [ ] Tests fail if the bug returns
- [ ] No shared state between tests
- [ ] Mocks isolate boundaries, not internal logic
- [ ] Assertions cover critical fields
- [ ] Error and edge case scenarios covered when risk warrants
- [ ] Descriptive names that explain the tested behavior
