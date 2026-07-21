#!/bin/bash

get_editor() {
  local editor
  [[ -f "$(which nvim)" ]] && editor=nvim || editor=vim
  echo "$editor"
}

# options
fzstyle=(
  --style=full
  --preview-window='right,58%,wrap-word'
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
    "tree -C '$1' | head -500"
  )
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
    "bat $style --color=always '$1' | head -1000"
  )
}

preview_battree() {
  previewcmd=(
    --preview
    "test -d '$1' && tree -C '$1' | head -500 || bat --color=always '$1' | head -1000"
  )
}

# git
preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""

  case $gitcommand in
  diff)
    local revision=$4
    [[ -z "$revision" ]] && revision=$(git $repo_flag rev-parse --abbrev-ref --symbolic-full-name @{u}) #|| revision=HEAD
    local path=$3
    [[ -n "$revision" ]] && select="'$revision' -- '$path'" || select="$path"
    ;;
  show)
    local commit=$3
    select=$commit
    ;;
  esac

  previewcmd=(
    --preview
    "git $repo_flag $gitcommand --color=always --word-diff=color $select"
    --preview-window
    'right,67%,wrap-word'
  )
}
