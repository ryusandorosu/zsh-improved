_fzf_complete_alias() {
  _fzf_complete --prompt="alias> " \
    --delimiter='\t' \
    --with-nth=1 \
    -- "$@" < <(
      for k in "${(@k)aliases}"; do
        print -r -- "${k}"$'\t'"${aliases[$k]}"
      done | sort | grep -vP '^\s+'
    )
}

_fzf_complete_alias_post()   { cut -f1; }

_fzf_complete_unalias()      { _fzf_complete_alias "$@"; }
_fzf_complete_unalias_post() { _fzf_complete_alias_post; }

_fzf_complete_ralias() {
  _fzf_complete --prompt="reverse alias> " \
    --delimiter='\t' \
    --with-nth=1 \
    -- "$@" < <(
      for k in "${(@k)aliases}"; do
        [[ $k == "" ]] && continue
        print -r -- "${aliases[$k]}"$'\t'"${k}"
      done | grep -vP '^\s+|^$' | sort
    )
}
alias ralias='alias'
_fzf_complete_ralias_post() { cut -f2; }
