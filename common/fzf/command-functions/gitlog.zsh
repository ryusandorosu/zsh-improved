source $ZSHREP/common/fzf/presets.sh

# similar to glgp alias
gitlog() {
  if [[ -z "$1" ]]; then
    cmd=(
      git
      log
      --oneline
    )
  else
    if [[ -d "$1" ]]; then repo_flag="-C $1";
    elif [[ -f "$1" ]]; then repo_flag="-C $(dirname $1)"; fi
    repo_path="$(git -C $1 rev-parse --show-toplevel)/"
    cmd=(
      git
      -C $1
      log
      --oneline
    )
  fi

  "${cmd[@]}" | \
  fzf "${fzstyle[@]}" --multi \
  --preview 'git '$repo_flag' show --color {+1}'
}
alias gitshow='gitlog'
