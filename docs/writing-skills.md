# Writing Skills

Skills are project-specific playbooks that load automatically when context
matches. They keep your AI agent's context lean — only loading what's relevant
to the current task.

## When to Create a Skill vs a Rule

| Use a Rule when... | Use a Skill when... |
|---------------------|---------------------|
| It applies to all code (naming, testing) | It applies to specific activities (deploy, migrate) |
| It's short (< 50 lines) | It's long (checklists, runbooks, decision trees) |
| It should always be in context | It should only load when relevant |
| It describes conventions | It describes procedures and decisions |

**Rule of thumb:** if you're describing *how code should look*, it's a rule.
If you're describing *what to do in a situation*, it's a skill.

## SKILL.md Anatomy

Every skill lives in `.mind/skills/{skill-name}/` with at least two files:

```yaml
# SKILL.md — frontmatter
---
name: Human-readable name
triggers:
  keywords: [word1, word2, word3]
  paths: [pattern/**, other-pattern/**]
---

# Brief description of when this skill activates
# and what the agent should load from this directory.
```

- **keywords**: the agent checks if the task description contains any of these
- **paths**: the agent checks if the task touches files matching these globs
- Either trigger is sufficient — a match on keyword OR path activates the skill

## Step-by-Step: Creating a Code Review Checklist Skill

1. Create the directory:
   ```
   mkdir -p .mind/skills/code-review-checklist
   ```

2. Write SKILL.md:
   ```yaml
   ---
   name: Code Review Checklist
   triggers:
     keywords: [review, code review, PR]
     paths: []
   ---
   # Activates when reviewing code. Load checklist.md for the review process.
   ```

3. Write the content file:
   ```
   # Code Review Checklist
   ## Before reviewing
   - [ ] Read the task/PR description
   - [ ] Understand what changed and why
   ...
   ```

4. Test: describe a task with "review" in the description and verify the agent
   loads the skill.

## Trigger Curation Tips

- **Be specific**: `[deploy, production, release]` is better than `[run, do, make]`
- **Avoid overlap**: if two skills trigger on the same keywords, the agent loads both — waste of context
- **Use paths for file-based triggers**: `[Dockerfile, docker-compose*]` is more precise than `[docker]` as a keyword
- **Empty paths is fine**: incident-response triggers on keywords only, no file paths
- **Test your triggers**: describe a hypothetical task and mentally check which skills would activate

## Testing a Skill

Ask your AI agent:

> I need to deploy the latest changes to production.

Then verify: did the agent load the deploy-to-production skill? Did it follow
the playbook steps? If not, check your keyword list.

## See Also

- [Skills README](../.mind/skills/README.md) — directory structure and trigger mechanism
- [Customization guide](customization.md) — adding rules, personas, and templates
