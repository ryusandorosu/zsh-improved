source $ZSHREP/common/fzf/presets.sh

# similar to glgp alias
gitlog() {
  if [[ -z "$1" ]]; then
    preview_git show "" "{+1}"
    cmd=(
      git
      log
      --oneline
    )
  else
    if [[ -d "$1" ]]; then repo_flag="-C $1";
    elif [[ -f "$1" ]]; then repo_flag="-C $(dirname $1)"; fi
    repo_path="$(git -C $1 rev-parse --show-toplevel)"
    preview_git show "$repo_path" "{+1}"
    cmd=(
      git
      -C $1
      log
      --oneline
    )
  fi

  "${cmd[@]}" | fzf "${fzstyle[@]}" "${previewcmd[@]}" --multi
}
alias gitshow='gitlog'
