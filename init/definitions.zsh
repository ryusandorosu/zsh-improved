if [[ "$OS_ID" != Darwin ]]; then
  linuxbrew_location=/home/linuxbrew/.linuxbrew
elif [[ "$OS_ID" == Darwin ]]; then
  s21_user=kaycekey
  user_goinfre=/Users/$s21_user/goinfre
  goinfre_brew_location=/opt/goinfre/$s21_user/.brew
fi
