export PATH=$PATH:$ZSHREP/common/commands
export PATH=$PATH:$ZSHREP/fzf/command-scripts
# custom ansible template renderer
export PATH=$PATH:$HOME/homeserver-ansible/tools

if [[ "$OS_ID" != Darwin ]]; then
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
eval "$(fasd --init auto)"
fi
