#!/usr/bin/env bash
# Interactive TMUX Sessionizer
# Quickly navigates and spawns persistent tmux development sessions for git repositories.

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/workspace ~/projects ~/code -mindepth 1 -maxdepth 2 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux || true)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

if [[ -z $TMUX ]]; then
    tmux attach -t "$selected_name"
else
    tmux switch-client -t "$selected_name"
fi
