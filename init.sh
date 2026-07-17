#!/usr/bin/env bash
# shell_process="$(ps -p $$ | awk '{print $NF}' | awk 'NR==2')"

link_func() {
  local source="$1"
  local link="$2"
  if [[ ! -L "$link" ]] || [[ "$(readlink $link)" != "$source" ]]; then
    ln -ifsv "$source" "$link"
  fi
}

repo="git@github.com:ryusandorosu/zsh_settings.git"
destination="$HOME/$(basename $repo | sed 's/.git//')"
read -e -i "$destination" -p "Choose a destination to clone or remain the default: " destination

[[ ! -d "$destination/.git" ]] && {
  git clone "$repo" "$destination"
} || {
  echo "Cancelled. A repo is already cloned here: $destination"
}

create_symlink() {
  local zshrc="$1"

  [[ -f "$zshrc" && ! -L "$zshrc" ]] && {
    echo "Backing up an original $zshrc:"
    cp -v "$zshrc" "$zshrc.backup"
  }

  if [[ ! -L "$zshrc" ]]; then

    echo "Linking $zshrc to the repo:"
    link_func "$destination/.zshrc" "$zshrc"

  elif [[ -L "$zshrc" ]] && [[ "$(readlink $zshrc)" == "$destination/.zshrc" ]]; then

    echo -n "Cancelled. $zshrc is already linked to the repo: "
    readlink "$zshrc"

  else

    echo -n "Error occured. $zshrc is a symlink but linked to: "
    readlink "$zshrc"

  fi
}

create_symlink ~/.zshrc

zsh ~/.zshrc
if [[ "$(git -C "$destination" status --short)" ]] && [[ "$(readlink ~/.zshrc)" == "$destination/.zshrc" ]]; then
  echo "Installation done."
else
  echo "Error occured during installation."
  if [[ ! "$(git -C "$destination" status --short)" ]]; then
    echo "The repo has not been cloned successfully:"
    echo "$(git -C "$destination" status --short)"
  fi
  if [[ "$(readlink ~/.zshrc)" != "$destination/.zshrc" ]]; then
    echo "The symlink has not been created successfully:"
    readlink ~/.zshrc
  fi
fi

# sudo --login
# create_symlink /root/.zshrc
# rm -r "$destination/$(basename $repo | sed 's/.git//')" # костыль, так как при запуске скрипта от обычного пользователя создаётся ссылка в репозитории. лучше напрямую с рута или через ансибл
