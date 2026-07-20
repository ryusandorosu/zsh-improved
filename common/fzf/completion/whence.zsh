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

_fzf_complete_which() {
  _fzf_complete --prompt="which> " \
    --preview='
    export HOMEBREW_COLOR=1
    export FORCE_COLOR=1
    which {}
    [[ -L $(which {}) ]] && {
      local whichlinked=$(realpath $(which {}))
      print "Linked to: $whichlinked"
    }
    case "$(dirname $(which {}))" in
      /bin|/sbin|/usr/bin|/usr/sbin) apt-cache show $(dpkg -S {} | cut -d: -f1) ;;
      *brew/bin)                                                   brew info {} ;;
      /snap/bin|/usr/bin/snap)                                     snap info {} ;;
      $HOME/.local/bin)
        [[ ! -L $(which {}) ]] && {
          local bin={}
          local record=$(
            rg -loP "(/?\.\.)+/bin/$bin(,??)" $HOME/.local/lib/python3.*/site-packages/*.dist-info/RECORD
          )
          local pkgdir=${record:h}
          local pkgname=${${${pkgdir:t}%.dist-info}%-[0-9]*}
                                                              pip show $pkgname
        } || {
          # pipx info: local mode
          local venvpack=$(dirname $(dirname $whichlinked))
                                bat --color=always $venvpack/pipx_metadata.json
        }                                                                       ;;
      /usr/local/bin)
        [[ -L $(which {}) ]] && {
          local locallib=$(cut -d/ -f5 <<< $whichlinked)
          case $locallib in
            # npm info: global mode
            node_modules)              npm info $(cut -d/ -f6 <<< $whichlinked) ;;
          esac
        }                                                                       ;;
    esac
    ' \
    -- "$@" < <(
      local dir
      for dir in $path; do # same as $PATH
        [[ "$dir" == /mnt/c/* ]] && continue
        if [[ -d "$dir" ]]; then
          fd "." --type x --type l "$dir" | sed -r 's|.*/||'
        fi
      done | sort -u
    )
}
