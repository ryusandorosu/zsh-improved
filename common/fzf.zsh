source $ZSHREP/common/fuzzy_presets.sh
alias cdf='cd'
alias fvim='nvim'

alias gitgrepf="git grep . | fzf --style=full --preview 'git grep --heading --function-context --line-number --color {3}'"
alias gitgrepb="git grep --line-number . | fzf --style=full --preview 'batcat --color=always --style=numbers --highlight-line=\$(echo {1} | cut -d: -f2) \$(echo {1} | cut -d: -f1)'"
alias gitlog="git log --oneline | fzf --multi --style=full --preview 'git show --color {+1}'"

alias ffind="fd . '/' | fzf --style=full --preview='fzf-preview.sh {}' --bind 'focus:+transform-header:file --brief {}'"
alias lfind="locate -b . | fzf --style=full --preview='fzf-preview.sh {}' --bind 'focus:+transform-header:file --brief {}'"

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)       fzf "${fzstyle[@]}" "${tree_view[@]}" "${bind_fileinfo[@]}"   "$@" ;;
    # lah)      fzf "${fzstyle[@]}" "${tree_view[@]}" "${bind_fileinfo[@]}"   "$@" ;;

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
                                # bind_exec "vim" "{}"
              fasd -f | awk '{print $2}' \
                | fzf --tac "${fzstyle[@]}" \
                "${bat_view[@]}" "${bind_fileinfo[@]}"                      "$@" ;; # "${enter_become[@]}" --

    ssh|autossh)  fzf "${fzstyle[@]}" --preview='ping -c1 {}'               "$@" ;;

    *)            fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${bind_fileinfo[@]}"                                     "$@" ;;

  esac
}
