source $ZSHREP/fzf/presets/main.sh
source $ZSHREP/common/cmd_display.sh

[[ $(alias lah) ]] && unalias lah
lah() { command /usr/bin/ls -laAh "$@"; }
laf() { command /usr/bin/ls -laAh "$@"; }
alias lah='lah --color=tty'

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
  zsh_eval "${zsh_cmd[@]}"
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
  zsh_eval "${zsh_cmd[@]}"
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
