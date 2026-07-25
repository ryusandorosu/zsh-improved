preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""

  case $gitcommand in
  diff)
    local localpath=$3
    ### got error. preview_git:11: command not found: git
    # local revision=$(git $repo_flag rev-parse --abbrev-ref --symbolic-full-name @{u}) #|| revision=HEAD
    ### commented because it is not used anyway, but curious to sort out
    [[ -n "$revision" ]] && select="${revision} -- ${localpath}" || select="$localpath"
    ;;
  show)
    local commit=$3
    select=$commit
    ;;
  esac

  # possibly to show --cached when a file is deleted
  # possibly use _cmd_switch_battree for ??|A
  previewcmd=(
    --preview
    "
    [[ -z $select ]] && return
    __status=$4
    __path=$localpath
    __q={q}
    __delta() { delta --paging=never --color-only; }
    __out() {
      case \${__status} in

        '??'|*A*)
          test -f \${~__path} \
            && { bat \
               --color=always \
               --style=changes,numbers \
               \${~__path} \
            } || { tree -C \${~__path} }                        ;;

        *D*)                                               exit ;;

        'M.'|'R.') git $repo_flag $gitcommand \
                   --cached $select | __delta                   ;;

        MM|RM)    print \"Unstaged changes:\n\"
              git $repo_flag $gitcommand $select | __delta
                  print \"\nStaged changes:\n\"
              git $repo_flag $gitcommand \
              --cached $select | __delta                        ;;

        RM)   git $repo_flag $gitcommand $select | __delta      ;;

        *)    git $repo_flag $gitcommand $select | __delta      ;;

      esac
    }
    if [[ -n \${__q} ]]; then __out | \
      rg --passthru \
         --color=always \
         --colors 'match:none' \
         --colors 'match:bg:yellow' \
         --colors 'match:fg:black' \
         --colors 'match:style:bold' \
         --colors 'highlight:bg:51,51,51' \
         --smart-case \
         --fixed-strings \
         --regexp \${__q}
    else __out; fi
    "
    --preview-window
    'right,67%,wrap-word'
  )
}
