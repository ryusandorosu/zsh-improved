preview_tree() {
  previewcmd=( --preview "$(_cmd_tree "$1")" )
}

preview_bat() {
  previewcmd=( --preview "$(_cmd_bat "$1" "$2")" )
}

preview_battree() {
  previewcmd=(
    --preview
    "$(_cmd_switch_battree "$1" header)"
    --preview-window
    "$(_set_window default wrap-word 1)"
  )
  ### wrapped header gets fixed only before the first wrap
  ### bat see: --wrap=auto/character; --chop-long-lines
  ## to check tree how it may fix header
}
