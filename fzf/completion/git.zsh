source $ZSHREP/fzf/presets/main.sh

_fzf_git_repos() {
  local base=$(_fzf_prefix_dir "$prefix")
  local expanded=${~base}
  if [[ $base == . ]]; then
    base="~"
    expanded=${~base}
  fi
  fd --hidden --type dir --max-depth 6 '^\.git$' "$expanded" \
    | sed 's|.git/||' \
    | while IFS= read -r line; do print -r -- "${base}${line#$expanded}"; done \
    | sort -ru
}

_fzf_complete_gitls() {
  preview_tree "{}"
  _fzf_complete \
    --prompt="git> " \
    "${previewcmd[@]}" \
    -- "$@" < <(_fzf_git_repos)
}

_fzf_complete_gitc()        { _fzf_complete_gitls "$@"; }

_fzf_complete_gitstatus()   { _fzf_complete_gitls "$@"; }
_fzf_complete_gitadd()      { _fzf_complete_gitls "$@"; }
_fzf_complete_gitrestore()  { _fzf_complete_gitls "$@"; }
_fzf_complete_gitstaged()   { _fzf_complete_gitls "$@"; }

_fzf_complete_gitvim()      { _fzf_complete_gitls "$@"; }

_fzf_complete_gitlog()      { _fzf_complete_gitls "$@"; }

_fzf_complete_gitgrep()     { _fzf_complete_gitls "$@"; }
_fzf_complete_gitgrepb()    { _fzf_complete_gitls "$@"; }
_fzf_complete_gitgrepf()    { _fzf_complete_gitls "$@"; }
