source $ZSHREP/fzf/presets.sh

# rename to fdf?
ffind() {
  local pattern
  [[ -z "$1" ]] && pattern="." || pattern="$1"

  cmd=(
    fd
    --color
    always
    --one-file-system
    --follow
    --hidden
    "$pattern"
    '/'
  )

  preview_battree "{}" header
  bind_fileinfo "{}" brief
  "${cmd[@]}" \
  | fzf \
    --multi \
    --prompt "fd> " \
    "${fzfdefaults[@]}" \
    "${filedirinfo[@]}" \
    "${previewcmd[@]}"
}

lfind() {
  local pattern
  [[ -z "$1" ]] && pattern="." || pattern="$1"

  cmd=(
    locate
    --basename
    "$pattern"
  )
  [[ "$OS_ID" == ubuntu ]] && cmd+=(--ignore-spaces)

  preview_battree "{}" header
  bind_fileinfo "{}" brief
  "${cmd[@]}" \
  | fzf \
    --multi \
    --prompt "locate> " \
    "${fzfdefaults[@]}" \
    "${filedirinfo[@]}" \
    "${previewcmd[@]}"
}
