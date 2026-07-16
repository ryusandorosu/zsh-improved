#- gitc|gitls ** must sort out of fasd folders only repos
#- compdef _ssh autossh

# _gitvim() {
#   repo_path=$(git -C "$1" rev-parse --show-toplevel)
#   _wanted files expl 'git files' \
#     compadd -- "$(git -C "$repo_path" ls-files --full-name)"
# }
# compdef _gitvim gitvim
