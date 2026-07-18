source $ZSHREP/common/fzf/presets.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|lah)   bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${tree_view[@]}" "${briefinfo[@]}"   "$@" ;;

    vim|nvim) preview_bat "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)  fzf "${fzstyle[@]}"                                   "$@" ;;

    cp|mv)    preview_battree "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    *)        bind_fileinfo "{}"
                  fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${briefinfo[@]}"                                     "$@" ;;

  esac
}
