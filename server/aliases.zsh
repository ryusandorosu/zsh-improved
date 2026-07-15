# common
alias etcgit='sudo git -C /etc'
alias fd='fdfind'

# fail2ban
alias banlist='sudo fail2ban-client status $1'

alias banlog='sudo batcat /var/log/fail2ban.log'
alias authlog='sudo batcat /var/log/auth.log'
alias nftlog='sudo batcat /var/log/nftables.log'
