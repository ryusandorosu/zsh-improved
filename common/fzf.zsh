alias cdf='cd'
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)   fzf --style full --preview 'tree -C {} | head -200'         "$@" ;;
    cdf)  fasd -d | sort -nr | awk '{print $2}' \
          | fzf --style full --preview 'tree -C {} | head -200'       "$@" ;;
    nvim) fzf --style full --preview 'batcat --color=always {}'       "$@" ;;
    ssh)  fzf --style full --preview 'ping -c1 {}'                    "$@" ;;
    *)    fzf --style full --preview 'fzf-preview.sh {}'              "$@" ;;
  esac
}
