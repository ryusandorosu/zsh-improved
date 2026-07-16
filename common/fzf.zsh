source $ZSHREP/common/fuzzy_presets.sh
alias cdf='cd'
alias fvim='nvim'
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)       fzf "${fzstyle[@]}" "${tree_view[@]}" "${bind_fileinfo[@]}"   "$@" ;;

    cdf|gitc) fasd -d | awk '{print $2}' \
                | fzf --tac "${fzstyle[@]}" \
                  "${tree_view[@]}" "${bind_fileinfo[@]}"                   "$@" ;;

    nvim)                       bat_view_simple "{}"
              fzf "${fzstyle[@]}" "${bat_view[@]}" "${bind_fileinfo[@]}"    "$@" ;;

    # gitvim ~/repo/ <enter> - correct
    # gitvim ~/repo/** <tab> - fatal: cannot change to '/home/ryusandorosu/**/file.ext': Not a directory
    gitvim)                      bat_view_git "{}"
              fzf "${fzstyle[@]}" "${bat_view[@]}" "${bind_fileinfo[@]}"    "$@" ;;

    fvim)                       bat_view_simple "{}"
              fasd -f | awk '{print $2}' \
                | fzf --tac "${fzstyle[@]}" \
                "${bat_view[@]}" "${bind_fileinfo[@]}"                      "$@" ;;

    ssh|autossh)  fzf "${fzstyle[@]}" --preview='ping -c1 {}'               "$@" ;;

    *)            fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${bind_fileinfo[@]}"                                     "$@" ;;

  esac
}
