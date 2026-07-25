bind_gitinfo() {
  local repo_flag
  [[ -n "$1" ]] && repo_flag="-C $1" || repo_flag=""
  briefinfo=(
    --bind
    "focus:+transform-header:
    __path=$2
    __status=$3
    case \${__status} in

      '??') print 'untracked'                     ;;

      'M.') print 'Modified, staged, no changes'  ;;

      'R.') print 'Renamed, staged, no changes'   ;;

      RM)   echo -n 'Renamed, to be staged:'
            git $repo_flag \
            diff-files --stat -- \${~__path} \
            | tail -n1 | cut -d, -f2-             ;;

      *)    echo -n 'to be staged:'
            git $repo_flag \
            diff-files --stat -- \${~__path} \
            | tail -n1 | cut -d, -f2-             ;;

    esac
    "
  )
}
