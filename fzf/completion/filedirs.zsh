_fzf_prefix_dir() {
  local prefix=$1
  local base
  if [[ -z $prefix ]]; then
    base="."
  elif [[ $prefix == */ ]]; then
    base="$prefix"
  else
    base=${prefix:h}
    [[ -z "$base" ]] && base="."
  fi
  print -r -- "$base"
}

_fzf_fd_completion() {
  local type="$1"
  shift
  local base=$(_fzf_prefix_dir "$prefix")
  local expanded=${~base}
  if [[ $base == . ]]; then
    _fzf_complete -- "$@" < <(fd --strip-cwd-prefix=always --type $type .)
  else
    _fzf_complete -- "$@" < <(fd --type $type . "$expanded" | while IFS= read -r line; do print -r -- "${base}${line#$expanded}"; done)
  fi
}

_fzf_fasd_completion() {
  local type="$1"
  shift
  local base=$(_fzf_prefix_dir "$prefix")
  local expanded=${~base}
  if [[ $base == . ]]; then
    _fzf_complete -- "$@" < <(fasd $type | awk '{print $2}' | tac)
  else
    _fzf_complete -- "$@" < <(fasd $type | awk '{print $2}' | tac | grep $expanded | while IFS= read -r line; do print -r -- "${base}${line#$expanded}"; done)
  fi
}

_fzf_complete_fvim()    { _fzf_fasd_completion -f "$@"; }
_fzf_complete_cdf()     { _fzf_fasd_completion -d "$@"; }

_fzf_complete_ls()      { _fzf_fd_completion d "$@"; }
_fzf_complete_l()       { _fzf_complete_ls "$@"; }
_fzf_complete_lsa()     { _fzf_complete_ls "$@"; }
_fzf_complete_lah()     { _fzf_complete_ls "$@"; }
_fzf_complete_laf()     { _fzf_fd_completion f "$@"; }
_fzf_complete_t()       { _fzf_complete_ls "$@"; }
_fzf_complete_lst()     { _fzf_complete_ls "$@"; }

_fzf_complete_cat()     { _fzf_fd_completion f "$@"; }
_fzf_complete_bat()     { _fzf_complete_cat "$@"; }
_fzf_complete_vim()     { _fzf_fd_completion f "$@"; }
_fzf_complete_nvim()    { _fzf_complete_vim "$@"; }
