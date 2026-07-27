_ripgrep_highlight() {
  rgopts=(
    rg
    --no-config
    --passthru
    --color=always
    --colors='match:none'
    --colors='match:bg:yellow'
    --colors='match:fg:black'
    --colors='match:style:bold'
    --smart-case
    --fixed-strings
    --regexp="$1"
  )

  [[ -n "$2" && "$2" == line ]] && rgopts+=(--colors='highlight:bg:51,51,51')

  print -r -- "${rgopts[@]}"
}
