# Git Branching

Branch strategy based on Gitflow. Agents must follow these conventions when creating branches and merging.

## Permanent Branches

| Branch | Purpose |
|--------|---------|
| `main` (or `master`) | Production code. Only receives merges from release and hotfix. |
| `develop` | Integration branch. Receives merges from feature, task, and bugfix. |

## Temporary Branches

| Type | Naming Pattern | Origin | Target |
|------|---------------|--------|--------|
| Feature | `feature/[name]` | `develop` | `develop` |
| Feature task | `feature/[name]-task-[id]-[name]` | `feature/[name]` | `feature/[name]` |
| Technical task | `task/task-[id]-[name]` | `develop` | `develop` |
| Hotfix | `hotfix/[description]` | `main` | `main` + `develop` |
| Bugfix | `bugfix/task-[id]-[name]` | `develop` | `develop` |
| Release | `release/[version]` | `develop` | `main` + `develop` |

## Naming Rules

- Use **kebab-case** in all branch names.
- Feature with tasks: main branch `feature/[name]`, sub-branches `feature/[name]-task-[id]-[name]` (use hyphens, not additional slashes).
- Technical task (no feature): `task/task-[id]-[name]`.
- Hotfix: `hotfix/[short-description]`.
- Bugfix: `bugfix/task-[id]-[name]`.
- Release: `release/[version]` (e.g., `release/1.2.0`).

## Flow Rules

1. **Feature branches** are created from `develop`.
2. **Feature tasks** create sub-branches from the feature branch.
3. When completing a task, merge into the parent branch (feature branch).
4. When completing a feature, merge into `develop`.
5. `main` only receives code via release or hotfix.
6. **NEVER commit directly to `main` or `develop`.**

## Lifecycle

```
develop
  └── feature/auth-system
        ├── feature/auth-system-task-001-create-schema
        ├── feature/auth-system-task-002-implement-service
        └── feature/auth-system-task-003-create-endpoints
```

1. Create feature branch from `develop`
2. For each task, create sub-branch from the feature
3. Complete task → merge into feature branch
4. Complete feature → merge into `develop`
5. Release → merge `develop` into `main`

## Commits

- Messages in English
- Format: `type: short description`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`
- Example: `feat: add user authentication service`
