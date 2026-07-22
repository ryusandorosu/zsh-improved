source $ZSHREP/fzf/presets/main.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|cdf|l|ls|lsa|lah)       preview_tree "{}"; bind_fileinfo "{}"
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"     "$@" ;;

    vim|nvim|fvim)             preview_bat "{}";  bind_fileinfo "{}"
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)               fzf "${fzfdefaults[@]}"                  "$@" ;;

    cp|mv)                 preview_battree "{}"; bind_fileinfo "{}"
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"     "$@" ;;

    *alias)   fzf "${fzfdefaults[@]}" --preview='printf "%s\n" {2}'     "$@" ;;

    whence)   fzf "${fzfdefaults[@]}" \
              --preview='print {} | sed -r "s/^\w+\s+//"'               "$@" ;;

    which)    fzf "${fzfdefaults[@]}"                                   "$@" ;;

    *)        bind_fileinfo "{}"
              fzf "${fzfdefaults[@]}" "${briefinfo[@]}" \
                  --preview='fzf-preview.sh {}'                         "$@" ;;

  esac
}
