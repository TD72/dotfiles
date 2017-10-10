#!/bin/zsh

zstyle ':chpwd:*' recent-dirs-file "$XDG_CACHE_HOME/zsh/chpwd-recent-dirs"
function cdr-fzy {
  local path=$(cdr -l | awk '{ print $2 }' | fzy)
  if [ -n "$path" ]; then
        BUFFER="eval cd ${(q)path}"
        zle accept-line
  fi
  zle clear-screen
}
zle -N cdr-fzy
bindkey '^xj' cdr-fzy


function kill-peco {
  ps ax | peco | awk '{ print $1 }' | xargs kill -9
}
zle -N kill-peco
bindkey '^xk' kill-peco

function under-cd-dir {
  find . -type d -not -iwholename "*/.git/*" \
    | fzy \
    | cd
}
zle -N under-cd-dir
alias cdd=under-cd-dir
# bindkey '^\.' under-cd-dir

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzy | xargs gibo'

alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | peco | cut -d" " -f1`'


function rg-edit {
    local path=$(rg --line-number $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
    if [ -n "$path" ]; then
        echo "$EDITOR $path"
        eval $EDITOR $path
    fi
}
zle -N rg-edit
alias rge='rg-edit'

