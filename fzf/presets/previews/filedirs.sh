_cmd_tree() {
  print -r -- "tree -C '$1' | head -500"
}

_cmd_bat_simple() {
  local path=$1 style=$2
  print -r -- "bat $style --color=always '$path' | head -500"
}

_cmd_bat_preview() {
  local path=$1 style=$2

  if [[ -n "$style" ]]; then

    case $style in
      git) style="--style=changes,numbers" ;;
    esac

  else

    style="--style=numbers"
    shift

  fi
  shift

  for opt in "$@"; do
    [[ "$opt" == --* ]] && style+=" $opt"
  done

  print -r -- "
    ft=\$(file --brief '$path')
    case \"\$ft\" in
      JSON*) jq --color-output . '$path' || $(_cmd_bat_simple "$path" "$style") ;;
      *)     $(_cmd_bat_simple "$path" "$style") ;;
    esac
  "
}

_cmd_bat_context() {
  local path=$1
  local context=20
  print -r -- "
    line=$2
    start=\$(( line > $context ? line - $context : 1 ))
    end=\$(( line + $context ))
    bat --color=always \
        --style=changes,numbers \
        --highlight-line=\$line \
        --line-range=\$start:\$end \
        '$path' \
    | rg --passthru \
         --color=always \
         --colors 'match:none' \
         --colors 'match:bg:yellow' \
         --colors 'match:fg:black' \
         --colors 'match:style:bold' \
         --smart-case \
         --fixed-strings \
         --regexp '{q}'
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
