alias digs='dig +short'
alias listen='sudo ss -tulpn | grep'
alias sed-crlf="sed -i 's/\r$//'"
alias bat='batcat'
alias lah='ls -lah'
alias gitc='git -C'
alias gitls='git ls-files'
alias sudo='sudo '
alias diffs='diff -sy --color'

#fzf-using aliases:
alias gitlog="git log --oneline | fzf --multi --style=full --preview 'git show --color {+1}'"
alias gitgrep="git grep . | fzf --preview 'echo {1} | cut -d: -f1 | xargs -r batcat --color=always'"
alias ffind="fd . '/' | fzf --style=full --preview='fzf-preview.sh {}'"
alias floc="locate -b . | fzf --style=full --preview='fzf-preview.sh {}'"
