#!/bin/zsh

typeset -g -A git_execute

git_execute[vim]=$(cat <<SHELL
vim -p
SHELL
)
