source $ZSHREP/fzf/presets.sh

fvim() {
  local file
  if [[ -n "$1" ]]; then file="$1"; else
  file=$(
    preview_bat "{}"; bind_fileinfo "{}" brief
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${filedirinfo[@]}"
  ) || return
  fi
  [[ -z "$file" ]] && return
  zsh_cmd=(
    "$(_get_editor)"
    "$file"
  )
  zsheval "${zsh_cmd[@]}"
}

cdf() {
  local dir
  if [[ -n "$1" ]]; then dir="$1"; else
  dir=$(
    preview_tree "{}"; bind_fileinfo "{}" brief
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${filedirinfo[@]}"
  ) || return
  fi
  zsh_cmd=(
    cd
    "$dir"
  )
  zsheval "${zsh_cmd[@]}"
}
