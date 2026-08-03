fsed() {
  local dest pattern
  if [[ -f "$1" || -d "$1" ]]; then
    dest="$1"
    pattern="$2"
    echo "$dest"
    shift 2
  else
    pattern="$1"
    shift
  fi

  zsh_cmd=(
    fd
    --type
    file
    --full-path
    "$dest"
    --exec
    sed
    "$@"
    -i
    "${pattern}"
  )
  zsheval "${zsh_cmd[@]}"
}

### usage: https://github.com/ms-jpq/sad
fsad() {
  local dest
  if [[ -f "$1" || -d "$1" ]]; then
    dest="$1"
    shift
  fi
  zsh_cmd="
    fd --type file \
    --full-path "$dest" \
    | sad "$@" \
    --pager='delta --config $ZSHREP/configs/saddelta' \
    --fzf='--style=minimal --layout=reverse --height=40%' \
  "
  zsheval "$zsh_cmd"
}

### usage: https://github.com/chmln/sd
fsd() {
  local dest
  if [[ -f "$1" || -d "$1" ]]; then
    dest="$1"
    shift
  fi
  zsh_cmd=(
    fd
    --type
    file
    --full-path
    "$dest"
    --exec
    sd
    "$@"
  )
  zsheval "${zsh_cmd[@]}"
}
