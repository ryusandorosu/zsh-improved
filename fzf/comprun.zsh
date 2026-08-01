source $ZSHREP/fzf/presets.sh

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in

    cd|cdf|l|ls|lsa|lah|t|ta) 
                          preview_tree "{}" header
                          bind_fileinfo "{}" brief
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${filedirinfo[@]}"   "$@" ;;

    *vim|laf)             preview_bat "{}";  bind_fileinfo "{}" brief
       fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${filedirinfo[@]}"   "$@" ;;

    *ssh*)                  fzf "${fzfdefaults[@]}"                     "$@" ;;

    cp|mv)       preview_battree "{}" header; bind_fileinfo "{}" brief
        fzf "${fzfdefaults[@]}" "${previewcmd[@]}" "${filedirinfo[@]}"  "$@" ;;

    *alias)   fzf --bind='focus:+transform-header: printf "%s\n" {2}'   "$@" ;;

    whence)   fzf "${fzfdefaults[@]}" \
              --preview='print {} | sed -r "s/^\w+\s+//"'               "$@" ;;

    which)    fzf "${fzfdefaults[@]}"                                   "$@" ;;

    apt*)     fzf "${fzfdefaults[@]}" \
              --delimiter=/ --preview="apt-cache show {1}"              "$@" ;;

    kill*)  fzf "${fzfdefaults[@]}" --bind="focus:+transform-header:"   "$@" ;;

    *ctl)   fzf "${fzfdefaults[@]}" --preview="systemctl status {}"     "$@" ;;

    brew)   fzf "${fzfdefaults[@]}" \
            --preview="export HOMEBREW_COLOR=1; brew info {}"           "$@" ;;

    *)        bind_fileinfo "{}" brief
              fzf "${fzfdefaults[@]}" "${filedirinfo[@]}" \
                  --preview='fzf-preview.sh {}'                         "$@" ;;

  esac
}
