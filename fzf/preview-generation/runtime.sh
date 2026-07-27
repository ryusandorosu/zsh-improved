### REMINDER: do not use $path variable in fzf scripts. it is fzf builtin variable used instead of $PATH system-wide. $PATH usage causes errors.

_cmd_tree() {
  print -r -- "
    __path=$1
    tree -C \${~__path} | head -500
  "
}

_cmd_bat_basic() {
  print -r -- "
    __path=$1
    __style=$2
    bat \$__style --color=always \${~__path} | head -500
  "
}

_cmd_bat() {
  local localpath=$1 style=$2

  if [[ -n "$style" ]]; then

    case $style in
      git) style="--style=numbers,changes" ;;
      header) style="--style=numbers,header-filename" ;;
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
    __ft=\$(file --brief \${~__path})
    case \"\$__ft\" in
      JSON*) jq --color-output . \${~__path}          ;;
      *)     $(_cmd_bat_basic "$localpath" "$style") ;;
    esac
  "
}

_cmd_switch_battree() {
  local style=$2
  print -r -- "
    __path=$1
    test -d \${~__path} \
      && { $(_cmd_tree \${~__path}); } \
      || { $(_cmd_bat \${~__path} $style); }
  "
}

_cmd_bat_context() {
  local context=20
  print -r -- "
    __path=$1
    __line=$2
    __start=\$(( __line > $context ? __line - $context : 1 ))
    __end=\$(( __line + $context ))
    bat --color=always \
        --style=numbers,changes,header-filename \
        --highlight-line=\$__line \
        --line-range=\$__start:\$__end \
        \${~__path} \
    | $(_ripgrep_highlight {q})
  "
  ### applied header style, to check
}
