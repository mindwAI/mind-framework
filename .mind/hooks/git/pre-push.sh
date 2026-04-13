#!/bin/sh
# MIND Framework — pre-push hook
# Runs test suite before push. Detects stack automatically.

if [ -f package.json ]; then
  echo "Running: npm test"
  npm test || { echo "ERROR: Tests failed. Push aborted."; exit 1; }
elif [ -f go.mod ]; then
  echo "Running: go test ./..."
  go test ./... || { echo "ERROR: Tests failed. Push aborted."; exit 1; }
elif [ -f pyproject.toml ] || [ -f setup.py ]; then
  echo "Running: pytest"
  pytest || { echo "ERROR: Tests failed. Push aborted."; exit 1; }
else
  echo "No test runner detected. Skipping pre-push tests."
fi
