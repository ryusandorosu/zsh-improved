_cmd_tree() {
  print -r -- "tree -C '$1' | head -500"
}

_cmd_bat_simple() {
  local path=$1 style=$2
  print -r -- "bat $style --color=always '$path' | head -500"
}

_cmd_bat_preview() {
  local path=$1 style=$2
  local gitstyle="--style=changes,numbers"
  [[ -n "$style" && "$style" == git ]] && style="$gitstyle"
  print -r -- "
    ft=\$(file --brief '$path')
    case \"\$ft\" in
      JSON*) jq --color-output . '$path' || $(_cmd_bat_simple "$path" "$style") ;;
      *)     $(_cmd_bat_simple "$path" "$style") ;;
    esac
  "
}

preview_tree() {
  previewcmd=( --preview "$(_cmd_tree "$1")" )
}

preview_bat() {
  previewcmd=( --preview "$(_cmd_bat_preview "$1" "$2")" )
}

preview_battree() {
  previewcmd=(
    --preview
    "test -d '$1' && { $(_cmd_tree "$1"); } || { $(_cmd_bat_preview "$1" ""); }"
  )
}
