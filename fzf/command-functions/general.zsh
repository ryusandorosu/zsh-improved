source $ZSHREP/fzf/presets/main.sh

[[ $(alias lah) ]] && unalias lah
lah() { command /usr/bin/ls -laAh "$@"; }
laf() { command /usr/bin/ls -laAh "$@"; }
alias lah='lah --color=tty'

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  [[ -z "$file" ]] && return
  # сделать подстановку в командную строку вместо перехода напрямую из функции
  command "$(_get_editor)" "$file"
}

cdf() {
  local dir=$(
    preview_tree "{}"; bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"
  ) || return
  # сделать подстановку в командную строку вместо перехода напрямую из функции
  cd "$dir"
}

ffind() {
  local pattern
  [[ -z "$1" ]] && pattern="." || pattern="$1"

  preview_battree "{}"; bind_fileinfo "{}"
  fd "$pattern" '/' \
  | fzf "${fzfdefaults[@]}" \
        "${briefinfo[@]}" \
        "${previewcmd[@]}"
}

lfind() {
  local pattern
  [[ -z "$1" ]] && pattern="." || pattern="$1"

  preview_battree "{}"; bind_fileinfo "{}"
  locate -b "$pattern" \
  | fzf "${fzfdefaults[@]}" \
        "${briefinfo[@]}" \
        "${previewcmd[@]}"
}

neovim() {
  local pattern
  [[ -z "$1" ]] && pattern="." || pattern="$1"
  cmd=(locate -b "$pattern")

  preview_bat "{}"; bind_fileinfo "{}"; bind_exec nvim "{}"
  "${cmd[@]}" \
  | fzf "${fzfdefaults[@]}" \
        "${previewcmd[@]}" \
        "${briefinfo[@]}" \
        "${bindexec[@]}"
}
