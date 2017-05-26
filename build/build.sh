#!/bin/bash

top="$(cd "$(dirname $0)/.." && pwd)"
mkdir -p "$top/bin"

for file in $top/src/commands/git-*/git-*
do
    ln -snf "$file" "$top/bin/${file##*/}"
done
