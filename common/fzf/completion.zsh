# compdef _du duh
# compdef _sed findsed
# compdef _apt 'apt list'

_fzf_base_dir() {
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

_fzf_complete_pwd() {
  local type="$1"
  local base=$(_fzf_base_dir "$prefix")
  local expanded=${~base}
  if [[ $base == . ]]; then
    _fzf_complete -- "$@" < <(fd --strip-cwd-prefix=always --type $type .)
  else
    _fzf_complete -- "$@" < <(fd --type $type . "$expanded" | while IFS= read -r line; do print -r -- "${base}${line#$expanded}"; done)
    # _fzf_complete -- "$@" < <(fd --type $type . "$expanded" | sed "s|^${expanded}|${base}|")
  fi
}

_fzf_complete_lah() { _fzf_complete_pwd d; }
_fzf_complete_l()   { _fzf_complete_lah "$@"; }
_fzf_complete_ls()  { _fzf_complete_lah "$@"; }
_fzf_complete_lsa() { _fzf_complete_lah "$@"; }

_fzf_complete_cat() { _fzf_complete_pwd f; }
_fzf_complete_bat() { _fzf_complete_cat "$@"; }
_fzf_complete_vim() { _fzf_complete_pwd f; }
_fzf_complete_nvim()   { _fzf_complete_vim "$@"; }
_fzf_complete_neovim() { _fzf_complete_vim "$@"; }
