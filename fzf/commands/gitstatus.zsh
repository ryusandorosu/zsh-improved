source $ZSHREP/fzf/presets.sh

gs() {
  if (( $# <= 2 )) && 
  ( [[ -n "$1" && "$(file $1)" =~ "No such file or directory" ]] && 
    [[ "$2" != --* ]] ); then

    git_commands=(
      add
      restore
    )
    for subcmd in "${git_commands[@]}"; do
      [[ "$1" == "$subcmd" ]] && gitsubcmd="$1"
    done
    shift

  elif (( $# == 2 || $# == 3 )) && [[ "$2" == --* ]]; then

    git_commands=(
      restore
      --staged
    )
    for subcmd in "${git_commands[@]}"; do
      for arg in "$@"; do
        [[ "$arg" == "$subcmd" ]] && gitsubcmd="$@"
      done
    done
    shift 2

  else gitsubcmd="add"; fi

  gitcmd=(git)

  _get_gitcmd_repo_path "$1"
  # preview_bat "${repo_path}{2}" git
  preview_git diff "$repo_path" "{2}" "{}" "{3}"
  bind_gitinfo "$repo_path" "{2}" "{}"

  execcmd=("${gitcmd[@]}")
  execcmd+=("$gitsubcmd")

  gitcmd+=(
    status
    --porcelain
  )

  bind_become "${(j: :)execcmd[@]}" "${repo_path}{+2}"
  "${gitcmd[@]}" \
  | parse_porcelain \
  | fzf \
    --prompt="${(j: :)execcmd[@]}> " \
    "${fzfdefaults[@]}" \
    "${previewcmd[@]}" \
    "${filedirinfo[@]}" \
    "${bindbecome[@]}" \
    --multi
}

parse_porcelain() {
  if [[ "${gitcmd[-1]}" =~ "--porcelain(=v1)?$" ]]; then
  # the whole string {} for $3(bind_gitinfo)/$4(preview_git) is passed because i coudnt find better way to save spaces to parse xy status fields correctly
    awk '{
      status = substr($0, 0, 2)
      if (!$4) {
        printf "%s %s\n", status, $2
      } else {
        printf "%s %s %s\n", status, $4, $2
      }
    }'
  elif [[ "${gitcmd[-1]}" == "--porcelain=v2" ]]; then
  # pass {1} to: $3 of bind_gitinfo() and $4 of preview_git()
    awk '{
      if ($1 == "?") {
        status="??"
        path=$2
        renamed=""
      } else if ($9 ~ /^R([0-9]{1,3})$/) {
        status=$2
        path=$10
        renamed=$11
      } else {
        status=$2
        path=$9
        renamed=""
      }
      print status " " path " " renamed
    }'
  fi
}
