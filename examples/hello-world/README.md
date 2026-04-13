# Hello World — MIND Framework Example

You are looking at the output of a complete MIND Framework pipeline run.

The todo-app described in these artifacts is **fictitious** — there is no
runnable code here. The purpose is to show **what artifacts the framework
produces** when you run the full pipeline from PRD to QA.

## What's here

```
.mind/features/feat-001-todo-app/
├── prd.md              Product requirements (what to build and why)
├── techspec.md         Technical design (how to build it)
├── tasks/
│   ├── task-001.md     Setup + POST /todos
│   ├── task-002.md     GET /todos with filtering
│   └── task-003.md     PATCH /todos/:id/complete
├── reviews/
│   └── review-001.md   Code review (found 2 real bugs)
└── qa/
    └── qa-001.md       QA validation (all FRs pass, bugs fixed)
```

## Suggested reading order

Read the artifacts in pipeline order — each one builds on the previous:

1. **prd.md** — What problem we're solving, the 3 endpoints, acceptance criteria
2. **techspec.md** — Express routes, SQLite schema, test strategy
3. **task-001.md** — First task: project setup + POST endpoint
4. **task-002.md** — Second task: GET with filtering
5. **task-003.md** — Third task: PATCH complete + validation
6. **review-001.md** — Code review that found 2 real bugs (not "looks good")
7. **qa-001.md** — QA that verified all 11 FRs + confirmed bugs were fixed

Notice how each artifact references the ones before it. The review points
to specific code issues. The QA traces back to PRD requirements by number.
This coherence is what the MIND Framework enforces.

## v0.2.0 Additions

This example also demonstrates the 4 new concepts added in v0.2.0:

- **Scoped rule**: `.mind/rules/frontend.md` — applies only to `apps/web/**` files
- **Skill**: `.mind/skills/testing/` — auto-triggers when task mentions "test" or "coverage"
- **Agent hook**: `.mind/hooks/agent/pre-bash.sh` — blocks dangerous commands like `rm -rf /`
- **Config override**: `.mind/config.local.yaml.example` — personal preferences without affecting shared config

These work alongside the existing todo-app artifacts. The pipeline output
(PRD, techspec, tasks, review, QA) is unchanged from v0.1.0.

## How to produce similar artifacts

Install the MIND Framework in your project and tell your AI agent:

> Read MIND.md and create a PRD for [your feature].

See the [main README](../../README.md) for installation instructions
and [MIND.md](../../MIND.md) for the full framework index.
