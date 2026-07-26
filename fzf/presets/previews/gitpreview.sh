preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""

  case $gitcommand in
  diff)
    local localpath=$3
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
    __q={q}
    __delta() { delta --paging=never --color-only; }
    __out() {
      case \${__status:0:2} in

        '??')
          $(_cmd_switch_battree \${~__path})                    ;;

        AM|MM|RM)    print \"Unstaged changes:\n\"
              git $repo_flag $gitcommand $select | __delta
                  print \"\nStaged changes:\n\"
              git $repo_flag $gitcommand \
              --cached $select | __delta                        ;;

        'A '|'A.'|'M '|'M.'|'R '|'R.')
                  git $repo_flag $gitcommand \
                  --cached $select | __delta                    ;;

        ' D'|'.D')
              git $repo_flag $gitcommand -- $select | __delta   ;;

        *)    git $repo_flag $gitcommand $select | __delta      ;;

      esac
    }
    if [[ -n \${__q} ]]; then
         __out | $(_ripgrep_highlight '${__q}' line)
    else __out; fi
    "
    --preview-window
    '~1,right,67%,wrap-word'
  )
}
