kill-to-space() {
  local old_wordchars=$WORDCHARS
  WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:\|'
  zle $1
  WORDCHARS=$old_wordchars
}

backward-kill-to-space()  { kill-to-space backward-kill-word; }
forward-kill-to-space()   { kill-to-space kill-word; }

zle -N backward-kill-to-space
zle -N forward-kill-to-space
