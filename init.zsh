#!/bin/zsh

typeset -gx GIT_FZF
typeset -gx FZF_DEFAULT_OPTS
typeset -ga fzf_options

GIT_FZF="${0:A:h}"

fzf_options=(
"--bind 'ctrl-i:toggle-out'"
"--bind 'down:preview-down,up:preview-up'"
"--bind 'ctrl-y:execute(printf {} | pbcopy)'"
"--bind '?:toggle-preview'"
)

FZF_DEFAULT_OPTS="${fzf_options[@]}"

# load all zsh libraries
for f in "${0:A:h}"/src/utils/*.zsh(N-.)
do
    source "$f"
done
unset f 2>/dev/null
