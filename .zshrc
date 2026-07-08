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
# sudo plugin: adds 'sudo' in front of a typed command by esc+esc

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

# Custom settings
for file in ~/zsh_settings/common/*.zsh; do
  source "$file"
done
case "$OS_ID" in
  debian)
    for file in ~/zsh_settings/server/*.zsh; do
      source "$file"
    done
    ;;
  ubuntu)
    for file in ~/zsh_settings/wsl/*.zsh; do
      source "$file"
    done
    ;;
  Darwin)
    for file in ~/zsh_settings/macos/*.zsh; do
      source "$file"
    done
    ;;
esac

[[ $ZSH_THEME == "passion" ]] && source "$ZSH/themes/passion.zsh-theme"
