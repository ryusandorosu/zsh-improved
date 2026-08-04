### man zshzle
### `showkey -a`  to see how keybindings are coded
### `bindkey`     to see current keybindings on zle widgets

### custom zle widgets

bindkey '^W'      backward-kill-to-space    # ctrl+w
bindkey '^[[3;2~' forward-kill-to-space     # shift+delete

bindkey '^[1'     duplicate-last-word           # alt+1

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
