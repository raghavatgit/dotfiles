#!/usr/bin/env bash
# Safe Git Remote Upstream Rebase Synchronizer
# Fetches upstream changes and rebases current branch while preserving uncommitted work.

set -euo pipefail

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
UPSTREAM_REMOTE="upstream"

if ! git remote | grep -q "^${UPSTREAM_REMOTE}$"; then
    echo "Remote '${UPSTREAM_REMOTE}' not configured. Exiting."
    exit 1
fi

echo "Stashing working directory changes..."
STASHED=0
if ! git diff-index --quiet HEAD --; then
    git stash push -m "git-sync-auto-stash-$(date +%s)"
    STASHED=1
fi

echo "Fetching ${UPSTREAM_REMOTE}/${CURRENT_BRANCH}..."
git fetch "${UPSTREAM_REMOTE}" "${CURRENT_BRANCH}"

echo "Rebasing on ${UPSTREAM_REMOTE}/${CURRENT_BRANCH}..."
git rebase "${UPSTREAM_REMOTE}/${CURRENT_BRANCH}"

if [[ $STASHED -eq 1 ]]; then
    echo "Restoring stashed changes..."
    git stash pop
fi

echo "Repository synchronized successfully."
