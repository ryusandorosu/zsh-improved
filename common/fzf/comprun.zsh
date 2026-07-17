source $ZSHREP/common/fzf/presets.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)       bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${tree_view[@]}" "${briefinfo[@]}"   "$@" ;;
    lah)      bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${tree_view[@]}" "${briefinfo[@]}"   "$@" ;;

    gitc)     bind_fileinfo "{}"
              fasd -d | awk '{print $2}' \
                | fzf --tac "${fzstyle[@]}" \
                  "${tree_view[@]}" "${briefinfo[@]}"                   "$@" ;;

    vim|nvim) preview_bat "{}"; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)  fzf "${fzstyle[@]}" --preview='ping -c1 {}'           "$@" ;;

    *)        bind_fileinfo "{}"
                  fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${briefinfo[@]}"                                     "$@" ;;

  esac
}
