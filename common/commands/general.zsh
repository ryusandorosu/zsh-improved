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

yaml2json() {
  # or 'pip install yq' instead
  python3 -c "import sys, yaml, json; y=yaml.safe_load(sys.stdin); print(json.dumps(y))" < "$1"
}
