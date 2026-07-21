source $ZSHREP/common/fzf/presets/main.sh

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()
# idk why $repo_path substitution in cmd array and separately as a variable doesnt work properly in these functions unlike in gitadd/gitvim. sort out it later.

gitgrepf() {
  if [[ -z "$1" ]]; then
    cmd=(
      git
      grep
      "."
    )
  else
    if   [[ -d "$1" ]]; then repo_flag="-C $1";
    elif [[ -f "$1" ]]; then repo_flag="-C $(dirname $1)"; fi
    repo_path="$(git -C $1 rev-parse --show-toplevel)/"
    cmd=(
      git
      -C $1
      grep
      "."
    )
  fi

  "${cmd[@]}" | \
  fzf "${fzfdefaults[@]}" \
  --preview 'git '$repo_flag' grep --heading --function-context --line-number --color {3}'
   # --function-context: is exclusive with --*context flags
}

gitgrepb() {
  if [[ -z "$1" ]]; then
    cmd=(
      git
      grep
      --line-number
      "."
    )
  else
    repo_path="$(git -C $1 rev-parse --show-toplevel)/"
    cmd=(
      git
      -C $1
      grep
      --line-number
      "."
    )
  fi

  "${cmd[@]}" | \
  fzf "${fzfdefaults[@]}" \
  --preview 'bat --color=always --style=changes,numbers --highlight-line=$(cut -d: -f2 <<< {1}) '$repo_path'$(cut -d: -f1 <<< {1})'
}
