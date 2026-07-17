source $ZSHREP/common/fzf/presets.sh

# compdef _du duh
# compdef _sed findsed
# compdef _apt 'apt list'

# lah:
_fzf_complete_lah() {
  _fzf_complete -- "$@" < <(fd . '/' --type d) # 2>/dev/null
}

# ssh|autossh:
_fzf_ssh_hosts() {
  { [[ -r ~/.ssh/config ]] && \
    grep -i '^\s*host\s' ~/.ssh/config \
    | awk '{for(i=2;i<=NF;i++) print $i}'
  } | grep -v '[*?]' | sort -u
}
_fzf_complete_ssh() {
  _fzf_complete --prompt="ssh> " \
  --preview='ping -c1 $(ssh -G {} 2>/dev/null | grep "^hostname " | cut -d" " -f2)' \
  -- "$@" < <(_fzf_ssh_hosts)
}
_fzf_complete_autossh() { _fzf_complete_ssh "$@"; }

# gitc|gitls|gitvim:
# use fd?
# _fzf_git_repos() {
#   # fasd -d 2>/dev/null | awk '{print $2}' \
#   fasd -d | awk '{print $2}' \
#     | while read -r d; do
#         [[ -d "$d/.git" ]] && print -r -- "$d"
#       done \
#     | sort -u
# }
_fzf_git_repos() {
  # fd -H -t d -d 6 '^\.git$' ~ 2>/dev/null | sed 's#/\.git$##' | sort -u
  fd --hidden --type dir --max-depth 6 '^\.git$' ~ | sed 's|.git/||' | sort -ru
}
_fzf_complete_gitls() {
  _fzf_complete --prompt="git> " \
    "${tree_view[@]}" \
    -- "$@" < <(_fzf_git_repos)
}
_fzf_complete_gitc() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitadd() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitvim() { _fzf_complete_gitls "$@"; }
