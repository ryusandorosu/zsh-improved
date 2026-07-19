[[ $(alias lah) ]] && unalias lah
lah() { command /usr/bin/ls -laAhH "$@"; }
alias lah='lah --color=tty'
