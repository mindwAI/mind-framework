# Skills

Skills are project-specific playbooks that load automatically when your task
matches their trigger conditions. Unlike rules (which are always active),
skills load on demand to keep context lean.

## Structure

```
.mind/skills/
├── {skill-name}/
│   ├── SKILL.md       Frontmatter with triggers + overview
│   └── {content}.md   Playbook, checklist, runbook, etc.
```

## Trigger Mechanism

Each `SKILL.md` declares trigger conditions in frontmatter:

```yaml
triggers:
  keywords: [deploy, production, release]
  paths: [Dockerfile, .github/workflows/**]
```

Before starting a task, the agent scans all `SKILL.md` files. If the task
description contains any keyword OR the task modifies files matching any
path pattern, the agent loads that skill's full directory as context.

## When to Create a Skill vs a Rule

- **Rule**: always applies, short, about code conventions (naming, testing, style)
- **Skill**: loads on demand, longer, about procedures and decisions (deploy, migrate, respond to incidents)

See [docs/writing-skills.md](../../docs/writing-skills.md) for a step-by-step guide.
