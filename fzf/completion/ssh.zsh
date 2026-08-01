_fzf_ssh_hosts() {
  { [[ -r ~/.ssh/config ]] && \
    grep -i '^\s*host\s' ~/.ssh/config \
    | awk '{for(i=2;i<=NF;i++) print $i}'
  } | grep -v '[*?]' | sort -u
}

_fzf_complete_ssh() {
  _fzf_complete --prompt="ssh> " \
  --preview '
  ssh -G {} 2>/dev/null |
  awk "
  /^hostname /          {host=\$2}
  /^user /              {user=\$2}
  /^identityfile /      {identity=\$2}
  /^port /              {port=\$2}
  END {
    print \"Host:\",host
    print \"User:\",user
    print \"Port:\",port
    print \"Identity:\",identity
    print \"\"
  }
  "

  host=$(ssh -G {} 2>/dev/null | awk "/^hostname /{print \$2; exit}")
  ping -c1 -W1 "$host"
  ' \
  -- "$@" < <(_fzf_ssh_hosts)
}

_fzf_complete_autossh() { _fzf_complete_ssh "$@"; }

_fzf_server_docker_services() {
  local inventory=~/homeserver-ansible/inventory/group_vars/all/network/ports.yml
  [[ -r $inventory ]] && {
    yq -o=tsv '
      .docker[]
      | [.name, (.port.exposed // .port)]
      | select((.[1] | tag) == "!!int")
    ' "$inventory"
  }
}

_fzf_complete_sshport() {
  _fzf_complete --prompt="ssh -N -L port:127.0.0.1:port> " \
    --delimiter='\t' \
    --with-nth=1 \
    -- "$@" < <(_fzf_server_docker_services)
}
_fzf_complete_sshport_post() { cut -f2; }
