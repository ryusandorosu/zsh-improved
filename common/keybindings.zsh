### глянуть как будет записываться сочетание клавиш: showkey -a
### `bindkey` показывает текущую привязку виджетов zle к сочетаниям клавиш
### man zshzle

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

bindkey '^W'      backward-kill-to-space    # ctrl+w
bindkey '^[[3;2~' forward-kill-to-space     # shift+delete

duplicate-last-word() {
  local -a words
  words=(${(z)LBUFFER})
  (( ${#words} >= 1 )) && LBUFFER+="${words[-1]}"
}
zle -N duplicate-last-word
bindkey '^[1' duplicate-last-word           # alt+1

### redefinitions/reminders:

bindkey '^[w'     backward-kill-word        # alt+w
bindkey '^[d'     kill-word                 # alt+d           default
bindkey '^H'      kill-region               # ctrl+backspace
# bindkey '^[[3;2~' kill-line                 # shift+delete    default: ctrl+k   backward-kill-region
bindkey '^[[3;5~' kill-line                 # ctrl+delete     default: ctrl+k   backward-kill-region

## these conflict with wezterm keybindings
bindkey '^[T'     transpose-chars
bindkey '^T'      transpose-words

### fzf redefinitions:
bindkey '^F'      fzf-file-widget           # ctrl+f
