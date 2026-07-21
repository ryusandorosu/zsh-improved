source $ZSHREP/fzf/presets/main.sh

[[ $(alias lah) ]] && unalias lah
lah() { command /usr/bin/ls -laAh "$@"; }
alias lah='lah --color=tty'

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  [[ -z "$file" ]] && return
  command "$(_get_editor)" "$file"
}

cdf() {
  local dir=$(
    preview_tree "{}"; bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  cd "$dir"
}

ffind() {
  preview_battree "{}"; bind_fileinfo "{}"
  fd . '/' | \
  fzf "${fzfdefaults[@]}" \
      "${briefinfo[@]}" \
      "${previewcmd[@]}"
}

lfind() {
  preview_battree "{}"; bind_fileinfo "{}"
  locate -b . | \
  fzf "${fzfdefaults[@]}" \
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
  | fzf "${fzfdefaults[@]}" \
        "${previewcmd[@]}" \
        "${briefinfo[@]}" \
        "${bindexec[@]}"
}
