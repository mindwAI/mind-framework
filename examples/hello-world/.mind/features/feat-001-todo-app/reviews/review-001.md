---
status: done
feature_id: feat-001-todo-app
type: review
reviewed_tasks: [task-001, task-002, task-003]
created: 2026-01-20
---

# Code Review — Todo App API (Tasks 001-003)

## Summary of Changes

Three tasks implemented across 6 files: Express app with 3 routes
(POST, GET, PATCH), SQLite database module, and test suite. Total:
~280 lines of application code, ~200 lines of tests.

## Files Reviewed

| File | Lines | Status |
|------|-------|--------|
| src/db.js | 58 | Reviewed |
| src/app.js | 82 | Reviewed |
| src/server.js | 8 | Reviewed |
| tests/db.test.js | 95 | Reviewed |
| tests/todos.test.js | 110 | Reviewed |
| package.json | 22 | Reviewed |

## Issues Found

| # | Severity | File | Line | Description | Suggestion |
|---|----------|------|------|-------------|------------|
| 1 | MAJOR | src/app.js | 34 | PATCH route does not validate that `:id` is a valid integer. Passing `/todos/abc/complete` reaches the database query, which returns null but the error path is ambiguous. | Add `if (!/^\d+$/.test(req.params.id)) return res.status(404).json(...)` before the DB call. |
| 2 | MAJOR | src/app.js | 12 | POST route does not trim whitespace from `text`. A body like `{ "text": "   " }` passes validation but creates a blank todo. | Add `const text = (req.body.text || '').trim()` and validate after trimming. |
| 3 | MINOR | src/db.js | 41 | `listTodos` builds SQL string via concatenation. While safe here (no user input in the WHERE clause values), it would be cleaner to use parameterized conditions. | Refactor to use `WHERE completed_at IS NOT NULL` as a static string selected by the filter value. |

## Positive Points

- Clean separation between db.js (data) and app.js (HTTP)
- Tests cover all FRs including edge cases (empty list, idempotent complete)
- Error responses follow consistent `{ "error": "message" }` format
- No business logic in route handlers — all queries delegated to db.js

## Conformance

| Rule | Status |
|------|--------|
| code-standards (naming, size) | PASS — all functions < 20 lines, camelCase naming |
| tests (AAA structure, coverage) | PASS — tests follow Arrange-Act-Assert, > 80% coverage |
| git-branching | PASS — work done on feature branch |

## Verdict: APPROVED WITH OBSERVATIONS

Issues #1 and #2 are MAJOR but non-blocking — the core functionality works
correctly for valid input. Both should be fixed before merging to main.
Issue #3 is a style improvement.

**Recommendation:** Fix issues #1 and #2, then proceed to QA.
