# Hooks

The MIND Framework uses a hybrid hook architecture with two types:

| Aspect | git/ hooks | agent/ hooks |
|--------|-----------|-------------|
| **Invoked by** | Git runtime (automatic) | AI agent (convention) |
| **Enforcement** | Real — blocks the git operation | Advisory — agent should respect, but can ignore |
| **Works without AI** | Yes — any git user triggers them | No — only AI agents call them |
| **Install** | Symlinked to .git/hooks/ via install-git-hooks.sh | Agent reads MIND.md instructions |
| **When to use** | Commit validation, push gates | Pre-bash safety, task completion gates, linting |

## Exit Code Contract

All hooks follow the same contract:

- **Exit 0**: OK, proceed with the action
- **Exit non-zero**: abort the action, print error message to stdout/stderr

## Git Hooks (real enforcement)

Scripts in `.mind/hooks/git/` are symlinked to `.git/hooks/` and run
automatically by git. They work regardless of which AI tool you use.

- `pre-commit.sh` — blocks WIP commits and debug statements
- `commit-msg.sh` — validates conventional commit format
- `pre-push.sh` — runs test suite before push

To enable: `sh .mind/install-git-hooks.sh`

## Agent Hooks (convention)

Scripts in `.mind/hooks/agent/` are called by the AI agent before/after
events. They provide safety checks that git hooks cannot cover.

- `pre-bash.sh "$CMD"` — blocks dangerous shell commands
- `pre-task-complete.sh` — validates tests pass before marking done
- `post-file-write.sh "$FILE"` — runs linter on written file

The agent is instructed via MIND.md to call these hooks. This is
convention, not enforcement — the agent can technically skip them.
