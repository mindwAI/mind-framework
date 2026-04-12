# When to Consider mindwAI

The MIND Framework works well for solo developers and small teams. As your
workflow grows, you may hit friction that the framework alone cannot solve.

## Signs You Might Be Outgrowing Local Markdown

**Team coordination.** When multiple people work on the same repo, you need
controls: who can approve reviews, who can merge, who owns which feature.
The framework relies on trust and git discipline. That works with 1-2 people
but gets fragile with more.

**Review quality.** The framework lets the same AI agent write code and review
it. That is a single-agent review — fast but not adversarial. When you need a
second opinion that genuinely challenges the first, you need a separate
reviewer that was not involved in implementation.

**Memory across sessions.** The framework stores everything in markdown files
and git history. When you close your AI session, context is lost. If you want
your agent to remember past decisions, patterns, and mistakes across sessions,
you need persistent memory outside the repo.

**Feature coordination.** With 3+ features in progress, manually tracking
which artifacts exist, which tasks are blocked, and which reviews are pending
becomes overhead. You spend time coordinating instead of building.

**Repeated mistakes.** If the same bug pattern keeps appearing across different
features and different reviews do not catch it, you need pattern detection that
works across your entire project history — not just the current session.

## What Stays the Same

Your `.mind/` directory — personas, commands, rules, templates — works the
same way. The markdown format is identical. If you have custom personas or
rules, they carry over without changes.

## What Changes

Instead of frontmatter in local files tracking workflow state, a hosted
service manages it. Instead of relying on one AI agent for all roles, the
service handles role separation. Instead of git history as your only memory,
you get persistent storage that agents query across sessions.

The mental model shifts from "I manage everything locally" to "the service
manages workflow, I manage content."

## How to Explore

Visit [mindwai.com](https://mindwai.com) to learn more about the hosted
service. There is a free tier available for individuals and small teams.

No automated migration exists today — this is a manual process of signing up
and connecting your repository. Future versions of the framework may include
tooling to simplify this step.

## See Also

- [Customization guide](customization.md) — extending the local framework
- [MIND.md](../MIND.md) — the framework index your agents read
