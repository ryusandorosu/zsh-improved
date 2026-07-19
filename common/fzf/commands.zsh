source $ZSHREP/common/fzf/presets.sh

fvim() {
  local file=$(
    preview_bat "{}"; bind_fileinfo "{}"
    fasd -f | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"
  ) || return
  [[ -z "$file" ]] && return
  command "$(get_editor)" "$file"
}

cdf() {
  local dir=$(
    preview_tree "{}"; bind_fileinfo "{}"
    fasd -d | awk '{print $2}' |
    fzf --tac "${fzstyle[@]}" "${previef[@]}" "${briefinfo[@]}"
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
  --preview 'bat --color=always --style=numbers --highlight-line=$(echo {1} | cut -d: -f2) $(echo {1} | cut -d: -f1)'
}

# similar to glgp alias
gitlog() {
  git log --oneline | \
  fzf "${fzstyle[@]}" --multi \
  --preview 'git show --color {+1}'
}
alias gitshow='gitlog'

ffind() {
  preview_battree "{}"; bind_fileinfo "{}"
  fd . '/' | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      "${previef[@]}"
}

lfind() {
  preview_battree "{}"; bind_fileinfo "{}"
  locate -b . | \
  fzf "${fzstyle[@]}" \
      "${briefinfo[@]}" \
      "${previef[@]}"
}

neovim() {
  preview_bat "{}"
  bind_fileinfo "{}"
  bind_exec nvim "{}"
  cmd=(
    locate
    -b
    .
  )
  "${cmd[@]}" \
  | fzf "${fzstyle[@]}" \
        "${previef[@]}" \
        "${briefinfo[@]}" \
        "${bindexec[@]}"
}
