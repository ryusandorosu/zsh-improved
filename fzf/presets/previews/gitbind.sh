bind_gitinfo() {
  local repo_flag pre
  [[ -n "$1" ]] && repo_flag="-C $1" || repo_flag=""
  [[ -n "$1" || "$1" == /etc ]] && pre=sudo
  briefinfo=(
    --bind
    "focus:+transform-header:
    __path=$2
    __status=$3
    __status=\${__status:0:2}
    case \$__status in

      '??')      print 'untracked'                     ;;

      'A '|'A.') print 'Added, staged, no changes'     ;;

      'M '|'M.') print 'Modified, staged, no changes'  ;;

      'R '|'R.') print 'Renamed, staged, no changes'   ;;

      'D '|'D.') print 'Deleted, staged'               ;;

      ' D'|'.D') print 'Deleted, to be staged'         ;;

      *)    
        [[ \$__status == *M ]] && __print='Modified, '
        [[ \$__status == AM ]] && __print='Added, '
        [[ \$__status == RM ]] && __print='Renamed, '
        [[ \$__status == *M ]] && echo -n \$__print
            echo -n 'to be staged:'
              $pre git $repo_flag \
              diff-files --stat -- \${~__path} \
              | tail -n1 | cut -d, -f2-                ;;

    esac
    "
  )
}
