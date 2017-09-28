#!/bin/zsh

# anyframe's filter
zstyle ":anyframe:selector:peco:" command "peco-tmux"

bindkey '^xj' anyframe-widget-cdr

function cd-ghq {
  cd -G
}
zle -N cd-ghq
bindkey '^]' cd-ghq

function history-peco {
  history -iD 1 \
    | peco --prompt "Select history to copy:" \
    | cut -c 30- \
    | pbcopy
  pbpaste
}
function history-peco-execute {
  echo
  eval "$(history-peco "$1")"
}
zle -N history-peco-execute
bindkey '^r' history-peco-execute

bindkey '^xk' anyframe-widget-kill

function under-cd-dir {
  find . -type d -not -iwholename "*/.git/*" \
    | fzy \
    | cd
}
zle -N under-cd-dir
alias cdd=under-cd-dir
# bindkey '^\.' under-cd-dir

function anyframe-widget-git-add {
    git status --porcelain \
        | anyframe-selector-auto \
        | awk -F ' ' '{print $NF}' \
        | anyframe-action-execute git add
}
zle -N anyframe-widget-git-add
alias ga='anyframe-widget-git-add'

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzy | xargs gibo'

alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | peco | cut -d" " -f1`'


function ag-edit {
    local path=$(ag $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
    if [ -n "$path" ]; then
        echo "$EDITOR $path"
        eval $EDITOR $path
    fi
}
zle -N ag-edit
alias age='ag-edit'
