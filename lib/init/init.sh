#!/bin/bash

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/lib/vital.sh

if [ -z "$DOTPATH" ]; then
    echo '$DOTPATH not set' >&2
    exit 1
fi

sudo -v

while true
do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

for i in "$DOTPATH"/lib/init/"$(get_os)"/*.sh
do
    if [ -f "$i" ]; then
        log_info "$(e_arrow "$(basename "$i")")"
        if [ "${DEBUG:-}" != 1 ]; then
            bash "$i"
        fi
    else
        continue
    fi
done

log_pass "$0: Finish!!" | sed "s $DOTPATH \$DOTPATH g"
