#!/bin/zsh
#---------------------------------------------
# Powerline
#---------------------------------------------
function powerline_precmd() {
    PS1="$(powerline-go -error -$? -shell zsh -newline -east-asian-width -modules venv,host,ssh,cwd,perms,git,hg,jobs,exit,root)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi



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

# vi_prompt
# install_powerline_precmd

