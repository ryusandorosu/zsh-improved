preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""

  case $gitcommand in
  diff)
    local path=$3
    ### got error. preview_git:11: command not found: git
    # local revision=$(git $repo_flag rev-parse --abbrev-ref --symbolic-full-name @{u}) #|| revision=HEAD
    ### commented because it is not used anyway, but curious to sort out
    [[ -n "$revision" ]] && select="'$revision' -- '$path'" || select="$path"
    ;;
  show)
    local commit=$3
    select=$commit
    ;;
  esac

  # to add a case whan a file is renamed (R). preview gets an old name as {2}, while new name is seems to be {3}. (RM) = modified after being staged, a different case
  previewcmd=(
    --preview
    "
    __status='$4'
    case \"\$__status\" in

      '??'|*A*)
        test -f '$path' && \
        bat --color=always --style=changes,numbers '$path' \
        || tree -C '$path'                                    ;;

      *D*)                                               exit ;;

      'M.') git $repo_flag $gitcommand --cached \
            --color=always --word-diff=plain $select          ;;

      MM)   print \"Unstaged changes:\n\"
            git $repo_flag $gitcommand \
            --color=always --word-diff=plain $select
            print \"\nStaged changes:\n\"
            git $repo_flag $gitcommand --cached \
            --color=always --word-diff=plain $select          ;;

      *)    git $repo_flag $gitcommand \
            --color=always --word-diff=plain $select          ;;

    esac
    "
    --preview-window
    'right,67%,wrap-word'
  )
}
