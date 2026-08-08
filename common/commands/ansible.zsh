deploytag() {
  if [[ "$OS_ID" == "debian" && -z "$2" ]]; then

    deployhost=local
    playbook=server
    verbosity=-vv

  elif [[ "$OS_ID" == "ubuntu" && -z "$2" ]]; then

    deployhost=remote
    playbook=server
    verbosity=-vv

  elif [[ "$OS_ID" == "debian" && -n "$2" ]]; then

    is_valid=false
    srv_allowed_options=(
      asus
      honor
      tg
      cert
    )
    for q in "${srv_allowed_options[@]}"; do
      if [[ "$2" == "$q" ]]; then is_valid=true; break; fi
    done
    if ! $is_valid; then echo "$(basename $0): second argument accepts only one of ${(j:,:)srv_allowed_options[@]} options"; exit 1; fi

    if [[ "$2" == asus || "$2" == honor ]]; then
      deployhost=$2
      playbook=windows
      verbosity=-vvv
    else
      [[ "$2" == tg ]] && local srv_play=telegram
      [[ "$2" == cert ]] && local srv_play=certificates
      deployhost=local
      playbook=$srv_play
      verbosity=-vv
    fi

  elif [[ "$OS_ID" == "ubuntu" && -n "$2" ]]; then

    is_valid=false
    wsl_allowed_options=(
      win
      wsl
      tg
      app
      cert
    )
    for q in "${wsl_allowed_options[@]}"; do
      if [[ "$2" == "$q" ]]; then is_valid=true; break; fi
    done
    if ! $is_valid; then echo "$(basename $0): second argument accepts only one of ${(j:,:)wsl_allowed_options[@]} options"; exit 1; fi

    case "$2" in
      win)
        case "$(hostname)" in
          DESKTOP-5EFI5KM) deployhost=local-asus  ;;
          DESKTOP-2MJ0UCN) deployhost=local-honor ;;
        esac
        playbook=windows
        verbosity=-vvv
        ;;
      wsl)
        deployhost=wsl
        playbook=wsl
        verbosity=-vv
        ;;
      tg)
        deployhost=remote
        playbook=notifications
        verbosity=-vv
        ;;
      app)
        deployhost=remote
        playbook=applications
        verbosity=-vv
        ;;
      cert)
        deployhost=remote
        playbook=certificates
        verbosity=-vv
        ;;
    esac

  fi
  git -C /home/ryusandorosu/homeserver-ansible/ pull

  print "
  playbook: $playbook
  host: $deployhost
  "
  zsh_cmd=(
    ansible-playbook
    /home/ryusandorosu/homeserver-ansible/playbooks/$playbook.yml
    --limit
    "$deployhost"
    --diff
    --tag
    "$1"
    "$verbosity"
  )
  zsheval "${zsh_cmd[@]} | delta --config $ZSHREP/configs/gitdelta"
}
