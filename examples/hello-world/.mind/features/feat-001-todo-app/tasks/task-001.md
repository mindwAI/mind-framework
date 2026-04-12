---
status: done
feature_id: feat-001-todo-app
task_id: task-001
type: task
depends_on: []
created: 2026-01-17
---

# Task 001 — Project Setup + POST /todos

**PRD:** feat-001-todo-app/prd.md
**TechSpec:** feat-001-todo-app/techspec.md
**Covers:** FR-1.1, FR-1.2, FR-1.3

## Objective

Initialize the Node.js project, set up the SQLite database module, and
implement the `POST /todos` endpoint with input validation.

## Acceptance Criteria

- [ ] `npm init` with package.json including express, better-sqlite3, jest, supertest
- [ ] `db.js` creates the todos table on import (CREATE TABLE IF NOT EXISTS)
- [ ] `app.js` sets up Express with JSON body parsing
- [ ] `POST /todos` creates a todo and returns 201 with the full object
- [ ] Returns 400 if text is missing, empty, or > 500 characters
- [ ] `db.test.js` covers insert and validation scenarios
- [ ] `todos.test.js` covers POST happy path + 3 error cases

## Subtasks

1. Run `npm init -y` and install dependencies
2. Create `src/db.js` with schema initialization and `createTodo(text)` function
3. Create `src/app.js` with Express setup and POST route
4. Create `src/server.js` entry point
5. Write `tests/db.test.js` for createTodo
6. Write `tests/todos.test.js` for POST endpoint (201, 400 cases)

## Files

- `package.json` [NEW]
- `src/db.js` [NEW]
- `src/app.js` [NEW]
- `src/server.js` [NEW]
- `tests/db.test.js` [NEW]
- `tests/todos.test.js` [NEW]
