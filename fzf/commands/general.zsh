source $ZSHREP/fzf/presets/main.sh

lah() { command /usr/bin/ls -laAh --color=tty "$@"; }
laf() { command /usr/bin/ls -laAh --color=tty "$@"; }

# rename to fdf?
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
