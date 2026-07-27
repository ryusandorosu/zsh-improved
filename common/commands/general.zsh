duh() {
  zsh_cmd="
    du -ah $1 \
    | sort -rh \
    | head -32 \
  "
  zsheval "$zsh_cmd"
}

geoip() {
  zsh_cmd="curl -s http://ip-api.com/json/$1 | jq"
  zsheval "$zsh_cmd"
}
