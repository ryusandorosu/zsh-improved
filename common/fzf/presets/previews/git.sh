preview_git() {
  local gitcommand=$1
  local select

  local repo_root=$2
  local repo_flag
  [[ -n "$repo_root" ]] && repo_flag="-C $repo_root" || repo_flag=""

  case $gitcommand in
  diff)
    local revision=$4
    [[ -z "$revision" ]] && revision=$(git $repo_flag rev-parse --abbrev-ref --symbolic-full-name @{u}) #|| revision=HEAD
    local path=$3
    [[ -n "$revision" ]] && select="'$revision' -- '$path'" || select="$path"
    ;;
  show)
    local commit=$3
    select=$commit
    ;;
  esac

  previewcmd=(
    --preview
    "git $repo_flag $gitcommand --color=always --word-diff=color $select"
    --preview-window
    'right,67%,wrap-word'
  )
}
