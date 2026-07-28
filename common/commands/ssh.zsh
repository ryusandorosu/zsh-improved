sshport() {
  [[ "$OS_ID" == "debian" ]] && echo "denied" && exit 1
  [[ "$OS_ID" == "ubuntu" ]] && identity=nuc_server

  zsh_cmd=(
    autossh
    -N
    -L
    $1:127.0.0.1:$1
    -p 22
    -i
    $HOME/.ssh/$identity
    ryusandorosu@192.168.0.100
  )
  zsheval "${zsh_cmd[@]}"
}
