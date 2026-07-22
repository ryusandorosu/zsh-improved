#original: https://github.com/ChesterYue/ohmyzsh-theme-passion
main_prompt_color_time=$main_prompt_color
main_prompt_color_path=$main_prompt_color
main_prompt_color_git=$main_prompt_color
main_prompt_color_arrow=$arrow_color
main_prompt_bracket_open=''
main_prompt_bracket_close=''
cost_prompt_color_command=$cost_prompt_color
cost_prompt_color_time=$cost_prompt_color
cost_prompt_color_cost=$cost_prompt_color
cost_prompt_bracket_open=''
cost_prompt_bracket_close=' |'

source $ZSHREP/common/cmd_display.sh
# SCRIPT_DIRS=(
#     "$ZSHREP/common/commands"
#     "$ZSHREP/server/commands"
#     "$ZSHREP/fzf/command-scripts"
#     "$ZSHREP/fzf/command-functions"
# )

function _resolve_script_display_cmd() {
    # local raw_cmd="$1"
    # local cmd_name="${raw_cmd%% *}"
    # local cmd_args="${raw_cmd#* }"
    # [[ "$cmd_args" == "$cmd_name" ]] && cmd_args=""

    # ### look for scripts in certain dirs to enable eval show
    # local script_path=""
    # for dir in "${SCRIPT_DIRS[@]}"; do
    #     [[ -f "$dir/$cmd_name" ]] && { script_path="$dir/$cmd_name"; break; }
    # done
    # [[ -z "$script_path" ]] && return 1

    # read hook file to display eval command
    if [[ -f "$ZSH_SCRIPT_CMD_FILE" ]]; then
        cat "$ZSH_SCRIPT_CMD_FILE"
        return 0
    fi

    return 1
}
########################################################################################################

# gdate for macOS
# REF: https://apple.stackexchange.com/questions/135742/time-in-milliseconds-since-epoch-in-the-terminal
if [[ "$OSTYPE" == "darwin"* ]]; then
    {
        gdate
    } || {
        echo "\n$fg_bold[yellow]passion.zsh-theme depends on cmd [gdate] to get current time in milliseconds$reset_color"
        echo "$fg_bold[yellow][gdate] is not installed by default in macOS$reset_color"
        echo "$fg_bold[yellow]to get [gdate] by running:$reset_color"
        echo "$fg_bold[green]brew install coreutils;$reset_color";
        echo "$fg_bold[yellow]\nREF: https://github.com/ChesterYue/ohmyzsh-theme-passion#macos\n$reset_color"
    }
fi


# time
function real_time() {
    local color="%{$fg_no_bold[$main_prompt_color_time]%}";                    # color in PROMPT need format in %{XXX%} which is not same with echo
    local time="$main_prompt_bracket_open$(date +%H:%M:%S)$main_prompt_bracket_close";
    local color_reset="%{$reset_color%}";
    echo "${color}${time}${color_reset}";
}


# login_info
function login_info() {
    local color="%{$fg_no_bold[cyan]%}";                    # color in PROMPT need format in %{XXX%} which is not same with echo
    local ip
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        ip="$(ifconfig | grep ^eth1 -A 1 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        ip="$(ifconfig | grep ^en1 -A 4 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    fi
    local color_reset="%{$reset_color%}";
    echo "${color}[%n@${ip}]${color_reset}";
}


# directory
function directory() {
    local color="%{$fg_no_bold[$main_prompt_color_path]%}";
    # REF: https://stackoverflow.com/questions/25944006/bash-current-working-directory-with-replacing-path-to-home-folder
    local directory="${PWD/#$HOME/~}";
    local color_reset="%{$reset_color%}";
    echo "${color}$main_prompt_bracket_open${directory}$main_prompt_bracket_close${color_reset}";
}


# git
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[$main_prompt_color_git]%}$main_prompt_bracket_open";
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} ";
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_no_bold[red]%}*%{$fg_no_bold[$main_prompt_color_git]%}$main_prompt_bracket_close";
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_no_bold[$main_prompt_color_git]%}$main_prompt_bracket_close";

function update_git_status() {
    GIT_STATUS=$(_omz_git_prompt_info);
}

function git_status() {
    echo "${GIT_STATUS}"
}


# command
function update_command_status() {
    local arrow="";
    local color_reset="%{$reset_color%}";
    local reset_font="%{$fg_no_bold[white]%}";
    COMMAND_RESULT=$1;
    export COMMAND_RESULT=$COMMAND_RESULT
    if $COMMAND_RESULT; then
        arrow="%{$fg_bold[$main_prompt_color_arrow]%}❱";
    else
        arrow="%{$fg_bold[red]%}❱";
    fi
    COMMAND_STATUS="${arrow}${reset_font}${color_reset}";
}
update_command_status true;

