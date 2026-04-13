# Customizing the MIND Framework

The framework ships with sensible defaults: 5 personas, 8 commands, 3 rules,
and 4 templates. You can extend or modify all of them to match your project.

After any change, run `./install.sh --update` to regenerate MIND.md with your
new content reflected in the index.

## Adding a Rule

Rules live in `.mind/rules/`. Create a new markdown file:

```markdown
# API Standards

All REST endpoints must:

- Return JSON with consistent `{ "data": ... }` or `{ "error": "..." }` envelope
- Use HTTP status codes correctly (201 for creation, 404 for not found)
- Include request validation before any business logic
- Document request/response schemas in the TechSpec
```

Then add it to `.mind/config.yaml`:

```yaml
conventions:
  - code-standards
  - git-branching
  - tests
  - api-standards    # your new rule
```

Run `./install.sh --update` to add it to MIND.md.

## Adding a Pipeline Step

Edit `.mind/config.yaml` to add, remove, or reorder steps:

```yaml
pipeline:
  - name: create-prd
    description: "Specify product requirements"
  - name: security-review           # new step
    description: "Review for security vulnerabilities"
    optional: true
  - name: create-techspec
    description: "Design technical solution"
  # ... rest of pipeline
```

Create the matching command file at `.mind/commands/security-review.md` with
the step instructions. Follow the format of existing commands — each has a
recommended persona, process steps, and a quality checklist.

## Adding a Template

Templates live in `.mind/templates/`. Create a markdown file with placeholder
sections that commands will fill in:

```markdown
# Security Review Report — [Feature Name]

## Threat Model
[Identify attack vectors relevant to this feature]

## Findings
| # | Severity | Description | Mitigation |
|---|----------|-------------|------------|

## Verdict: [PASS / FAIL]
```

Reference it from your command file: "Use the template in
`.mind/templates/security-review-template.md`."

## Modifying Existing Content

You can edit any file in `.mind/` directly:

- **Personas** — adjust principles, add anti-patterns, change checklists
- **Commands** — modify process steps, add quality checks
- **Rules** — tighten or relax standards for your project
- **Templates** — add sections, change format

The framework treats `.mind/` as your project's source of truth. There is no
external server or database — everything is in these files.

## Common Mistakes

- **Forgetting to run `./install.sh --update`** after adding personas, rules,
  or commands. MIND.md will be stale until regenerated.
- **Breaking YAML frontmatter** in persona files. The `name` and `description`
  fields must be present:
  ```yaml
  ---
  name: your-persona-name
  description: "One-line description of what this persona does"
  ---
  ```
- **Putting implementation details in rules.** Rules should say *what* to do,
  not *how*. "Functions must be under 50 lines" is a rule. "Use the
  extractMethod refactoring pattern" is implementation guidance.
- **Creating commands without a quality checklist.** Every command should end
  with a checklist so the agent can self-verify before reporting completion.

## Personal Overrides

Create `.mind/config.local.yaml` to override shared settings without affecting
your team. This file is gitignored by default.

Copy from the example:
```bash
cp .mind/config.local.yaml.example .mind/config.local.yaml
```

Then uncomment and modify the settings you want to override. The agent reads
both files — `config.local.yaml` wins on key conflicts.

Common overrides: language preference, shorter pipeline for personal workflow,
additional conventions.

## Scoped Rules

Rules can target specific file paths using the `scope` field in frontmatter:

```yaml
---
name: typescript
description: "TypeScript conventions for frontend code"
scope: "apps/web/**"
---
```

- `scope: "apps/web/**"` — applies only when modifying files under `apps/web/`
- No `scope` field — applies globally (backward compatible with v0.1.0 rules)
- Glob patterns: `**` matches any depth, `*` matches a single path segment

The agent checks each rule's scope before applying it. Rules without scope
always apply. Run `./install.sh --update` after adding scoped rules to
regenerate MIND.md.

## See Also

- [Writing Personas](writing-personas.md) — detailed guide for creating new personas
- [Writing Skills](writing-skills.md) — guide for creating auto-triggered playbooks
- [MIND.md](../MIND.md) — the agent index (auto-generated)
