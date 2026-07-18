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
  # раскрыть ~
  print -r -- ${~base}
}

_fzf_complete_pwd() {
  local type="$1"
  local base=$(_fzf_base_dir "$prefix")
  if [[ $base == . ]]; then
    _fzf_complete -- "$@" < <(fd --strip-cwd-prefix=always --type $type .)
  else
    _fzf_complete -- "$@" < <(fd --type $type . "$base")
  fi
}

_fzf_complete_lah() { _fzf_complete_pwd d; }
_fzf_complete_l()   { _fzf_complete_lah "$@"; }
_fzf_complete_ls()  { _fzf_complete_lah "$@"; }
_fzf_complete_lsa() { _fzf_complete_lah "$@"; }

_fzf_complete_cat() { _fzf_complete_pwd f; }
_fzf_complete_bat() { _fzf_complete_cat "$@"; }
