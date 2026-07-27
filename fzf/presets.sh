for file in $ZSHREP/fzf/preview-generation/*.sh; do source "$file"; done
for file in $ZSHREP/fzf/previews/*.sh; do source "$file"; done

fzfdefaults=(
  --style=full
  --ansi
  --wrap
  --freeze-left=10
  --preview-window="$(_set_window default wrap-word)"
  --bind='ctrl-up:preview-up'
  --bind='ctrl-down:preview-down'
  --bind='ctrl-page-up:preview-page-up'
  --bind='ctrl-page-down:preview-page-down'
)

bind_fileinfo() {
  # file --brief --mime '$1'
  ### 2% = 4.76 is difference between _set_window and real ratio
  ### 10 in __width is ceiling of 2% * 2
  filedirinfo=(
    --bind
    "focus:+transform-header:
    __path=$1
    __style=$2
    __width=\$(( \$FZF_COLUMNS - \$FZF_PREVIEW_COLUMNS - 10 ))
    [[ -n \$__style ]] && __fold_rule=spaces || __fold_rule=bytes
    file --\$__style \${~__path} \
    | fold \
      --\$__fold_rule \
      --width=\$__width
    "
  )
}

### bindexec is a different thing to try
bind_become() {
  local bin=$1 file=$2 arg=$3
  bindbecome=(
    --bind
    "enter:become($bin $file $arg)"
  )
}
