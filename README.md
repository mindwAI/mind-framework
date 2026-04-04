<p align="center">
  <strong>MIND Framework</strong>
</p>

<p align="center">
  Open-source methodology for AI-assisted software engineering.
</p>

<p align="center">
  <a href="CHANGELOG.md"><img src="https://img.shields.io/badge/version-0.0.1-blue" alt="version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache%202.0-green" alt="license"></a>
</p>

---

Structure your AI workflow with **personas**, **commands**, **rules**, and **templates**. Works with any agent — Claude Code, Cursor, Copilot, Codex, or any AI that reads markdown.

## What is this?

The MIND Framework is a set of markdown files that define how AI agents should work on software projects. Instead of ad-hoc prompting, you get a structured pipeline that guides the agent from requirements to tested code.

It solves three problems with unstructured AI-assisted development:

1. **Agents skip clarification** — they jump straight to code instead of understanding requirements
2. **Agents rationalize to approve** — code reviews and QA pass things that shouldn't pass
3. **Agents ignore project standards** — each session starts from zero without consistent conventions

## Quick Start

### 1. Copy `.mind/` to your project

```bash
git clone https://github.com/mindwai/mind-framework.git
cp -r mind-framework/.mind/ your-project/.mind/
```

### 2. Edit the config

```yaml
# your-project/.mind/config.yaml
project_name: "your-project"
language: "en"
```

### 3. Use with your AI agent

**With Claude Code:**

```
Read .mind/commands/create-prd.md and follow the instructions to create
a PRD for [describe your feature].

Adopt the persona in .mind/personas/product-owner.md.
Follow the rules in .mind/rules/.
Use the template in .mind/templates/prd-template.md.
```

**With Cursor / Copilot / any AI:**

Add to your system prompt or rules file:

```
Before working on any feature, read the relevant files in .mind/:
- .mind/personas/ for your role behavior
- .mind/commands/ for step-by-step instructions
- .mind/rules/ for project standards
- .mind/templates/ for output formats
```

## Pipeline

The framework defines an 8-step pipeline from requirements to tested code:

```
create-prd → clarify-prd → create-techspec → validate-spec → create-tasks → execute-task → execute-review → execute-qa
```

| Step | What it does | Persona |
|------|-------------|---------|
| `create-prd` | Specify product requirements | product-owner |
| `clarify-prd` | Resolve PRD ambiguities | product-owner |
| `create-techspec` | Design technical solution | senior-developer |
| `validate-spec` | Cross-validate PRD x TechSpec | qa-engineer |
| `create-tasks` | Decompose into incremental tasks | senior-developer |
| `execute-task` | Implement each task | senior-developer |
| `execute-review` | Review produced code | code-reviewer |
| `execute-qa` | Validate requirements and quality | qa-engineer |

You don't need to use all steps. Start with `execute-task` + `execute-review` for immediate value.

## Structure

```
.mind/
├── config.yaml              # Project configuration
├── personas/                # How each role behaves
│   ├── senior-developer.md
│   ├── code-reviewer.md
│   ├── qa-engineer.md
│   ├── tech-writer.md
│   └── product-owner.md
├── commands/                # What to do at each pipeline step
│   ├── create-prd.md
│   ├── clarify-prd.md
│   ├── create-techspec.md
│   ├── validate-spec.md
│   ├── create-tasks.md
│   ├── execute-task.md
│   ├── execute-review.md
│   └── execute-qa.md
├── rules/                   # Project standards and conventions
│   ├── code-standards.md
│   ├── git-branching.md
│   └── tests.md
└── templates/               # Artifact formats
    ├── prd-template.md
    ├── techspec-template.md
    ├── qa-checklist-template.md
    └── feature-template.md
```

## Key Concepts

### Personas

Personas define **how** the agent should behave in each role. They include operational principles, anti-patterns, and checklists — not just descriptions.

### Anti-Rationalization

The most important differentiator. LLMs tend to rationalize to approve — building justifications to say "yes". MIND personas for review and QA explicitly instruct:

> *"If you are building a justification to approve, that is a signal to reject."*

This combats the approval bias that makes unstructured AI code reviews unreliable.

### Rules as Guardrails

Rules are project standards that agents read dynamically. They're separate from commands because they change per project. The framework includes 3 starter rules (code standards, git branching, tests). Add your own for project-specific conventions.

### Templates

Templates ensure consistent artifact format. Every PRD follows the same structure. Every TechSpec covers the same dimensions. Every QA checklist checks the same foundations.

## Customization

### Add custom rules

Create new `.md` files in `.mind/rules/`:

```markdown
# API Standards

[Your project's API conventions...]
```

Reference them in `config.yaml`:

```yaml
conventions:
  - code-standards
  - git-branching
  - tests
  - api-standards  # your new rule
```

### Add custom personas

Create new `.md` files in `.mind/personas/` following the same format:

```yaml
---
name: security-reviewer
description: "Security review specialist..."
---
```

### Modify the pipeline

Edit `config.yaml` to add, remove, or reorder steps. Each step references a command file.

## Want More?

The MIND Framework is the open-source methodology layer. For teams that need enforcement, governance, and automation:

**[MIND-GO](https://mindwai.com)** adds:
- Pipeline engine with automatic step routing
- Adversarial QA with enforcement (no self-approval)
- Memory system for decisions, patterns, and learnings
- Hooks and lifecycle events
- Multi-agent orchestration

## Contributing

Contributions are welcome. Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-change`)
3. Make your changes
4. Submit a pull request

For major changes, open an issue first to discuss the approach.

## License

[Apache 2.0](LICENSE) — use it freely in personal and commercial projects.

---

<p align="center">Made in Brazil 🇧🇷</p>
