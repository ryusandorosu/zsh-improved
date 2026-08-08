# git ls-files -t: sefi-deprecated option. alternatives: git status --porcelain; git status --short; git diff-files --name-status; git diff-files --name-only; git diff --name-status (less-like)
# flags comparison only, commands are not equal by output format: git status --untracked-files=all == git ls-files -om

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()

gitls() {
  gitcmd=(git)
  if   [[ -d "$1" ]]; then gitcmd+=(-C "$1");
  elif [[ -f "$1" ]]; then gitcmd+=(-C "$(dirname $1)"); fi

  zsh_cmd=(
    "${gitcmd[@]}"
    ls-files
    -t
    --full-name
  )

  zsheval "${zsh_cmd[@]}"
}
