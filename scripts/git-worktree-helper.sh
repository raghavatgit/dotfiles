#!/usr/bin/env bash
# Git Worktree Multi-Branch Workspace Manager
# Facilitates isolated branch checkout directories without switching working trees.

set -euo pipefail

worktree_create() {
    local branch="$1"
    local target_dir="../worktrees/${branch//\//-}"
    echo "Creating worktree for branch '${branch}' at '${target_dir}'..."
    git worktree add -b "${branch}" "${target_dir}" main
}

worktree_list() {
    git worktree list
}

worktree_clean() {
    echo "Pruning stale worktrees..."
    git worktree prune -v
}

case "${1:-}" in
    add) worktree_create "${2:?Branch name required}" ;;
    list) worktree_list ;;
    clean) worktree_clean ;;
    *) echo "Usage: $0 {add <branch>|list|clean}" ;;
esac
