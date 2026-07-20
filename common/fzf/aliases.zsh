[[ $(alias lah) ]] && unalias lah
lah() { command /usr/bin/ls -laAh "$@"; }
alias lah='lah --color=tty'

alias gitstatus='gitadd status'
