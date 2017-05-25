#!/bin/zsh

source "${GIT_FZF}"/init.zsh

# if you are not in a git repository, the script ends here
git_root_dir="$(git rev-parse --show-toplevel)"
current_branch="$(git rev-parse --abbrev-ref head)"

git_filter=${git_filter:-fzy:fzf-tmux:fzf:peco}

filter="$(__git::get_filter "$git_filter")"
if [[ -z $filter ]]; then
    echo "no available filter in \$git_filter" >&2
    exit 1
fi

logfile="$git_root_dir/.git/logs/switch.log"
post_script="$git_root_dir/.git/hooks/post-checkout"

if [[ ! -x $post_script ]]; then
    cat <<hook >|"$post_script"
git rev-parse --abbrev-ref head >>$logfile
hook
    chmod 755 "$post_script"
fi

if [[ ! -f $logfile ]]; then
    touch "$logfile"
fi

candidates="$(
{
    cat "$logfile" \
        | __git::reverse \
        | __git::unique
    git branch -a --color \
        | cut -c3-
} \
    | __git::unique \
    | grep -v head \
    | grep -v "$current_branch" || true
    # ^ if the candidates is empty, grep return false
)"

if [[ -z $candidates ]]; then
    echo "no available branches to be checkouted" >&2
    exit 1
fi

selected_branch="$(echo "$candidates" | $filter)"
if [[ -z $selected_branch ]]; then
    exit 0
fi

git checkout "$selected_branch"
exit $?
