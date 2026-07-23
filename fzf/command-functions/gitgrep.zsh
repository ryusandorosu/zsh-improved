source $ZSHREP/fzf/presets/main.sh

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()

# reminder that preview of this function is likely rigged. to sort out what is going on.
gitgrepf() {
  gitcmd=(git)
  if   [[ -d "$1" ]]; then gitcmd+=(-C "$1");
  elif [[ -f "$1" ]]; then gitcmd+=(-C "$(dirname $1)"); fi

  gitcmd+=(grep)
  cmd=("${gitcmd[@]}")
  cmd+=(".")

  "${cmd[@]}" \
  | fzf "${fzfdefaults[@]}" \
    --preview ''${(j: :)gitcmd[@]}' --heading --function-context --line-number --color' #{3} -- to fix it!
   # --function-context: is exclusive with --*context flags
   # --show-function: try
}

gitgrepb() {
  gitcmd=(git)
  if   [[ -d "$1" ]]; then gitcmd+=(-C "$1");
  elif [[ -f "$1" ]]; then gitcmd+=(-C "$(dirname $1)"); fi
  if   [[ -n "$1" ]]; then repo_path="$("${gitcmd[@]}" rev-parse --show-toplevel)/"; fi

  gitcmd+=(
    grep
    --line-number
    "."
  )

  "${gitcmd[@]}" \
  | fzf "${fzfdefaults[@]}" \
    --delimiter : \
    --preview "$(_cmd_bat_preview "${repo_path}{1}" git "--highlight-line={2} --diff")"
}
