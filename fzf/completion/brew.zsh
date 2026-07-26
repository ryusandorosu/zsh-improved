_fzf_complete_brew() {
  _fzf_complete \
    --prompt="brew> " \
    -- "$@" < <(
      brew formulae | tail -n +2
      brew casks | tail -n +2
    )
}

_fzf_complete_brew_post() {
  print info --verbose
  cut -f1
}
