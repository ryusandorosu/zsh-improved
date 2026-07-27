_set_header() {
  if [[ $1 == header ]]; then
  _fixed_header_count=1
  fi
}

preview_tree() {
  _set_header $2
  previewcmd=(
    --preview
    "$(_cmd_tree "$1")"
    --preview-window
    "$(_set_window default wrap-word $_fixed_header_count)"
  )
}

### wrapped header gets fixed only before the first wrap
### to see: --wrap=auto/character; --chop-long-lines
preview_bat() {
  _set_header $2
  previewcmd=(
    --preview
    "$(_cmd_bat "$1" "$2")"
    --preview-window
    "$(_set_window default wrap-word $_fixed_header_count)"
  )
}

preview_battree() {
  _set_header $2
  previewcmd=(
    --preview
    "$(_cmd_switch_battree "$1" "$2")"
    --preview-window
    "$(_set_window default wrap-word $_fixed_header_count)"
  )
}
