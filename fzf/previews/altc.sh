#!/usr/bin/env zsh
source $ZSHREP/fzf/preview-generation/runtime.sh
test -n "$1" && eval "$(_cmd_tree "$1")"
