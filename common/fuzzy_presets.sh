#!/bin/bash

# options
fzstyle=(
  --style=full
)

# binds
bind_fileinfo=(
  --bind
  'focus:+transform-header:file --brief {}'
)

bind_fileinfo_escaped() {
  file_brief=(
    --bind
    \'focus:+transform-header:file --brief "$1"\'
  )
}

bind_exec() {
  enter_become=(
    --bind
    "enter:become("$1" "$2")"
  )
}
bind_exec_escaped() {
  enter_become=(
    --bind
    \'enter:become\("$1" "$2"\)\'
  )
}

# previews
tree_view=(
  --preview
  'tree -C {} | head -200'
)

bat_view_simple() {
  bat_view=(
    --preview
    "batcat --color=always $1"
  )
}

bat_view_git() {
  bat_view=(
    --preview
    "batcat --style=changes,numbers --color=always $1"
  )
}
bat_view_git_escaped() {
  bat_view=(
    --preview
    \'batcat --style=changes,numbers --color=always $1\'
  )
}

git_diff_view() {
  [[ -n "$1" ]] && local repo_root="-C $1" || local repo_root=""
  bat_view=(
    --preview
    \'git $repo_root diff --color=always --word-diff=color $2\'
  )
}
