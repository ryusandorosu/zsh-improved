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
  [[ -z "$2" ]] && dest="."
  zsh_cmd="
    find $dest -type f \
    | xargs -r \
      sed -i \"${pattern}\" \
  "
  zsheval "$zsh_cmd"
}

geoip() {
  zsh_cmd="curl -s http://ip-api.com/json/$1 | jq"
  zsheval "$zsh_cmd"
}
