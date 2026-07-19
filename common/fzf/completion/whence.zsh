_fzf_complete_whence() {
  _fzf_complete --prompt="function> " \
    --delimiter='\t' \
    --with-nth=1 \
    -- "$@" < <(
      for k in "${(@k)functions}"; do
        local body="${functions[$k]//$'\n'/\\n}"
        print -r -- "${k}"$'\t'"${body}"
      done | sort
    )
}

_fzf_complete_whence_post() {
  echo "-f"
  cut -f1
}

# /home/ryusandorosu/.local/bin seems like belongs not only to python
# /snap/bin
_fzf_complete_which() {
  _fzf_complete --prompt="which> " \
    --preview='
    which {}
    [[ -L $(which {}) ]] && {
      echo -n "Linked to: "
      realpath $(which {})
    }
    case "$(dirname $(which {}))" in
      /bin|/sbin|/usr/bin|/usr/sbin) apt-cache show $(dpkg -S {} | cut -d: -f1) ;;
      /home/linuxbrew/.linuxbrew/bin) brew info {} ;;
      $HOME/.local/bin) pip show {} ;;
    esac
    ' \
    -- "$@" < <(
      local dir
      print -rl -- /home/linuxbrew/.linuxbrew/bin/*(N:t)
      # $PATH spelling is not recognized
      local path+=""
      for dir in $path; do
        [[ "$dir" == /mnt/c/* ]] && continue
        if [[ -d "$dir" ]]; then
          [[ "$(fd "." --type x "$dir")" == "" ]] && continue
          print -rl -- ${dir}/*(N:t)
        fi
      done | sort -u
    )
}
