#!/bin/bash
ZSH_SCRIPT_CMD_FILE="$HOME/.zsh_cmd_display"
function zsheval() {
  if [[ $# > 1 ]]; then
    echo "$@" > "$ZSH_SCRIPT_CMD_FILE"
    eval "$@"
  elif [[ -n "$1" ]]; then
    echo "$1" > "$ZSH_SCRIPT_CMD_FILE"
    eval "$1"
  else
    echo "$(basename $0): no command to execute"
  fi
}

# ip_address='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$'
ip_address='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?)$'
