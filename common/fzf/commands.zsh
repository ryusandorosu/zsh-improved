source $ZSHREP/common/fzf/presets.sh

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"
  ) || return
  command "$(get_editor)" "$file"
}

cdf() {
  local dir=$(
    bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${tree_view[@]}" "${briefinfo[@]}"
  ) || return
  cd "$dir"
}

gitgrepf() {
  git grep . | \
  fzf "${fzstyle[@]}" \
  --preview 'git grep --heading --function-context --line-number --color {3}'
}

gitgrepb() {
  git grep --line-number . | \
  fzf "${fzstyle[@]}" \
  --preview 'batcat --color=always --style=numbers --highlight-line=$(echo {1} | cut -d: -f2) $(echo {1} | cut -d: -f1)'
}

gitlog() {
  git log --oneline | \
  fzf "${fzstyle[@]}" --multi \
  --preview 'git show --color {+1}'
}
alias gitshow='gitlog'

ffind() {
  bind_fileinfo "{}"
  fd . '/' | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      --preview='fzf-preview.sh {}'
}

lfind() {
  bind_fileinfo "{}"
  locate -b . | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      --preview='fzf-preview.sh {}'
}

# bugged because of scan runtime (?) or second fzf instance if use ffind/lfind as i initially designed
neovim() {
  preview_bat "{}"
  bind_fileinfo "{}"
  bind_exec nvim "{}"
  locate -b . \
  | fzf "${fzstyle[@]}" \
        "${previef[@]}" \
        "${briefinfo[@]}" \
        "${bindexec[@]}"
}
