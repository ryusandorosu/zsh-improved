source $ZSHREP/fzf/presets/main.sh

# similar to glgp alias
glog() {
  gitcmd=(git)
  if   [[ -d "$1" ]]; then gitcmd+=(-C "$1");
  elif [[ -f "$1" ]]; then gitcmd+=(-C "$(dirname $1)"); fi
  if   [[ -n "$1" ]]; then repo_path="$("${gitcmd[@]}" rev-parse --show-toplevel)"; fi

  gitcmd+=(
    log
    --oneline
    --color=always
  )

  preview_git show "$repo_path" "{+1}"
  "${gitcmd[@]}" | fzf "${fzfdefaults[@]}" "${previewcmd[@]}" --ansi --multi
}
alias gsh='glog'

# git log -S'$pattern' -p/--patch : shows git diff with previous commits
# git log -S'$pattern' -- $file : search in the certain file
# git log -G'$regex' -p : nuff said
# see DIFF FORMATTING in man git show/log

# git blame $file

# new fzf-gitgrep
gg() {
  gitcmd=(git)
  if   [[ -d "$1" ]]; then gitcmd+=(-C "$1");
  elif [[ -f "$1" ]]; then gitcmd+=(-C "$(dirname $1)"); fi
  if   [[ -n "$1" ]]; then repo_path="$("${gitcmd[@]}" rev-parse --show-toplevel)"; fi

  gitcmd+=(
    log
    --oneline
    --all
    --color=always # requires --ansi for fzf
  )

  preview_git show "$repo_path" "{+1}"
  fzf "${fzfdefaults[@]}" "${previewcmd[@]}" \
      --ansi \
      --multi \
      --disabled \
      --prompt="git log -S> " \
      --bind "start:reload:${(j: :)gitcmd[@]}" \
      --bind "change:reload:sleep 0.1; ${(j: :)gitcmd[@]} -S{q} -- || true" \
      < /dev/null
  # || true: защита на случай, если -S{q} с частично введённым/некорректным паттерном (например, незакрытая регулярка при добавлении -G в будущем) даст ненулевой код возврата — тогда reload просто не обновит список вместо падения с ошибкой в интерфейсе
}
