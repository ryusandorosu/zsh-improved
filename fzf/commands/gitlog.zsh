source $ZSHREP/fzf/presets/main.sh
### REMINDER: --color=always flags in commands before piping to fzf require --ansi for fzf

# similar to glgp alias
glog() {
  gitcmd=(git)
  _get_gitcmd_repo_path "$1"

  gitcmd+=(
    log
    --oneline
    --color=always
  )

  preview_git show "$repo_path" "{+1}"
  "${gitcmd[@]}" | fzf "${fzfdefaults[@]}" "${previewcmd[@]}" --multi
}
alias gsh='glog'

etclog() {
  gitcmd=(
    sudo
    git
    -C
    /etc
    log
    --oneline
    --color=always
  )

  preview_git show "/etc" "{+1}"
  "${gitcmd[@]}" | fzf "${fzfdefaults[@]}" "${previewcmd[@]}" --multi
}

# git log -S'$pattern' -- $file : search in the certain file
# git log -G'$regex' -p : ggr()
# see DIFF FORMATTING in man git show/log
# git blame $file

# new fzf-gitgrep
gg() {
  gitcmd=(git)
  _get_gitcmd_repo_path "$1"

  gitcmd+=(
    log
    --oneline
    --all
    --color=always
  )

  preview_git show "$repo_path" "{+1}"
  fzf "${fzfdefaults[@]}" "${previewcmd[@]}" \
      --multi \
      --disabled \
      --prompt="git log -S> " \
      --bind "start:reload:${(j: :)gitcmd[@]}" \
      --bind "change:reload:sleep 0.1; ${(j: :)gitcmd[@]} -S{q} -- || true" \
      < /dev/null
  # || true: защита на случай, если -S{q} с частично введённым/некорректным паттерном (например, незакрытая регулярка при добавлении -G в будущем) даст ненулевой код возврата — тогда reload просто не обновит список вместо падения с ошибкой в интерфейсе
}
