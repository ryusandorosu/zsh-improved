source $ZSHREP/common/fzf/presets.sh

# compdef _du duh
# compdef _sed findsed
# compdef _apt 'apt list'

# lah:
_fzf_complete_lah() {
  _fzf_complete -- "$@" < <(fd . '/' --type d)
}

# ssh|autossh:
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

# gitc|gitls|gitvim:
_fzf_git_repos() {
  fd --hidden --type dir --max-depth 6 '^\.git$' ~ | sed 's|.git/||' | sort -ru
}
_fzf_complete_gitls() {
  _fzf_complete --prompt="git> " \
    "${tree_view[@]}" \
    -- "$@" < <(_fzf_git_repos)
}
_fzf_complete_gitc() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitadd() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitvim() { _fzf_complete_gitls "$@"; }
