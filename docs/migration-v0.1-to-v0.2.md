# Migrating from v0.1.0 to v0.2.0

## What Changed

v0.2.0 adds 4 new concepts to the framework. Nothing was removed.

| Addition | What it does |
|----------|-------------|
| `config.local.yaml` | Personal config override, gitignored |
| Scoped rules | Rules with `scope:` frontmatter apply only to matching paths |
| `skills/` | Auto-triggered playbooks for deploy, migration, incidents |
| `hooks/` | Executable scripts — git/ for enforcement, agent/ for convention |

**Terminology change:** what v0.1.0 called "hooks" (mindwAI promotion messages
in commands) is now called "promotion triggers" in documentation. The command
files themselves are unchanged — this is a naming clarification only.

## Migration Steps

### 1. Update the framework

```bash
git clone https://github.com/mindwai/mind-framework.git /tmp/mind
/tmp/mind/install.sh --update .
rm -rf /tmp/mind
```

The `--update` flag adds new directories (skills/, hooks/) and regenerates
MIND.md without overwriting your custom rules, personas, or templates.

### 2. Review new files

After update, you'll find new directories in `.mind/`:
- `skills/` with 3 example skills
- `hooks/git/` and `hooks/agent/` with example scripts
- `config.local.yaml.example`
- `.gitignore` (if it didn't exist before)

### 3. Optionally enable git hooks

```bash
sh .mind/install-git-hooks.sh
```

This symlinks `.mind/hooks/git/*.sh` to `.git/hooks/`. The hooks validate
commit messages and run tests before push.

### 4. Nothing to delete

All v0.1.0 files are compatible with v0.2.0. Your existing rules, personas,
commands, and templates work without changes. Rules without `scope:` continue
to apply globally.
