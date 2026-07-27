for file in $ZSHREP/fzf/previews/*.sh; do source "$file"; done

_default_preview_width=58

# options
fzfdefaults=(
  --style=full
  --ansi
  --wrap
  --freeze-left=10
  --preview-window="${_default_preview_width}%,wrap-word"
  --bind='ctrl-up:preview-up'
  --bind='ctrl-down:preview-down'
  --bind='ctrl-page-up:preview-page-up'
  --bind='ctrl-page-down:preview-page-down'
)

# binds
bind_fileinfo() {
  # file --brief --mime '$1'
  filedirinfo=(
    --bind
    "focus:+transform-header:
    __path=$1
    __style=$2
    __width=\$(( \$FZF_COLUMNS * (100 - $preview_width - 3 ) / 100 ))
    [[ -n \$__style ]] && __fold_rule=spaces || __fold_rule=bytes
    file --\$__style \${~__path} \
    | fold \
      --\$__fold_rule \
      --width=\$__width
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
