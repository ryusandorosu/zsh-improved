source $ZSHREP/init/definitions.zsh
# to check on macos: possibly fd also needed here instead of being in linux packages
# possibly move delta config here?
common_brew_packages=(
  fzf
  git-delta
)

if [[ "$OS_ID" != Darwin ]] && [[ ! -f $linuxbrew_location/bin/brew ]]; then

  /bin/bash -c "$(
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  )"

  linux_brew_packages=(
    fd
    # ripgrep
  )

  for formulae in "${common_brew_packages[@]}"; do
    [[ ! -d $linuxbrew_location/Cellar/$formulae ]] && brew install "$formulae"
  done
  for formulae in "${linux_brew_packages[@]}"; do
    [[ ! -d $linuxbrew_location/Cellar/$formulae ]] && brew install "$formulae"
  done

elif [[ "$OS_ID" == Darwin ]]; then

  # possibly use the same script as above?
  [[ ! -d $user_goinfre/.brew ]] && $ZSHREP/init/imported/install_brew.sh #/Users/kaycekey/Desktop/install_brew.sh

  macos_brew_packages=(
    coreutils
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
