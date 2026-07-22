bind_gitinfo() {
  local repo_root=$1
  local path=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""
  briefinfo=(
    --bind
    "focus:+transform-header:
    __status='$3'
    case \"\$__status\" in
      '??') print 'untracked'           ;;
      'M.') print 'staged, no changes'  ;;
      *)    echo -n 'to be staged:'
            git $repo_flag \
            diff-files --stat -- '$path' \
            | tail -n1 | cut -d, -f2-   ;;
    esac
    "
  )
}
