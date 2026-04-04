# MIND Framework

> Open-source methodology for AI-assisted software engineering.

## What It Is

The MIND Framework is a set of markdown files that structure how AI agents should work on software projects. It defines **personas** (who does it), **commands** (what to do), **rules** (how to do it), and **templates** (in what format).

Works with any AI agent: Claude Code, Cursor, Copilot, Codex, or any other that accepts markdown context.

## Philosophy

AI-assisted software engineering needs structure. Without it, AI agents:
- Skip clarification steps and write code from ambiguous requirements
- Approve reviews without rigor (rationalize to approve)
- Ignore edge cases and meaningful tests
- Don't follow project standards consistently

The MIND Framework solves this with:
1. **Structured pipeline** — ordered steps that guide the agent from requirement to code
2. **Specialized personas** — behaviors and principles per role (dev, reviewer, QA)
3. **Anti-rationalization** — explicit instructions to combat the LLM approval bias
4. **Rules as guardrails** — project standards the agent reads dynamically

## Pipeline

The MIND Framework defines an 8-step pipeline that covers the full lifecycle of a feature:

```
create-prd → clarify-prd → create-techspec → validate-spec → create-tasks → execute-task → execute-review → execute-qa
```

Each step is a **command** — a markdown file with detailed instructions on what to do, how to do it, and a quality checklist. Steps marked as optional can be skipped without breaking the flow.

| Step | What It Does | Persona |
|------|-------------|---------|
| `create-prd` | Specify product requirements | product-owner |
| `clarify-prd` | Resolve PRD ambiguities | product-owner |
| `create-techspec` | Design technical solution | senior-developer |
| `validate-spec` | Cross-validate PRD x TechSpec | qa-engineer |
| `create-tasks` | Decompose into incremental tasks | senior-developer |
| `execute-task` | Implement each task | senior-developer |
| `execute-review` | Review produced code | code-reviewer |
| `execute-qa` | Validate requirements and quality | qa-engineer |

## Personas

Personas define **how** the agent should behave in each role. They are not just descriptions — they are operational instructions with principles, anti-patterns, and checklists.

| Persona | Role | Differentiator |
|---------|------|---------------|
| `senior-developer` | Implementation | Resilience first, non-negotiable principles |
| `code-reviewer` | Review | Anti-rationalization, dynamic rule reading |
| `qa-engineer` | Adversarial QA | Anti-rationalization, structured verdicts |
| `tech-writer` | Documentation | Consolidates artifacts, zero invention |
| `product-owner` | Requirements | Never assumes, always clarifies |

### Anti-Rationalization

The most important differentiator in the review and QA personas. LLMs tend to rationalize to approve — building justifications to say "yes". MIND Framework personas explicitly instruct:

> *"If you are building a justification to approve, that is a signal to reject."*

## Rules

Rules are project standards that agents read dynamically. They are separate from commands because they change per project — each team has its own conventions.

The framework includes 3 starter rules:
- `code-standards` — naming, size, nesting, side effects
- `git-branching` — Gitflow, branch naming, merge flow
- `tests` — AAA/GWT, anti-patterns, coverage, assertions

Add your own rules to cover project-specific standards.

## Templates

Templates define the format of artifacts produced by the pipeline:
- `prd-template` — Product Requirements Document format
- `techspec-template` — Technical Specification format
- `qa-checklist-template` — QA checklist per task
- `feature-template` — Feature definition format

## Directory Structure

```
.mind/
├── config.yaml          ← Project configuration
├── personas/            ← How each role behaves
├── commands/            ← What to do at each pipeline step
├── rules/               ← Project standards and conventions
└── templates/           ← Artifact formats
```

## Quick Start

### 1. Copy `.mind/` to your project

```bash
cp -r mind-framework/.mind/ your-project/.mind/
```

### 2. Edit `config.yaml`

```yaml
project_name: "my-project"
language: "en"
```

### 3. Use with your AI agent

Paste a command's content as a prompt:

```
Read the file .mind/commands/create-prd.md and follow the instructions
to create a PRD for [describe the feature].

Adopt the persona described in .mind/personas/product-owner.md.
Follow the rules in .mind/rules/.
Use the template in .mind/templates/prd-template.md.
```

The agent will follow the structured flow: clarify before writing, use the template, respect the rules.

## Design Principles

1. **Markdown-first** — everything is `.md` files that any AI can read
2. **Agent-agnostic** — works with any AI that accepts markdown context
3. **Stack-agnostic** — rules and personas are generic by default, customizable per project
4. **Pipeline-driven** — ordered steps > loose instructions
5. **Anti-rationalization** — combating approval bias is a feature, not a bug
