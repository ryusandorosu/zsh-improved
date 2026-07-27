duh() {
  zsh_cmd="
    du -ah $1 \
    | sort -rh \
    | head -32 \
  "
  zsheval "$zsh_cmd"
}

# make it a separate command
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

geoip() {
  zsh_cmd="curl -s http://ip-api.com/json/$1 | jq"
  zsheval "$zsh_cmd"
}
