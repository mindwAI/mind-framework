---
status: done
feature_id: feat-001-todo-app
task_id: task-002
type: task
depends_on: [task-001]
created: 2026-01-18
---

# Task 002 — GET /todos with Filtering

**PRD:** feat-001-todo-app/prd.md
**TechSpec:** feat-001-todo-app/techspec.md
**Covers:** FR-2.1, FR-2.2, FR-2.3, FR-2.4

## Objective

Implement the `GET /todos` endpoint with optional filtering by completion
status via the `completed` query parameter.

## Acceptance Criteria

- [ ] `GET /todos` returns all todos ordered by created_at descending
- [ ] `GET /todos?completed=true` returns only completed items
- [ ] `GET /todos?completed=false` returns only pending items
- [ ] Returns 200 with empty array when no todos match
- [ ] Invalid `completed` values (e.g. `?completed=maybe`) return all todos
- [ ] `db.js` gains `listTodos(filter)` function with WHERE clause logic
- [ ] Tests cover: list all, list completed, list pending, empty result, invalid filter

## Subtasks

1. Add `listTodos(filter)` to `src/db.js` with conditional WHERE
2. Add GET route to `src/app.js`
3. Add tests to `tests/db.test.js` for listTodos with various filters
4. Add tests to `tests/todos.test.js` for GET endpoint (5 scenarios)

## Files

- `src/db.js` [MODIFY — add listTodos]
- `src/app.js` [MODIFY — add GET route]
- `tests/db.test.js` [MODIFY — add list tests]
- `tests/todos.test.js` [MODIFY — add GET tests]
