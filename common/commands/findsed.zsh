fsed() {
  local pattern="$1"
  local dest opt
  if [[ -z "$2" ]]; then
    dest=""
    opt=""
  elif [[ "$2" == -* ]]; then
    dest=""
    opt="$2"
  else
    dest="$2"
    opt=""
  fi
  zsh_cmd="
    fd --type file . $dest \
    | xargs -r \
      sed $opt -i \"${pattern}\" \
  "
  zsheval "$zsh_cmd"
}

### usage: https://github.com/ms-jpq/sad
fsad() {
  local dest
  if [[ -f "$1" || -d "$1" ]]; then
    dest="$1"
    shift
  fi
  zsh_cmd="
    fd --type file . "$dest" \
    | \
    GIT_PAGER=\"delta --config $ZSHREP/configs/gitdelta\" \
    sad "$@" \
  "
  zsheval "$zsh_cmd"
}
