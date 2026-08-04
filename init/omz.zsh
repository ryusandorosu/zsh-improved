[[ ! -f $ZSH/oh-my-zsh.sh ]] && {
  sh -c "$(
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  )"
  # [[ $SHELL != $(which zsh) ]] && chsh -s $(which zsh)
}

custom_themes=(
  themes/passion.zsh-theme
)
link_custom_theme_to_omz() {
  local source="$ZSHREP/$1"
  local link="$ZSH/$1"
  [[ "$(whoami)" == root ]] && link="/root/.oh-my-zsh/$1"
  [[ ! -L $link ]] || [[ $(readlink $link) != $source ]] && {
    ln -fs $source $link
  }
}
for theme in "${custom_themes[@]}"; do
  link_custom_theme_to_omz $theme
done

zsh_git_plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
)

for plugin in "${zsh_git_plugins[@]}"; do
  [[ ! -d $ZSH/custom/plugins/$plugin ]] && {
    git clone https://github.com/zsh-users/$plugin \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
  }
done
