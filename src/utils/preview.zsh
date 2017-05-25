#!/bin/zsh

typeset -g -A git_preview

git_preview[syntax]=$(cat <<SHELL
if file {} | grep -q text; then
    if type highlight &>/dev/null; then
        highlight -O ansi -l {} 2>/dev/null
    elif type pygmentize &>/dev/null; then
        pygmentize -g {} 2>/dev/null
    else
        cat {}
    fi | less -R -X
else
    file {}
fi
SHELL
)
