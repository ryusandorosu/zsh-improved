alias digs='dig +short'
alias listen='sudo ss -tulpn | grep'
alias sed-crlf="sed -i 's/\r$//'"
alias sudo='sudo '
alias diffs='diff -sy --color'
alias rgrep="rgrep --color=auto --line-number --exclude-dir='.*'"
alias ripgrep='rg'
alias gc='git -C'
alias dfi='df -i'
alias motd='run-parts /etc/update-motd.d' # not sure that is suitable for macos
alias t='tree --metafirst -shD --du'
alias tl='t -L'
alias lst='tree --metafirst -gup -shD --du'
alias llt='lst -L'
