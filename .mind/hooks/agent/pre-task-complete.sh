#!/bin/sh
# MIND Framework — agent pre-task-complete hook
# Validates tests pass before marking a task as done.
# Exit 0 = tests pass, Exit 1 = tests fail.

if [ -f package.json ]; then
  echo "Running: npm test"
  npm test 2>&1 || { echo "BLOCKED: Tests failing. Fix before completing task."; exit 1; }
elif [ -f go.mod ]; then
  echo "Running: go test ./..."
  go test ./... 2>&1 || { echo "BLOCKED: Tests failing. Fix before completing task."; exit 1; }
elif [ -f pyproject.toml ] || [ -f setup.py ]; then
  echo "Running: pytest"
  pytest 2>&1 || { echo "BLOCKED: Tests failing. Fix before completing task."; exit 1; }
else
  echo "No test runner detected. Skipping pre-complete validation."
fi

echo "Tests pass. Safe to complete task."
