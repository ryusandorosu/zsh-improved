source $ZSHREP/fzf/presets.sh

lah() { command /usr/bin/ls -laAh --color=tty "$@"; }
laf() { command /usr/bin/ls -laAh --color=tty "$@"; }

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
  # --max-results 1000

  preview_battree "{}"; bind_fileinfo "{}" brief
  # fd "$pattern" '/' \
  "${cmd[@]}" \
  | fzf \
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
    --ignore-spaces
    --basename
    "$pattern"
  )
  # --limit 1000

  preview_battree "{}"; bind_fileinfo "{}" brief
  # locate -b "$pattern" \
  "${cmd[@]}" \
  | fzf \
    --prompt "locate> " \
    "${fzfdefaults[@]}" \
    "${filedirinfo[@]}" \
    "${previewcmd[@]}"
}
# --height ~100%
