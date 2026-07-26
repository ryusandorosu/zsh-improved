source $ZSHREP/fzf/presets.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|cdf|l|ls|lsa|lah)       preview_tree "{}"; bind_fileinfo "{}"
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"     "$@" ;;

    vim|nvim|fvim)             preview_bat "{}";  bind_fileinfo "{}"
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"     "$@" ;;

    ssh|autossh)               fzf "${fzfdefaults[@]}"                  "$@" ;;

    cp|mv)                  preview_battree "{}"; bind_fileinfo "{}"
        fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${briefinfo[@]}"    "$@" ;;

    *alias)   fzf "${fzfdefaults[@]}" --preview='printf "%s\n" {2}'     "$@" ;;

    whence)   fzf "${fzfdefaults[@]}" \
              --preview='print {} | sed -r "s/^\w+\s+//"'               "$@" ;;

    which)    fzf "${fzfdefaults[@]}"                                   "$@" ;;

    apt*)     fzf "${fzfdefaults[@]}" \
              --delimiter=/ --preview="apt-cache show {1}"              "$@" ;;

    kill*)  fzf "${fzfdefaults[@]}" --bind="focus:+transform-header:"   "$@" ;;

    *ctl)   fzf "${fzfdefaults[@]}" --preview="systemctl status {}"     "$@" ;;

    brew)   fzf "${fzfdefaults[@]}" \
            --preview="export HOMEBREW_COLOR=1; brew info {}"           "$@" ;;

    *)        bind_fileinfo "{}"
              fzf "${fzfdefaults[@]}" "${briefinfo[@]}" \
                  --preview='fzf-preview.sh {}'                         "$@" ;;

  esac
}
