#!/bin/sh
set -e

# MIND Framework — One-liner installer
# Usage: sh -c "$(curl -sL https://raw.githubusercontent.com/mindwai/mind-framework/main/setup.sh)"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading MIND Framework ..."
git clone --depth 1 --quiet https://github.com/mindwai/mind-framework.git "$TMPDIR/mind"

"$TMPDIR/mind/install.sh" "${1:-.}"
