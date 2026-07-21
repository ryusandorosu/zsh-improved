_cmd_tree() {
  print -r -- "tree -C '$1' | head -500"
}

_cmd_bat() {
  local path=$1 style=$2
  print -r -- "bat $style --color=always '$path' | head -500"
}

_cmd_file_preview() {
  local path=$1 style=$2
  print -r -- "
    ft=\$(file --brief '$path')
    case \"\$ft\" in
      JSON*) jq --color-output . '$path' || $(_cmd_bat "$path" "$style") ;;
      *)     $(_cmd_bat "$path" "$style") ;;
    esac
  "
}

preview_tree() {
  previewcmd=( --preview "$(_cmd_tree "$1")" )
}

preview_bat() {
  local style=""
  [[ -n "$2" && "$2" == git ]] && style="--style=changes,numbers"
  previewcmd=( --preview "$(_cmd_file_preview "$1" "$style")" )
}

preview_battree() {
  previewcmd=(
    --preview
    "test -d '$1' && { $(_cmd_tree "$1"); } || { $(_cmd_file_preview "$1" ""); }"
  )
}
