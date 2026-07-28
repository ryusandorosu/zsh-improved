source $ZSHREP/fzf/presets.sh

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()

# old gitgrep
ggrep() {
  gitcmd=(git)
  _get_gitcmd_repo_path "$1"

  gitcmd+=(
    grep
    --line-number
    "."
  )

  bind_become "$(_get_editor)" "${repo_path}{1}" "+{2}"
  "${gitcmd[@]}" \
  | fzf "${fzfdefaults[@]}" \
        --prompt="git-grep to $(_get_editor)> " \
        --delimiter : \
        --preview "$(
          _cmd_bat_context "${repo_path}{1}" {2}
        )" \
        "${bindbecome[@]}"
}
