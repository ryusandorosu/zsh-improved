source $ZSHREP/common/fzf/presets.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|lah|l|ls|lsa)          preview_tree "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    vim|nvim)                  preview_bat "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)                                fzf "${fzstyle[@]}"     "$@" ;;

    cp|mv)                 preview_battree "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    alias|unalias)  fzf "${fzstyle[@]}" --preview='printf "%s\n" {2}'   "$@" ;;

    whence)   fzf "${fzstyle[@]}" \
              --preview='print {} | sed -r "s/^\w+\s+//"'               "$@" ;;
    which)    fzf "${fzstyle[@]}"                                       "$@" ;;

    *)        bind_fileinfo "{}"
              fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${briefinfo[@]}"                                     "$@" ;;

  esac
}
