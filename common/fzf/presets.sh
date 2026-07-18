#!/bin/bash

get_editor() {
  local editor
  [[ -f "$(which nvim)" ]] && editor=nvim || editor=vim
  echo "$editor"
}

# options
fzstyle=(
  --style=full
)

# binds
bind_fileinfo() {
  briefinfo=(
    --bind
    "focus:+transform-header:file --brief $1"
  )
}

bind_exec() {
  bindexec=(
    --bind
    "enter:become($1 $2)"
  )
}

# previews
tree_view=(
  --preview
  'tree -C {} | head -200'
)
# -L 2

preview_bat() {
  local style
  if [[ -n "$2" && "$2" == git ]]; then 
    style="--style=changes,numbers"
  else
    style=""
  fi
  previef=(
    --preview
    "bat $style --color=always $1"
  )
}

preview_battree() {
  previef=(
    --preview
    "test -d $1 && tree -C $1 | head -200 || bat --color=always $1"
  )
}

git_diff_view() {
  local repo_root
  [[ -n "$1" ]] && repo_root="-C $1" || repo_root=""
  previef=(
    --preview
    "git $repo_root diff --color=always --word-diff=color $2"
  )
}
