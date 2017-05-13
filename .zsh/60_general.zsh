#!/bin/zsh

# Default Python Interpretor
. $HOME/.virtualenvs/default/bin/activate

# direnv
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi
# vim:set fenc=utf-8 ff=unix expandtab sw=4 ts=4:
