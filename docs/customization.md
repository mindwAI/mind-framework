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

## See Also

- [Writing Personas](writing-personas.md) — detailed guide for creating new personas
- [MIND.md](../MIND.md) — the agent index (auto-generated)
