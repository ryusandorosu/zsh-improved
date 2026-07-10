_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)   fzf --style full --preview 'tree -C {} | head -200'      "$@" ;;
    nvim) fzf --style full --preview 'batcat --color=always {}'    "$@" ;;
    ssh)  fzf --style full --preview 'ping -c1 {}'                 "$@" ;;
    *)    fzf --style full --preview 'fzf-preview.sh {}'           "$@" ;;
  esac
}
