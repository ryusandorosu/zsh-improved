# Установка
Клонировать репозиторий и запустить `init.sh` через bash (sh не поддерживается) или выполнить в командной строке:
```
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/ryusandorosu/zsh-improved/refs/heads/main/init.sh")"
```
Скрипт делает базовый минимум: клонирование репозитория и создание символической ссылки на репозиторий вместо оригинального ~/.zshrc.  
Вся остальная инициализация плагинов и их зависимостей автоматизирована при загрузке ~/.zshrc, в том числе oh-my-zsh и fzf.  
Удаление: заменить символическую ссылку `~/.zshrc` на `~/.zshrc.backup`, забекапленный скриптом перед установкой.  

s21 mac reminders:
- omz location: `/System/Volumes/Data/Users/kaycekey/.oh-my-zsh`
- fullscreen hotkey: `fn + f`
