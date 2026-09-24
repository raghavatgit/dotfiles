#!/usr/bin/env bash
# Fast Interactive Directory Navigation with fzf

j() {
    local dir
    dir=$(find . -maxdepth 3 -type d 2>/dev/null | fzf --height 40% --reverse --prompt='Jump to: ')
    if [ -n "$dir" ]; then
        cd "$dir" || return
    fi
}

fh() {
    local cmd
    cmd=$(fc -l 1 | awk '{$1=""; print substr($0,2)}' | fzf --height 50% --reverse --tac --prompt='History: ')
    if [ -n "$cmd" ]; then
        print -z "$cmd"
    fi
}
