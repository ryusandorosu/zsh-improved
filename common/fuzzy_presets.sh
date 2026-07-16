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
bind_exec() {
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
    "batcat --style=changes --color=always $1"
  )
}
bat_view_git_escaped() {
  bat_view=(
    --preview
    \'batcat --style=changes --color=always $1\'
  )
}
