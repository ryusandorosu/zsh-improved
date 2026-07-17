export ZSHREP="$(dirname $(readlink ~/.zshrc))"
[[ -f "/etc/os-release" ]] && OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2) || OS_ID=$(uname)

# Main settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="passion"
[[ "$(whoami)" == root ]] && ZSH_DISABLE_COMPFIX=true

[[ "$OS_ID" != Darwin ]] && {
  local fzfversion=$(
    /home/linuxbrew/.linuxbrew/Cellar/fzf/*/bin/fzf --version \
    | cut -d' ' -f1
  )
  export FZF_BASE=/home/linuxbrew/.linuxbrew/Cellar/fzf/$fzfversion/shell
}

plugins=(
  git
  fzf
  sudo
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

# Custom settings
if [[ "$OS_ID" != Darwin ]] && [[ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  /bin/bash -c "$(
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  )"
fi

for file in ~/zsh_settings/common/*.zsh; do source "$file"; done
for file in ~/zsh_settings/common/fzf/*.zsh; do source "$file"; done

if [[ "$OS_ID" == debian ]]; then
  for file in ~/zsh_settings/server/*.zsh; do source "$file"; done
elif [[ "$OS_ID" == ubuntu ]]; then
  for file in ~/zsh_settings/wsl/*.zsh; do source "$file"; done
elif [[ "$OS_ID" == Darwin ]]; then
  [[ ! -d /Users/kaycekey/goinfre/.brew ]] && /Users/kaycekey/Desktop/install_brew.sh
  [[ ! -d /opt/goinfre/kaycekey/.brew/Cellar/coreutils ]] && brew install coreutils
  [[ ! -d /opt/goinfre/kaycekey/.brew/Cellar/fzf ]] && brew install fzf
  for file in ~/zsh_settings/macos/*.zsh; do source "$file"; done
fi

[[ $ZSH_THEME == "passion" ]] && source "$ZSH/themes/passion.zsh-theme"
