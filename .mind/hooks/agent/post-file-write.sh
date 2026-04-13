#!/bin/sh
# MIND Framework — agent post-file-write hook
# Runs linter on the file just written. Agent calls: sh .mind/hooks/agent/post-file-write.sh "$FILE"
# Exit code from linter is informational — does not block the write.

FILE="$1"

if [ -z "$FILE" ]; then
  echo "Usage: sh post-file-write.sh \"path/to/file\""
  exit 0
fi

case "$FILE" in
  *.js|*.ts|*.jsx|*.tsx)
    if command -v npx >/dev/null 2>&1; then
      npx eslint --fix "$FILE" 2>/dev/null && echo "Linted: $FILE (eslint)"
    fi
    ;;
  *.py)
    if command -v ruff >/dev/null 2>&1; then
      ruff check --fix "$FILE" 2>/dev/null && echo "Linted: $FILE (ruff)"
    fi
    ;;
  *.go)
    if command -v gofmt >/dev/null 2>&1; then
      gofmt -w "$FILE" 2>/dev/null && echo "Formatted: $FILE (gofmt)"
    fi
    ;;
esac
