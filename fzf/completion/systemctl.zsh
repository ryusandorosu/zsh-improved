_fzf_complete_systemctl() {
  _fzf_complete \
    --prompt="systemctl> " \
    -- "$@" < <(
      systemctl list-units | awk '{x = substr($0, 3); print x}' | awk '{print $1}' | tail -n +2 | tac | tail -n +7 | tac
    )
}

_fzf_complete_systemctl_post() {
  print status
  cut -f1
}

_fzf_complete_journalctl() {
  _fzf_complete \
    --prompt="journalctl> " \
    -- "$@" < <(
      systemctl list-units | awk '{print $1}' | grep -P '\.service'
    )
}

_fzf_complete_journalctl_post() {
  print -- "-u"
  cut -f1
}
