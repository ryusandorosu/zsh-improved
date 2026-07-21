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
  /^hostname / {host=\$2}
  /^user /     {user=\$2}
  /^port /     {port=\$2}
  END {
    print \"Host:\",host
    print \"User:\",user
    print \"Port:\",port
    print \"\"
  }
  "

  host=$(ssh -G {} 2>/dev/null | awk "/^hostname /{print \$2; exit}")
  ping -c1 "$host"
  ' \
  -- "$@" < <(_fzf_ssh_hosts)
}

_fzf_complete_autossh() { _fzf_complete_ssh "$@"; }
