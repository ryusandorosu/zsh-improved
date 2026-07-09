[[ -f "/etc/os-release" ]] && OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2) || OS_ID=$(uname)

# Main settings
export ZSH="$HOME/.oh-my-zsh"
[[ "$OS_ID" == debian ]] && ZSH_THEME="passion"
[[ "$OS_ID" == ubuntu ]] && ZSH_THEME="passion"
[[ "$OS_ID" == Darwin ]] && ZSH_THEME="passion"
[[ "$(whoami)" == root ]] && ZSH_DISABLE_COMPFIX=true

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
for file in ~/zsh_settings/common/*.zsh; do
  source "$file"
done
if [[ "$OS_ID" == debian ]]; then
  for file in ~/zsh_settings/server/*.zsh; do
    source "$file"
  done
elif [[ "$OS_ID" == ubuntu ]]; then
  for file in ~/zsh_settings/wsl/*.zsh; do
    source "$file"
  done
elif [[ "$OS_ID" == Darwin ]]; then
  for file in ~/zsh_settings/macos/*.zsh; do
    source "$file"
  done
fi

[[ $ZSH_THEME == "passion" ]] && source "$ZSH/themes/passion.zsh-theme"
