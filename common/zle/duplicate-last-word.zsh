duplicate-last-word() {
  local -a words
  words=(${(z)LBUFFER})
  (( ${#words} >= 1 )) && LBUFFER+="${words[-1]}"
}

zle -N duplicate-last-word
