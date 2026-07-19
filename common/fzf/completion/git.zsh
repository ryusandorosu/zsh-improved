source $ZSHREP/common/fzf/presets.sh

_fzf_git_repos() {
  fd --hidden --type dir --max-depth 6 '^\.git$' ~ | sed 's|.git/||' | sort -ru
}

_fzf_complete_gitls() {
  preview_tree "{}"
  _fzf_complete \
    --prompt="git> " \
    "${previef[@]}" \
    -- "$@" < <(_fzf_git_repos)
}

_fzf_complete_gitc() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitadd() { _fzf_complete_gitls "$@"; }
_fzf_complete_gitvim() { _fzf_complete_gitls "$@"; }
