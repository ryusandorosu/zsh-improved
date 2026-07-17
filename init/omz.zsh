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

[[ ! -d $ZSH/custom/plugins/zsh-syntax-highlighting ]] && {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

[[ ! -d $ZSH/custom/plugins/zsh-autosuggestions ]] && {
  git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}
