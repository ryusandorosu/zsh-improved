source $ZSHREP/common/fzf/presets.sh

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  [[ -z "$file" ]] && return
  command "$(get_editor)" "$file"
}

cdf() {
  local dir=$(
    preview_tree "{}"; bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  cd "$dir"
}

ffind() {
  preview_battree "{}"; bind_fileinfo "{}"
  fd . '/' | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      "${previewcmd[@]}"
}

lfind() {
  preview_battree "{}"; bind_fileinfo "{}"
  locate -b . | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      "${previewcmd[@]}"
}

neovim() {
  preview_bat "{}"; bind_fileinfo "{}"; bind_exec nvim "{}"
  cmd=(
    locate
    -b
    .
  )
  "${cmd[@]}" \
  | fzf "${fzstyle[@]}" \
        "${previewcmd[@]}" \
        "${briefinfo[@]}" \
        "${bindexec[@]}"
}
