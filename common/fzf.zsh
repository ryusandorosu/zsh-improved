source $ZSHREP/common/fuzzy_presets.sh

alias gitgrepf="git grep . | fzf --style=full --preview 'git grep --heading --function-context --line-number --color {3}'"
alias gitgrepb="git grep --line-number . | fzf --style=full --preview 'batcat --color=always --style=numbers --highlight-line=\$(echo {1} | cut -d: -f2) \$(echo {1} | cut -d: -f1)'"
alias gitlog="git log --oneline | fzf --multi --style=full --preview 'git show --color {+1}'"

alias ffind="fd . '/' | fzf --style=full --preview='fzf-preview.sh {}' --bind 'focus:+transform-header:file --brief {}'"
alias lfind="locate -b . | fzf --style=full --preview='fzf-preview.sh {}' --bind 'focus:+transform-header:file --brief {}'"

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"
  ) || return
  command "$(get_editor)" "$file"
}

cdf() {
  local dir=$(
    bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${tree_view[@]}" "${briefinfo[@]}"
  ) || return
  cd "$dir"
}

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

    # gitvim ~/repo/ <enter> - correct
    # gitvim ~/repo/** <tab> - opens second instance of fzf. to solve as for cdf|fvim - open nvim directly from here and not call gitvim script. possibly this also not needed at all here
    gitvim)   preview_bat "{}" git; bind_fileinfo "{}"
              fzf "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)  fzf "${fzstyle[@]}" --preview='ping -c1 {}'           "$@" ;;

    *)        bind_fileinfo "{}"
                  fzf "${fzstyle[@]}" --preview='fzf-preview.sh {}' \
                  "${briefinfo[@]}"                                     "$@" ;;

  esac
}