function command_status() {
    echo "${COMMAND_STATUS}"
}


# output command execute after
output_command_execute_after() {
    if [ "$COMMAND_TIME_BEGIN" = "-20200325" ] || [ "$COMMAND_TIME_BEGIN" = "" ];
    then
        return 1;
    fi

    # show expanded alias if it differs from the input command
    local cmd;
    local resolved;
    resolved=$(_resolve_script_display_cmd "$LAST_CMD_RAW" 2>/dev/null);
    local color_cmd="";
    if $1; then
        color_cmd="$fg_no_bold[$cost_prompt_color_command]";
    else
        color_cmd="$fg_no_bold[red]";
    fi
    local color_reset="$reset_color";
    local color_alias="$fg_no_bold[$cost_prompt_color_command]";

    if [[ -n "$resolved" ]]; then
        # eval → real command
        cmd="${color_alias}${LAST_CMD_RAW} → ${color_reset}${color_cmd}${resolved}${color_reset}"
    elif [[ -n "$LAST_CMD_EXPANDED" && "$LAST_CMD_EXPANDED" != "$LAST_CMD_RAW" ]]; then
        # alias → real command
        cmd="${color_alias}${LAST_CMD_RAW} → ${color_reset}${color_cmd}${LAST_CMD_EXPANDED}${color_reset}";
    else
        cmd="${color_cmd}${LAST_CMD_RAW}${color_reset}";
    fi

    # time
    local time="$cost_prompt_bracket_open$(date +%H:%M:%S)$cost_prompt_bracket_close"
    local color_time="$fg_no_bold[$cost_prompt_color_time]";
    time="${color_time}${time}${color_reset}";

    # cost
    local time_end="$(current_time_millis)";
    local cost=$(bc -l <<<"${time_end}-${COMMAND_TIME_BEGIN}");
    COMMAND_TIME_BEGIN="-20200325"
    local length_cost=${#cost};
    if [ "$length_cost" = "4" ]; then
        cost="0${cost}"
    fi
    cost="${cost_prompt_bracket_open}cost ${cost}s${cost_prompt_bracket_close}"
    local color_cost="$fg_no_bold[$cost_prompt_color_cost]";
    cost="${color_cost}${cost}${color_reset}";

    # exit code
    [[ "$last_cmd_return_code" == 0 ]] && local color_exit="$fg_no_bold[$cost_prompt_color_cost]" || local color_exit="$fg_no_bold[red]";
    exitcode="${color_exit}returned ${last_cmd_return_code}:${color_reset}"

    echo -e "${time} ${cost} ${exitcode} ${cmd}";
}


# command execute before
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
preexec() { # cspell:disable-line
    exitcode="$?"
    COMMAND_TIME_BEGIN="$(current_time_millis)";
    # to show commands which aliases replace
    LAST_CMD_RAW="$1";
    LAST_CMD_EXPANDED="$2";
    # clean the hook file before each command
    rm -f "$ZSH_SCRIPT_CMD_FILE";
}

current_time_millis() {
    local time_millis;
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        time_millis="$(date +%s.%3N)";
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        time_millis="$(gdate +%s.%3N)";
    fi
    echo $time_millis;
}


# command execute after
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
precmd() { # cspell:disable-line
    # last_cmd
    last_cmd_return_code=$?; #was local
    local last_cmd_result=true;
    if [ "$last_cmd_return_code" = "0" ]; then
        last_cmd_result=true;
    else
        last_cmd_result=false;
    fi

    # update_git_status
    update_git_status;

    # update_command_status
    update_command_status $last_cmd_result;

    # output command execute after
    output_command_execute_after $last_cmd_result;
}


# set option
setopt PROMPT_SUBST; # cspell:disable-line


# timer
#REF: https://stackoverflow.com/questions/26526175/zsh-menu-completion-causes-problems-after-zle-reset-prompt
TMOUT=1;
TRAPALRM() { # cspell:disable-line
    if [ "$WIDGET" = "" ] || [ "$WIDGET" = "accept-line" ] ; then
        zle reset-prompt;
    fi
}


# prompt
# PROMPT='$(real_time) $(login_info) $(directory) $(git_status)$(command_status) ';
PROMPT='$(real_time) $(directory) $(git_status)$(command_status) ';
