### REMINDER: do not use $path variable in fzf scripts. it is fzf builtin variable used instead of $PATH system-wide. $PATH usage causes errors.

_cmd_tree() {
  ### FILE OPTIONS: -C == color=always
  ## \"\${~__path}\" for windows paths, yet discovered in tree only unlike \${~__path} is used in other funcs and shows win paths well o_O
  ### UPD: discarded, it breaks ~/paths
  print -r -- "
    __path=$1
    tree -C \${~__path} \
      | awk -v n=200 '
        NR<=n { print; next }
        { last=\$0 }
        END { if (NR>n) print \"...\"; if (last!=\"\") print last }
      '
  "
}

_cmd_bat_basic() {
  print -r -- "
    __path=$1
    __style=$2
    bat \$__style --terminal-width=\$FZF_PREVIEW_COLUMNS --color=always \${~__path} | head -250
  "
}

_cmd_delta_grep_context() {
  local context=5
  print -r -- "
    __path=$1
    __line=$2
    __q={q}
    if [[ -n \"\$__q\" ]]; then
      __start=\$(( __line > $context ? __line - $context : 1 ))
      __end=\$(( __line + $context ))
      rg --json --fixed-strings -C $context -- \"\$__q\" \"\${~__path}\" \
        | jq -c --argjson start \"\$__start\" --argjson end \"\$__end\" '
            select(
              (.type != \"match\" and .type != \"context\")
              or (.data.line_number >= \$start and .data.line_number <= \$end)
            )
          ' \
        | delta --config $ZSHREP/configs/rgdelta
    else
      # _cmd_bat_context is here now
      __start=\$(( __line > $context ? __line - $context : 1 ))
      __end=\$(( __line + $context ))
      bat --color=always \
          --style=numbers,changes,header-filename \
          --terminal-width=\$FZF_PREVIEW_COLUMNS \
          --highlight-line=\$__line \
          --line-range=\$__start:\$__end \
          \${~__path}
    fi
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
