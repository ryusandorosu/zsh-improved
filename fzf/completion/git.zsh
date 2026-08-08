source $ZSHREP/fzf/presets.sh

_fzf_git_repos() {
  local base=$(_fzf_prefix_dir "$prefix")
  local expanded=${~base}
  if [[ $base == . ]]; then
    base="~"
    expanded=${~base}
  fi
  fd --hidden --type dir --max-depth 2 '^\.git$' "$expanded" \
    | sed 's|.git/||' \
    | while IFS= read -r line; do print -r -- "${base}${line#$expanded}"; done \
    | sort -ru
}

_fzf_complete_gitls() {
  preview_tree "{}" header
  _fzf_complete \
    --prompt="git> " \
    "${previewcmd[@]}" \
    -- "$@" < <(_fzf_git_repos)
}

_fzf_complete_gc()     { _fzf_complete_gitls "$@"; }

_fzf_complete_gs()     { _fzf_complete_gitls "$@"; }
_fzf_complete_ga()     { _fzf_complete_gitls "$@"; }
_fzf_complete_gr()     { _fzf_complete_gitls "$@"; }
_fzf_complete_gst()    { _fzf_complete_gitls "$@"; }

_fzf_complete_glog()   { _fzf_complete_gitls "$@"; }
_fzf_complete_gsh()    { _fzf_complete_gitls "$@"; }
_fzf_complete_gg()     { _fzf_complete_gitls "$@"; }
_fzf_complete_gch()    { _fzf_complete_gitls "$@"; }

_fzf_complete_ggedit() { _fzf_complete_gitls "$@"; }
