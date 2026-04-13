---
name: go
description: "Go conventions for backend services"
scope: "services/**"
---

# Go Standards

These rules apply only to files matching `services/**`.

## Error Handling

- Always wrap errors with context: `fmt.Errorf("create user: %w", err)`.
- Never discard errors: `result, _ := doSomething()` is forbidden.
- Return errors to the caller. Only log at the top-level handler.
- Use sentinel errors (`var ErrNotFound = errors.New(...)`) for expected conditions.

## Functions

- No naked returns. Always name what you return explicitly.
- Maximum 3 parameters. Use an options struct for more.
- Functions that return errors: `(result, error)` — error is always last.

## Testing

- Use table-driven tests for functions with multiple input/output scenarios.
- Test file lives next to the source: `user.go` → `user_test.go`.
- Use `testify/assert` for assertions, not raw `if` comparisons.
- Integration tests use build tag `//go:build integration`.

## Naming

- Packages: short, lowercase, no underscores (`auth`, `user`, `db`).
- Interfaces: verb-based (`Reader`, `Validator`), not noun-based.
- Exported functions: descriptive enough to not need comments.

## Concurrency

- Never share state between goroutines without synchronization.
- Prefer channels for communication, mutexes for protecting shared state.
- Always set timeouts on context: `context.WithTimeout(ctx, 30*time.Second)`.
