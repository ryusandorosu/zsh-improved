_get_editor() {
  local editor
  [[ -f "$(which nvim)" ]] && editor=nvim || editor=vim
  echo "$editor"
}

_set_window() {
  local percent=$1 wrap=$2 fixed_header=$3
  [[ -z $percent || $percent == default ]] && percent=58
  local parts=("${percent}%")
  [[ -n $wrap ]] && parts+=("${wrap}")
  [[ -n $fixed_header ]] && parts+=("~${fixed_header}")

  print -r -- "${(j:,:)parts[@]}"
  # [POSITION][,SIZE[%]][,border-STYLE][,[no]wrap][,wrap-word][,[no]follow][,[no]cycle][,[no]info][,[no]hidden][,+SCROLL[OFFSETS][/DENOM]][,~HEADER_LINES][,default][,<SIZE_THRESHOLD(ALTERNATIVE_LAYOUT)]
}
