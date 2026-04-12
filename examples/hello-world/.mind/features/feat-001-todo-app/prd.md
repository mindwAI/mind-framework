---
status: done
feature_id: feat-001-todo-app
type: prd
created: 2026-01-15
---

# PRD — Todo App API

## Overview

People forget tasks. Sticky notes get lost, mental lists fail under load, and
scattered reminders across apps create more chaos than they solve. This feature
builds a minimal REST API that lets a single user create, list, and complete
todo items. The API is intentionally simple — three endpoints, one database
table, no authentication — to demonstrate the MIND Framework pipeline without
the complexity of a production system.

## Assumptions and Dependencies

| Assumption | Status | Validation |
|------------|--------|------------|
| Single-user usage (no auth needed) | validated | Scope decision — auth is out of scope |
| SQLite is sufficient for storage | validated | Single-user, no concurrent writes |
| Node.js + Express available on dev machine | validated | Standard dev environment |

## Goals

1. Provide a working REST API for managing todo items
2. Demonstrate all MIND Framework pipeline artifacts end-to-end
3. Keep implementation simple enough to review in under 10 minutes

## Success Criteria

| Criterion | Metric | Target |
|-----------|--------|--------|
| API responds to all 3 endpoints | Manual test with curl | 3/3 endpoints return correct responses |
| Todo items persist across restarts | Stop and start server, verify data | Items still present |
| Input validation rejects bad requests | Send malformed payloads | 400 status with clear error message |
| Test coverage | jest --coverage | > 80% line coverage |

## User Stories

### [P1] — Create a Todo

**As a** user, **I want** to create a todo item with a text description,
**so that** I can record tasks I need to complete.

### [P1] — List Todos

**As a** user, **I want** to list all my todo items with optional filtering
by completion status, **so that** I can see what needs to be done or review
what I have finished.

### [P1] — Complete a Todo

**As a** user, **I want** to mark a todo item as completed,
**so that** I can track my progress and distinguish finished work from
pending work.

## Main Features

### Feature 1 — Create Todo

- **What it does:** Accepts a JSON body with a `text` field and creates a new todo item.
- **Why:** Core functionality — without creation, the app has no purpose.
- **Functional Requirements:**
  - FR-1.1: `POST /todos` accepts `{ "text": "string" }` and returns the created todo with `id`, `text`, `completed_at: null`, and `created_at`
  - FR-1.2: Returns 400 if `text` is missing, empty, or longer than 500 characters
  - FR-1.3: Returns 201 on success with the full todo object

### Feature 2 — List Todos

- **What it does:** Returns all todo items, with optional filtering by completion status.
- **Why:** Users need to see their todos to act on them.
- **Functional Requirements:**
  - FR-2.1: `GET /todos` returns an array of all todo items ordered by `created_at` descending
  - FR-2.2: `GET /todos?completed=true` returns only completed items
  - FR-2.3: `GET /todos?completed=false` returns only pending items
  - FR-2.4: Returns 200 with empty array if no todos exist

### Feature 3 — Complete Todo

- **What it does:** Marks a specific todo item as completed by setting `completed_at` to the current timestamp.
- **Why:** Completion tracking is the core value of a todo app.
- **Functional Requirements:**
  - FR-3.1: `PATCH /todos/:id/complete` sets `completed_at` to current ISO timestamp
  - FR-3.2: Returns 404 if the todo with the given `id` does not exist
  - FR-3.3: Returns 200 with the updated todo object
  - FR-3.4: Completing an already-completed todo is idempotent (returns 200, no error)

## Key Entities

| Entity | Description | Key Fields |
|--------|-------------|------------|
| Todo | A task the user wants to track | id (integer, auto), text (string, required), completed_at (timestamp, nullable), created_at (timestamp) |

## High-Level Technical Constraints

- Node.js + Express for the HTTP server
- SQLite for persistence (file-based, no external database)
- No authentication (single-user scope)
- JSON request and response bodies
- Structured error responses: `{ "error": "message" }`

## Out of Scope

- User authentication and authorization
- Todo deletion or editing (only create and complete)
- Due dates, priorities, or categories
- Frontend / UI
- Deployment configuration
- Rate limiting

## TechSpec Readiness Criteria

- [x] Problem and users clearly defined
- [x] Functional requirements numbered and testable (FR-1.1 through FR-3.4)
- [x] High-level technical constraints identified
- [x] Open assumptions explicit
- [x] Scope bounded (including out of scope)
