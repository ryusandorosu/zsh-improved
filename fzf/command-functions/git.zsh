_get_gitcmd_repo_path() {
  [[ -d "$1" ]] && gitcmd+=(-C "$1")
  [[ -f "$1" ]] && gitcmd+=(-C "$(dirname $1)")
  [[ -n "$1" ]] && repo_path="$("${gitcmd[@]}" rev-parse --show-toplevel)/"
}
