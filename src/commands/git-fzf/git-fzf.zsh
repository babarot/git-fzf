#!/bin/zsh

source "${GIT_FZF}"/init.zsh

fzf \
    --ansi \
    --preview="$git_preview[syntax]" \
    --bind "enter:execute-multi(vim -p {})" \
    "$@"
