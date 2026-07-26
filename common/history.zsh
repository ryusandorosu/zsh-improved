# HISTFILE="$HOME/.zsh_history"

HISTSIZE=1000000 # = 1M, in memory
SAVEHIST=1000000 # = 1M, on disk
HIST_STAMPS="yyyy-mm-dd"
# HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

setopt EXTENDED_HISTORY # записывать в историю время выполнения команды (формат: :start:elapsed;command)
setopt HIST_IGNORE_DUPS # игнорировать дубликаты команд если команда уже есть в истории
setopt HIST_IGNORE_ALL_DUPS # удалять старую запись если новая дубликат
setopt HIST_REDUCE_BLANKS # удалять лишние пробелы из команд перед сохранением
setopt HIST_SAVE_NO_DUPS # не сохранять дубликаты команд
setopt HIST_IGNORE_SPACE # не записывать команды начинающиеся с пробела

# -- conflicting options -- choose only one of them -- :
# setopt INC_APPEND_HISTORY # писать команды в файл истории сразу после выполнения а не при выходе
setopt SHARE_HISTORY # использовать общее хранилище истории во всех сеансах терминала
