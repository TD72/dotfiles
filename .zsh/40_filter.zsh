#!/bin/zsh

# anyframe's filter
zstyle ":anyframe:selector:peco:" command "peco-tmux"

bindkey '^xj' anyframe-widget-cdr
# bindkey '^]' anyframe-widget-cd-ghq-repository
function cd-ghq {
  cd -g
}
zle -N cd-g
bindkey '^]' cd-g

# bindkey '^R' anyframe-widget-execute-history
bindkey '^r' anyframe-widget-put-history

# alias gc='anyframe-widget-checkout-git-branch'
# alias gci='anyframe-widget-insert-git-branch'
bindkey '^xk' anyframe-widget-kill
# bindkey '^]' anyframe-widget-insert-filename
# bindkey '^]' anyframe-widget-tmux-attach
# bindkey '^]' anyframe-widget-select-widget


function anyframe-widget-git-add {
    git status --porcelain \
        | anyframe-selector-auto \
        | awk -F ' ' '{print $NF}' \
        | anyframe-action-execute git add
}
zle -N anyframe-widget-git-add
alias ga='anyframe-widget-git-add'

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | peco | xargs gibo'

alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | peco | cut -d" " -f1`'



# function agvim() {#{{{
#     local path=$(ag $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
#     if [ -n "$path" ]; then
#         echo "vim $path"
#         vim $path
#     fi
# }
# #}}}

