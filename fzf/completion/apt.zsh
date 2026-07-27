_fzf_complete_apt() {
  _fzf_complete \
    --prompt="apt-cache pkgnames> " \
    --bind="focus:+transform-header:
      apt list --installed 2>/dev/null | grep {}/
    " \
    -- "$@" < <(apt-cache pkgnames)
}

_fzf_complete_apt_post() {
  print show -a
  cut -f1
}

_fzf_complete_aptls() {
  _fzf_complete \
    --prompt="apt list --installed> " \
    -- "$@" < <(apt list --installed 2>/dev/null | tail -n +2)
}

_fzf_complete_aptls_post() { cut -d/ -f1; }

aptls() {
  zsh_cmd=(apt)
  if [[ -z "$1" ]]; then zsh_cmd+=(list --installed);
  else zsh_cmd+=(show "$1"); fi
  zsheval "${zsh_cmd[@]}"
}
