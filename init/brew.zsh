source $ZSHREP/init/definitions.zsh

if [[ "$OS_ID" != Darwin ]] && [[ ! -f $linuxbrew_location/bin/brew ]]; then

  /bin/bash -c "$(
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  )"

elif [[ "$OS_ID" == Darwin ]]; then

  # possibly use the same script as above?
  [[ ! -d $user_goinfre/.brew ]] && $ZSHREP/init/imported/install_brew.sh #/Users/kaycekey/Desktop/install_brew.sh

  brew_packages=(
    coreutils
    fzf
  )

  for formulae in "${brew_packages[@]}"; do
    [[ ! -d $goinfre_brew_location/Cellar/$formulae ]] && brew install "$formulae"
  done

fi
