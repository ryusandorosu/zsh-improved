### FZF_CTRL_T_COMMAND: bindkey -r '^T' ### conflicts with zle transpose-words widget and wezterm

walkerskip=(
  .git
  .include
  .cache
  .vscode-server
  .cargo
  .docker
  '.local/lib'
  '.ansible/tmp'
  .npm
  node_modules
  target
)

fd=(
  fd
  --color
  always
  --one-file-system
  --follow
  --hidden
  --type
  file
)

locate=(
  locate
  --basename
)
[[ "$OS_ID" == ubuntu ]] && locate+=(--ignore-spaces)

export FZF_CTRL_T_COMMAND="${(j: :)locate[@]}"
export FZF_CTRL_T_OPTS="
  --walker file,follow,hidden
  --walker-skip ${(j:,:)walkerskip[@]}
  --walker-root '.' '$HOME'
  --style full
  --ansi
  --wrap
  --prompt '${FZF_CTRL_T_COMMAND%% *}> '
  --bind 'focus:+transform-header: file {} | fold --bytes --width=\$FZF_PREVIEW_COLUMNS'
  --preview-window='wrap-word'
  --preview '$ZSHREP/fzf/previews/ctrlt.sh {}'
  "
 # seems like --preview-window here also needs to be configured 
if [[ ${FZF_CTRL_T_COMMAND%% *} == locate ]]; then
  FZF_CTRL_T_OPTS+="
  --bind 'start:reload:$FZF_CTRL_T_COMMAND'
  --bind 'change:reload:sleep 0.1; $FZF_CTRL_T_COMMAND {q} -- || true'
  "
fi

export FZF_ALT_C_OPTS="
  --walker dir,follow,hidden
  --walker-skip ${(j:,:)walkerskip[@]}
  --walker-root '.' '$HOME' 
  --style full
  --wrap
  --prompt 'cd> '
  --preview '$ZSHREP/fzf/previews/altc.sh {}'
  "
