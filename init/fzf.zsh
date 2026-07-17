source $ZSHREP/init/definitions.zsh

define_fzf_location_for_zsh() {
  local brewpath="$1"
  local fzfversion=$(
    $brewpath/Cellar/fzf/*/bin/fzf --version \
    | cut -d' ' -f1
  )
  export FZF_BASE=$brewpath/Cellar/fzf/$fzfversion/shell
}

[[ "$OS_ID" != Darwin ]] && {
  define_fzf_location_for_zsh $linuxbrew_location
} || {
  define_fzf_location_for_zsh $goinfre_brew_location
}
