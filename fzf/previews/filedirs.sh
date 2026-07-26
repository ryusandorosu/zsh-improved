### REMINDER: do not use $path variable in fzf scripts. it is fzf builtin variable used instead of $PATH system-wide. $PATH usage causes errors.

_cmd_tree() {
  print -r -- "
    __path=$1
    tree -C \${~__path} | head -500
  "
}

_cmd_bat_simple() {
  local style=$2
  print -r -- "
    __path=$1
    bat $style --color=always \${~__path} | head -500
  "
}

_cmd_bat_preview() {
  local localpath=$1 style=$2

  if [[ -n "$style" ]]; then

    case $style in
      git) style="--style=changes,numbers" ;;
    esac

  else

    style="--style=numbers"
    shift

  fi

  for opt in "$@"; do
    [[ "$opt" == --* ]] && style+=" $opt"
  done

  print -r -- "
    __path=$localpath
    ft=\$(file --brief \${~__path})
    case \"\$ft\" in
      JSON*) jq --color-output . \${~__path} || $(_cmd_bat_simple "$localpath" "$style") ;;
      *)     $(_cmd_bat_simple "$localpath" "$style") ;;
    esac
  "
}

_cmd_switch_battree() {
  print -r -- "
    __path=$1
    test -d \${~__path} \
      && { $(_cmd_tree \${~__path}); } \
      || { $(_cmd_bat_preview \${~__path}); }
  "
}

_cmd_bat_context() {
  local context=20
  print -r -- "
    __path=$1
    line=$2
    start=\$(( line > $context ? line - $context : 1 ))
    end=\$(( line + $context ))
    bat --color=always \
        --style=changes,numbers \
        --highlight-line=\$line \
        --line-range=\$start:\$end \
        \${~__path} \
    | $(_ripgrep_highlight {q})
  "
}

preview_tree() {
  previewcmd=( --preview "$(_cmd_tree "$1")" )
}

preview_bat() {
  previewcmd=( --preview "$(_cmd_bat_preview "$1" "$2")" )
}

preview_battree() {
  previewcmd=( --preview "$(_cmd_switch_battree "$1")" )
}
