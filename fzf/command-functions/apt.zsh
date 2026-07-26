_fzf_complete_aptls() {
  _fzf_complete \
    --prompt="apt> " \
    -- "$@" < <(apt list --installed | tail -n +2)
}

_fzf_complete_aptls_post() { cut -d/ -f1; }

aptls() {
  zsh_cmd=(apt)
  if [[ -z "$1" ]]; then zsh_cmd+=(list --installed);
  else zsh_cmd+=(show "$1"); fi
  zsheval "${zsh_cmd[@]}"
}
