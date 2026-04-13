#!/bin/sh
# MIND Framework — Git Hook Installer
# Creates symlinks from .mind/hooks/git/*.sh to .git/hooks/*

HOOKS_DIR=".mind/hooks/git"
GIT_HOOKS=".git/hooks"

if [ ! -d "$GIT_HOOKS" ]; then
  echo "Error: not a git repository (no .git/hooks/ found)"
  exit 1
fi

if [ ! -d "$HOOKS_DIR" ]; then
  echo "Error: no hooks found at $HOOKS_DIR"
  exit 1
fi

for hook in "$HOOKS_DIR"/*.sh; do
  [ -f "$hook" ] || continue
  name="$(basename "$hook" .sh)"
  ln -sf "../../$hook" "$GIT_HOOKS/$name"
  chmod +x "$GIT_HOOKS/$name"
  echo "Linked: $name -> $hook"
done

echo "Git hooks installed. They will run automatically on git operations."
