#!/bin/bash
ZSH_SCRIPT_CMD_FILE="$HOME/.zsh_cmd_display"
function zsh_eval() {
  if [[ $# > 1 ]]; then
    echo "$@" > "$HOME/.zsh_cmd_display"
    eval "$@"
  elif [[ -n "$1" ]]; then
    echo "$1" > "$HOME/.zsh_cmd_display"
    eval "$1"
  else
    echo "$(basename $0): no command to execute"
  fi
}

# ip_address='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$'
ip_address='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?)$'
