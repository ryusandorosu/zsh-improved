sshport() {
  [[ "$os_id" == "debian" ]] && echo "denied" && exit 1
  [[ "$os_id" == "ubuntu" ]] && identity=~/.ssh/nuc_server

  zsh_cmd=(
    autossh
    -N
    -L
    $1:127.0.0.1:$1
    -p 22
    -i
    $identity
    ryusandorosu@192.168.0.100
  )
  zsheval "${zsh_cmd[@]}"
}
