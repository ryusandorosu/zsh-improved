source $ZSHREP/fzf/presets.sh

# git diff --name-only; git diff --compact-summary; --color-moved=default; --diff-algorithm=default; --find-renames
# ^ same for git show ^, may be useful for gitlog.zsh / preview_git()
### to replace it
### alias gitgrep='git grep --heading --line-number --before-context=2 --after-context=1'

# man ripgrep
#        --context-separator=SEPARATOR
#            The  string  used  to  separate non-contiguous context lines in the output. This is only used when one of the context flags is used (that is, -A/--after-context, -B/--before-context or -C/--context). Escape sequences like
#            \x7F or \t may be used. The default value is --.

# man git diff
#  -D, --irreversible-delete
#      Omit the preimage for deletes, i.e. print only the header but not the diff between the preimage and /dev/null. The resulting patch is not meant to be applied with patch or git apply; this is solely for people who want to
#      just concentrate on reviewing the text after the change. In addition, the output obviously lacks enough information to apply such a patch in reverse, even manually, hence the name of the option.
#      When used together with -B, omit also the preimage in the deletion part of a delete/create pair.
#  -R
#      Swap two inputs; that is, show differences from index or on-disk file to tree contents.


# old gitgrep
ggrep() {
  gitcmd=(git)
  _get_gitcmd_repo_path "$1"

  gitcmd+=(
    grep
    --line-number
    "."
  )

  bind_become "$(_get_editor)" "${repo_path}{1}" "+{2}"
  "${gitcmd[@]}" \
  | fzf "${fzfdefaults[@]}" \
        --prompt="git-grep to $(_get_editor)> " \
        --delimiter : \
        --preview "$(
          _cmd_bat_context "${repo_path}{1}" {2}
        )" \
        "${bindbecome[@]}"
}
