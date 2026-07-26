export PATH=$PATH:$ZSHREP/common/commands
export PATH=$PATH:$ZSHREP/fzf/command-scripts
# custom ansible template renderer
export PATH=$PATH:$HOME/homeserver-ansible/tools

if [[ "$OS_ID" != Darwin ]]; then
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
export HOMEBREW_NO_ENV_HINTS=1 # man brew
eval "$(fasd --init auto)"
fi

export RIPGREP_CONFIG_PATH=$ZSHREP/configs/ripgreprc
