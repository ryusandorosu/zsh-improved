bind_gitinfo() {
  local repo_flag
  [[ -n "$1" ]] && repo_flag="-C $1" || repo_flag=""
  # status_substr="$(awk '{xy = substr($0, 0, 2); print xy}' <<< "$3")"
  briefinfo=(
    --bind
    "focus:+transform-header:
    __path=$2
    __status=$3
    case \${__status:0:2} in

      '??') print 'untracked'                     ;;

      RM)   echo -n 'Renamed, to be staged:'
            git $repo_flag \
            diff-files --stat -- \${~__path} \
            | tail -n1 | cut -d, -f2-             ;;

      'M ') print 'Modified, staged, no changes'  ;;
      'M.') print 'Modified, staged, no changes'  ;;

      'R ') print 'Renamed, staged, no changes'   ;;
      'R.') print 'Renamed, staged, no changes'   ;;

      ' D') print 'Deleted, to be staged'         ;;
      '.D') print 'Deleted, to be staged'         ;;

      *)    echo -n 'to be staged:'
            git $repo_flag \
            diff-files --stat -- \${~__path} \
            | tail -n1 | cut -d, -f2-             ;;

    esac
    "
  )
}
