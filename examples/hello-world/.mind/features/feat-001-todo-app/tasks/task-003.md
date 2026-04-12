---
status: done
feature_id: feat-001-todo-app
task_id: task-003
type: task
depends_on: [task-001]
created: 2026-01-19
---

# Task 003 — PATCH /todos/:id/complete + Validation

**PRD:** feat-001-todo-app/prd.md
**TechSpec:** feat-001-todo-app/techspec.md
**Covers:** FR-3.1, FR-3.2, FR-3.3, FR-3.4

## Objective

Implement the `PATCH /todos/:id/complete` endpoint that marks a todo as
completed. Handle the 404 case for nonexistent todos and ensure idempotent
behavior when completing an already-completed todo.

## Acceptance Criteria

- [ ] `PATCH /todos/:id/complete` sets completed_at to current timestamp
- [ ] Returns 200 with the updated todo object
- [ ] Returns 404 with `{ "error": "todo not found" }` for nonexistent id
- [ ] Completing an already-completed todo returns 200 (idempotent, no error)
- [ ] Non-numeric `:id` returns 404
- [ ] `db.js` gains `completeTodo(id)` and `getTodoById(id)` functions
- [ ] Tests cover: complete existing, complete nonexistent (404), complete
      already-completed (idempotent), non-numeric id

## Subtasks

1. Add `getTodoById(id)` and `completeTodo(id)` to `src/db.js`
2. Add PATCH route to `src/app.js` with existence check
3. Add tests to `tests/db.test.js` for completeTodo
4. Add tests to `tests/todos.test.js` for PATCH endpoint (4 scenarios)
5. Add global error handler to `src/app.js` (try-catch wrapper)

## Files

- `src/db.js` [MODIFY — add getTodoById, completeTodo]
- `src/app.js` [MODIFY — add PATCH route + error handler]
- `tests/db.test.js` [MODIFY — add complete tests]
- `tests/todos.test.js` [MODIFY — add PATCH tests]
