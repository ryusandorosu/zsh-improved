preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag pre
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""
  [[ -n "$repo_root" && "$repo_root" == /etc ]] && pre=sudo

  case $gitcommand in
  diff)
    local localpath=$3
    local oldpath=$5
    [[ -n "$repo_root" ]] && localpath="$repo_root/$localpath"
    select="$localpath"
    ;;
  show)
    local commit=$3
    select=$commit
    ;;
  esac

  previewcmd=(
    --preview
    "
    [[ -z $select ]] && return
    __status=$4
    __path=$localpath
    __oldpath=$oldpath
    __q={q}
    __delta() { delta --config $ZSHREP/configs/gitdelta; }
    __out() {
      case \${__status:0:2} in

        '??')
          $(_cmd_switch_battree \${~__path})                    ;;

        AM|MM|RM) print \"Unstaged changes:\n\"
          $pre git $repo_flag $gitcommand \
                  \${~__path} | __delta
                  print \"\nStaged changes:\n\"
          $pre git $repo_flag $gitcommand \
                  --cached \${~__path} | __delta                ;;

        'A '|'A.'|'M '|'M.'|'R '|'R.')
          $pre git $repo_flag $gitcommand \
          --cached -- \${~__oldpath} \${~__path} | __delta      ;;

        ' D'|'.D')  $pre git $repo_flag $gitcommand \
                    -- \${~__path} | __delta                    ;;
        'D '|'D.')  $pre git $repo_flag $gitcommand \
                    --cached -- \${~__path} | __delta           ;;

        *)  $pre git $repo_flag $gitcommand $select | __delta   ;;

      esac
    }
    if [[ -n \${__q} ]]; then
         __out | $(_ripgrep_highlight '${__q}' line)
    else __out; fi
    "
    --preview-window
    "$(_set_window 67 wrap-word 1)"
  )
}
