source $ZSHREP/init/definitions.zsh
# possibly move delta config here?
common_brew_packages=(
  bat
  ripgrep
  fd
# to check on macos: possibly fd also needed here instead of being in linux packages
  fzf
  git-delta
  sad
)

if [[ "$OS_ID" != Darwin ]] && [[ ! -f $linuxbrew_location/bin/brew ]]; then

  /bin/bash -c "$(
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  )"

  linux_brew_packages=()

  for formulae in "${common_brew_packages[@]}"; do
    [[ ! -d $linuxbrew_location/Cellar/$formulae ]] && brew install "$formulae"
  done
  for formulae in "${linux_brew_packages[@]}"; do
    [[ ! -d $linuxbrew_location/Cellar/$formulae ]] && brew install "$formulae"
  done

elif [[ "$OS_ID" == Darwin ]]; then

  # possibly use the same script as above?
  [[ ! -d $user_goinfre/.brew ]] && $ZSHREP/init/imported/install_brew.sh #/Users/kaycekey/Desktop/install_brew.sh

  # where to take fasd? possibly replace with 'z' or 'autojump'.
  # check git version on macos
  macos_brew_packages=(
    coreutils
    tree
  )

  for formulae in "${macos_brew_packages[@]}"; do
    [[ ! -d $goinfre_brew_location/Cellar/$formulae ]] && brew install "$formulae"
  done
  for formulae in "${common_brew_packages[@]}"; do
    [[ ! -d $goinfre_brew_location/Cellar/$formulae ]] && brew install "$formulae"
  done

fi

# https://github.com/sharkdp/fd
# https://github.com/clvv/fasd
# https://github.com/junegunn/fzf
# https://github.com/BurntSushi/ripgrep
# https://github.com/rupa/z
# https://github.com/wting/autojump
