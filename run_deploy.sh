#!/usr/bin/env bash
set -euo pipefail

MSG="${1:-"update: $(date +'%Y-%m-%d %H:%M:%S')"}"

BRANCH="$(git branch --show-current)"

echo "▶ Pull latest (rebase)"
git pull --rebase origin "$BRANCH" || true

echo "▶ Add changes"
git add -A

if git diff --cached --quiet; then
  echo "No changes to commit. ✅"
  exit 0
fi

echo "▶ Commit"
git commit -m "$MSG"

echo "▶ Push"
git push origin "$BRANCH"

echo "Done 🚀 "
echo "🐢 Fast and furious"
