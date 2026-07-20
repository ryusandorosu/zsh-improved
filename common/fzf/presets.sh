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
  # --brief may be replaced with: --mime or something like this, possibly in preview when bat cannot render file content
  briefinfo=(
    --bind
    "focus:+transform-header:file --brief '$1'"
  )
}

bind_exec() {
  bindexec=(
    --bind
    "enter:become($1 $2)"
  )
}

# previews
preview_tree() {
  previewcmd=(
    --preview
    "tree -C '$1' | head -200"
  )
  # -L 2
}

preview_bat() {
  local style
  if [[ -n "$2" && "$2" == git ]]; then 
    style="--style=changes,numbers"
  else
    style=""
  fi
  previewcmd=(
    --preview
    "bat $style --color=always '$1'"
  )
}

preview_battree() {
  previewcmd=(
    --preview
    "test -d '$1' && tree -C '$1' | head -200 || bat --color=always '$1'"
  )
}

# git
git_diff_preview() {
  local repo_root=$1
  local selected=$2
  local revision=$3
  local repo_flag
  local path

  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""
  [[ -z "$revision" ]] && revision=$(git $repo_flag rev-parse --abbrev-ref --symbolic-full-name @{u}) #|| revision=HEAD
  [[ -n "$revision" ]] && path="'$revision' -- '$selected'" || path="$selected"

  previewcmd=(
    --preview
    "git $repo_flag diff --color=always --word-diff=color $path"
  )
}
