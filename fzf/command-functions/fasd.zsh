source $ZSHREP/fzf/presets/main.sh

fvim() {
  local file
  if [[ -n "$1" ]]; then file="$1"; else
  file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
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
    preview_tree "{}"; bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  fi
  zsh_cmd=(
    cd
    "$dir"
  )
  zsheval "${zsh_cmd[@]}"
}
