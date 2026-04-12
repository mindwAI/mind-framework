---
status: done
feature_id: feat-001-todo-app
type: techspec
created: 2026-01-16
---

# TechSpec — Todo App API

## Summary

Three Express routes backed by a SQLite database. The app initializes the
database on first run, exposes the API on port 3000, and persists todos to
a local `todos.db` file. Input validation happens at the route level.
Tests use an in-memory SQLite database to avoid filesystem side effects.

## Technical Context

| Dimension | Value |
|-----------|-------|
| Runtime | Node.js 20+ |
| Framework | Express 4.x |
| Storage | SQLite via better-sqlite3 |
| Tests | Jest + supertest |
| Port | 3000 (configurable via PORT env) |

## Database Schema

```sql
CREATE TABLE IF NOT EXISTS todos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text TEXT NOT NULL,
  completed_at TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
```

Single table, no migrations needed. The `CREATE TABLE IF NOT EXISTS` runs
on app startup.

## API Routes

### POST /todos (FR-1.1, FR-1.2, FR-1.3)

```
Request:  { "text": "Buy groceries" }
Response: 201 { "id": 1, "text": "Buy groceries", "completed_at": null, "created_at": "2026-01-17T10:00:00.000Z" }
Error:    400 { "error": "text is required and must be 1-500 characters" }
```

Validation: reject if `text` is missing, empty string, not a string, or
longer than 500 characters.

Implementation: `db.prepare('INSERT INTO todos (text) VALUES (?)').run(text)`,
then fetch the created row by `last_insert_rowid()`.

### GET /todos (FR-2.1, FR-2.2, FR-2.3, FR-2.4)

```
Request:  GET /todos              → all todos
          GET /todos?completed=true  → completed only
          GET /todos?completed=false → pending only
Response: 200 [{ "id": 1, "text": "...", "completed_at": null, "created_at": "..." }, ...]
```

Query building:
- No filter: `SELECT * FROM todos ORDER BY created_at DESC`
- `completed=true`: add `WHERE completed_at IS NOT NULL`
- `completed=false`: add `WHERE completed_at IS NULL`

Invalid `completed` values are ignored (return all).

### PATCH /todos/:id/complete (FR-3.1, FR-3.2, FR-3.3, FR-3.4)

```
Request:  PATCH /todos/1/complete
Response: 200 { "id": 1, "text": "...", "completed_at": "2026-01-17T12:00:00.000Z", "created_at": "..." }
Error:    404 { "error": "todo not found" }
```

Implementation: first check the todo exists with `SELECT`. If not found,
return 404. If `completed_at` is already set, return the todo as-is
(idempotent). Otherwise, `UPDATE todos SET completed_at = datetime('now')
WHERE id = ?`.

## Project Structure

```
todo-app/
├── src/
│   ├── app.js          Express app setup + routes
│   ├── db.js           Database initialization + queries
│   └── server.js       Entry point (listen on PORT)
├── tests/
│   ├── todos.test.js   Integration tests via supertest
│   └── db.test.js      Unit tests for database functions
├── package.json
└── .mind/              (MIND Framework config)
```

## Error Handling

All routes use a try-catch wrapper. Unhandled errors return
`500 { "error": "internal server error" }`. Validation errors return 400.
Not-found returns 404. No stack traces in responses.

## Test Strategy

- **Unit tests (db.test.js):** Test database functions with in-memory SQLite.
  Cover: insert, select all, select filtered, complete, complete nonexistent.
- **Integration tests (todos.test.js):** Test HTTP routes via supertest.
  Cover: create valid, create invalid (missing text, empty text, too long),
  list all, list filtered, complete existing, complete nonexistent (404),
  complete already-completed (idempotent).
- **Target:** > 80% line coverage.

## Build Order

1. Initialize project (package.json, dependencies)
2. Database module (db.js — schema + query functions)
3. Express app with routes (app.js — POST, GET, PATCH)
4. Entry point (server.js)
5. Tests (db.test.js, todos.test.js)
6. Input validation refinement

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| SQLite locks on concurrent writes | Low — single user | Acceptable for demo scope |
| better-sqlite3 native build fails | Medium | Document Node.js version requirement |
