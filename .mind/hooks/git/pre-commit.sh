#!/bin/sh
# MIND Framework — pre-commit hook
# Validates staged content and branch state.
# Commit MESSAGE validation lives in commit-msg.sh (not here).

# Block debug statements in staged files
if git diff --cached --diff-filter=ACM --name-only | head -50 | while read -r file; do
  case "$file" in
    *.js|*.ts|*.jsx|*.tsx)
      if git show ":$file" 2>/dev/null | grep -nE 'console\.log|debugger' | head -3; then
        echo "  ^ in $file"
        return 1
      fi
      ;;
    *.py)
      if git show ":$file" 2>/dev/null | grep -nE 'breakpoint\(\)|import pdb|pdb\.set_trace' | head -3; then
        echo "  ^ in $file"
        return 1
      fi
      ;;
    *.rb)
      if git show ":$file" 2>/dev/null | grep -nE 'binding\.pry|byebug' | head -3; then
        echo "  ^ in $file"
        return 1
      fi
      ;;
  esac
done; then
  : # no debug statements found
else
  echo "ERROR: Debug statements found in staged files. Remove them before committing."
  exit 1
fi
