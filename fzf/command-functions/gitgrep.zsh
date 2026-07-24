source $ZSHREP/fzf/presets/main.sh

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()

### to replace it
### alias gitgrep='git grep --heading --line-number --before-context=2 --after-context=1'

gitgrep() {
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
        --preview "$(
          _cmd_bat_context "${repo_path}{1}" {2}
        )"
}
