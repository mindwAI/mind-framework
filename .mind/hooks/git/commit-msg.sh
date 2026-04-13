#!/bin/sh
# MIND Framework — commit-msg hook
# Validates conventional commit format: type(scope): description

MSG_FILE="$1"
MSG="$(head -1 "$MSG_FILE")"

# Allow merge commits
case "$MSG" in
  Merge*) exit 0 ;;
esac

if ! echo "$MSG" | grep -qE '^(feat|fix|chore|docs|style|refactor|test|ci|perf|build|revert)(\(.+\))?: .{3,}'; then
  echo "ERROR: Commit message must follow conventional commits format."
  echo ""
  echo "  Format: type(scope): description"
  echo "  Types:  feat, fix, chore, docs, style, refactor, test, ci, perf, build, revert"
  echo "  Example: feat(auth): add login endpoint"
  echo ""
  echo "  Your message: $MSG"
  exit 1
fi
