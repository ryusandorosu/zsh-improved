alias cdf='cd'
alias fvim='nvim'
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)       fzf --style=full --preview='tree -C {} | head -200'          "$@" ;;
    cdf|gitc) fasd -d | awk '{print $2}' | \
              fzf \
                --tac --style=full \
                --preview='tree -C {} | head -200'                         "$@" ;;
    nvim)     fzf --style=full \
                --preview='batcat --color=always {}' \
                --bind='focus:+transform-header:file --brief {}'           "$@" ;;
    fvim)     fasd -f | awk '{print $2}' | \
              fzf \
                --tac --style=full \
                --preview='batcat --color=always {}' \
                --bind='focus:+transform-header:file --brief {}'           "$@" ;;
    ssh|autossh)  fzf --style=full --preview='ping -c1 {}'                 "$@" ;;
    *)            fzf --style=full --preview='fzf-preview.sh {}' \
                  --bind='focus:+transform-header:file --brief {}'         "$@" ;;
  esac
}
