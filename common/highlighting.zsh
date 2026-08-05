# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit

highlight_color="#d7af87" #~222
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets pattern regexp )

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=('\bsudo\b' fg=184,bold)
ZSH_HIGHLIGHT_STYLES[builtin]="fg=221"

ZSH_HIGHLIGHT_STYLES[command]="fg=221"
ZSH_HIGHLIGHT_STYLES[alias]="fg=228,bold"

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=172'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=172'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=241'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'

source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
