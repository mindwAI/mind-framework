# Writing Personas

Personas define **how** an AI agent behaves in a specific role. A good persona
is instructive, not descriptive — it tells the agent what to do, not what it is.

## Anatomy of a Persona

Every persona file in `.mind/personas/` follows this structure:

```markdown
---
name: persona-name
description: "One-line description for MIND.md index"
---

## Persona
[2-3 sentences: role, expertise, core behavior]

## How You Work
[Numbered steps the agent follows when this persona is active]

## Non-Negotiable Principles
[Bullet list of rules this persona never breaks]

## Anti-Rationalization (optional)
[For review/QA roles — instructions to combat approval bias]

## References
[Links to relevant .mind/rules/ files]
```

## Example: Creating a Security Reviewer

### Step 1 — Define the role

```markdown
## Persona

You are a Security Review Specialist. You evaluate code changes for
vulnerabilities, injection risks, and authentication/authorization gaps.

You think about **attack surface** before thinking about functionality.
```

### Step 2 — Define the workflow

```markdown
## How You Work

1. Read the task and identify what user input touches
2. Map data flow from input to storage to output
3. Check for OWASP Top 10 vulnerabilities at each boundary
4. Verify authentication and authorization on every endpoint
5. Check for secrets, hardcoded credentials, and insecure defaults
6. Emit verdict with findings
```

### Step 3 — Add principles

```markdown
## Non-Negotiable Principles

- Every user input is untrusted until validated
- Authentication checks happen before any business logic
- Secrets never appear in code, logs, or error messages
- SQL queries use parameterized statements, never string concatenation
- File paths from user input are sanitized against traversal
```

### Step 4 — Add anti-rationalization (for review roles)

This section combats the tendency of AI agents to approve things they
should reject. Include it for any persona that makes pass/fail decisions:

```markdown
## Anti-Rationalization

<critical>
- If you are building a justification to approve, that is a signal to reject.
- List ALL problems before listing positives.
- The cost of a missed vulnerability in production is orders of magnitude
  higher than the cost of a false positive in review.
</critical>
```

### Step 5 — Test it

Ask your AI agent to adopt the persona and review a recent change:

> Adopt the persona in .mind/personas/security-reviewer.md and review
> the changes in the last commit.

Observe whether the agent follows the workflow steps, applies the principles,
and catches real issues rather than generating generic approval.

## Tips

- **Be specific.** "Check for injection" is weak. "Verify that all SQL
  queries use parameterized statements" is actionable.
- **Include anti-patterns.** Telling the agent what NOT to do is as valuable
  as telling it what to do.
- **Reference rules.** Link to `.mind/rules/` files so the persona reads
  project standards dynamically rather than hardcoding them.
- **Keep it under 80 lines.** Long personas get diluted in context. If yours
  is growing, split responsibilities into two personas.

## See Also

- Existing personas in [.mind/personas/](../.mind/personas/) for reference
- [Customization guide](customization.md) for adding personas to the framework
