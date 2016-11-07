#!/bin/zsh
#---------------------------------------------
# Powerline
#---------------------------------------------
function powerline_precmd() {
export PROMPT="
$(python ~/.zplug/repos/TD72/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)
                $ "
}

function install_powerline_precmd() {
for s in "${precmd_functions[@]}" ; do
  if [ "$s" = "powerline_precmd" ] ; then
    return
  fi
done
precmd_functions+=(powerline_precmd)
}


function vi_prompt() {
    RPROMPT="%{$bg[green]%}-- INSERT --%{$reset_color%}"
    function zle-keymap-select zle-line-init zle-line-finish
    {
        case $KEYMAP in
            main|viins)
                PROMPT_2="%{$fg[white]$bg[green]%}-- INSERT --%{$reset_color%}"
                ;;
            vicmd)
                PROMPT_2="%{$fg[white]$bg[cyan]%}-- NORMAL --%{$reset_color%}"
                ;;
            vivis|vivli)
                PROMPT_2="%{$fg[white]$bg[yellow]%}-- VISUAL --%{$reset_color%}"
                ;;
        esac

        RPROMPT=$PROMPT_2
        zle reset-prompt
    }

    zle -N zle-line-init
    zle -N zle-line-finish
    zle -N zle-keymap-select
    zle -N edit-command-line
}


vi_prompt
install_powerline_precmd

#
# function notify_precmd {
#     prev_command_status=$?
#
#     if [[ "$TTYIDLE" -gt 10 ]]; then
#         notify_title=$([ "$prev_command_status" -eq 0 ] && echo "Command succeeded!" || echo "Command failed")
#         notify-send "$notify_title\n$prev_command " --icon=dialog-information
#     fi
# }
#
# function store_command {
#   prev_command=$2
# }
#
# add-zsh-hook preexec store_command
# add-zsh-hook precmd notify_precmd
