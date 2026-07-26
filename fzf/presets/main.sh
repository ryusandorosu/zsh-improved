for file in $ZSHREP/fzf/presets/*/*.sh; do source "$file"; done

# options
fzfdefaults=(
  --ansi
  --freeze-left=10
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
    "focus:+transform-header:
    __path=$1
    file --brief \${~__path}
    "
  )
}

#bindbecome. bindexec is a different thing to try
bind_exec() {
  local bin=$1 file=$2 arg=$3
  bindexec=(
    --bind
    "enter:become($bin $file $arg)"
  )
}

_get_editor() {
  local editor
  [[ -f "$(which nvim)" ]] && editor=nvim || editor=vim
  echo "$editor"
}
