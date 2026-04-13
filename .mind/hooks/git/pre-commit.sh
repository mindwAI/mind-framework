#!/bin/sh
# MIND Framework — pre-commit hook
# Blocks WIP/fixup commits on protected branches and debug statements in staged files.

BRANCH="$(git branch --show-current 2>/dev/null)"

# Block WIP/fixup on protected branches
case "$BRANCH" in
  main|master|develop)
    STAGED_MSG="$(git log -1 --format=%s 2>/dev/null || echo "")"
    case "$STAGED_MSG" in
      *WIP*|*wip*|*fixup*|*FIXUP*|*squash*|*SQUASH*)
        echo "ERROR: WIP/fixup/squash commits not allowed on $BRANCH"
        echo "Create a feature branch first: git checkout -b feature/your-change"
        exit 1
        ;;
    esac
    ;;
esac

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
