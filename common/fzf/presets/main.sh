source $ZSHREP/common/fzf/presets/previews/filedirs.sh
source $ZSHREP/common/fzf/presets/previews/git.sh

get_editor() {
  local editor
  [[ -f "$(which nvim)" ]] && editor=nvim || editor=vim
  echo "$editor"
}

# options
fzfdefaults=(
  --style=full
  --preview-window='right,58%,wrap-word'
  --bind='ctrl-up:preview-up'
  --bind='ctrl-down:preview-down'
  --bind='ctrl-page-up:preview-page-up'
  --bind='ctrl-page-down:preview-page-down'
)

# binds
bind_fileinfo() {
  # file --brief --mime '$1'
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
