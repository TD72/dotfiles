#!/bin/zsh

# Default Python Interpretor
. $HOME/.virtualenvs/default/bin/activate

# direnv
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

export NVIM_SOCKETS_DIR=$XDG_CACHE_HOME/nvimsockets
mkdir -p $NVIM_SOCKETS_DIR

vimr() {
    NVIM_LISTEN_ADDRESS=$NVIM_SOCKETS_DIR/$1 vim ${@:2}
}

nvcd() {
    nvr -c "cd `pwd`"
}


# vim:set fenc=utf-8 ff=unix expandtab sw=4 ts=4:
