duh() {
  zsh_cmd="
    du -ah $1 \
    | sort -rh \
    | head -32 \
  "
  zsheval "$zsh_cmd"
}

fsed() {
  local pattern="$1"
  local dest
  if [[ -z "$2" ]]; then
    dest=""
  fi
  zsh_cmd="
    fd --strip-cwd-prefix=always \
       --type file . $dest \
    | xargs -r \
      sed -i \"${pattern}\" \
  "
  zsheval "$zsh_cmd"
}

geoip() {
  zsh_cmd="curl -s http://ip-api.com/json/$1 | jq"
  zsheval "$zsh_cmd"
}
