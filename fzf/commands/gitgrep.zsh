source $ZSHREP/fzf/presets.sh

ggedit() {
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
          _cmd_delta_grep_context "${repo_path}{1}" {2}
        )" \
        "${bindbecome[@]}"
}
