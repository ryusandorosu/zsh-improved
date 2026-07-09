function backward-kill-to-space() {
  local old_wordchars=$WORDCHARS
  WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:\|'
  zle backward-kill-word
  WORDCHARS=$old_wordchars
}
zle -N backward-kill-to-space
bindkey '^W' backward-kill-to-space
bindkey '^[w' backward-kill-word
bindkey '^H' kill-region
bindkey '^[T' transpose-chars
bindkey '^T' transpose-words
