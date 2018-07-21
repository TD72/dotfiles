#! /bin/zsh

# autocompile
if [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ]; then
  zcompile $HOME/.zshrc
fi

# set DOTPATH
if [[ -f $HOME/.path ]]; then
    source $HOME/.path
fi

# $DOTPATH/.bin/tmuxx


# autoload
autoload -Uz colors && colors
autoload -Uz compinit && compinit -c -d $ZSH_CACHE_DIR
autoload -Uz terminfo

zmodload zsh/zpty

# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind {{{
#bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'    forward-char
bindkey -M viins '^B'    backward-char
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
#bindkey -M viins '^R'    history-incremental-pattern-search-backward
bindkey -M viins '\er'   history-incremental-pattern-search-forward
bindkey -M viins '^Y'    yank
bindkey -M viins '^W'    backward-kill-word
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^G'    send-break
bindkey -M viins '^D'    delete-char-or-list

bindkey -M vicmd '^A'    beginning-of-line
bindkey -M vicmd '^E'    end-of-line
bindkey -M vicmd '^K'    kill-line
# bindkey -M vicmd '^P'    up-line-or-history
# bindkey -M vicmd '^N'    down-line-or-history
bindkey -M vicmd '^Y'    yank
bindkey -M vicmd '^W'    backward-kill-word
bindkey -M vicmd '^U'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward

# Original keybind
#
bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G'  end-of-line

# Surround a forward word by single quote
quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-single
bindkey -M viins '^Q' quote-previous-word-in-single

# Surround a forward word by double quote
quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-double
bindkey -M viins '^Xq' quote-previous-word-in-double

bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete
# }}}

#=================================
# functions
#=================================
autoload -Uz penv && penv
autoload -Uz nv && nv

autoload -Uz is_git_repo do-enter && zle -N do-enter && \
  bindkey '^m' do-enter

autoload -Uz replace_multiple_dots && zle -N replace_multiple_dots && \
  bindkey "." replace_multiple_dots

autoload -Uz dotpath && alias dot="dotpath"

# commandline edit using $EDITOR
autoload -Uz edit-command-line && zle -N edit-command-line && \
  bindkey '^x^x' edit-command-line

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

#---------------------------------------------
# Filter
#---------------------------------------------
disable r
autoload -Uz add-zsh-hook cdr chpwd_recent_dirs && \
  add-zsh-hook chpwd chpwd_recent_dirs && \
  zstyle ":chpwd:*" recent-dirs-max 100 && \
  zstyle ":chpwd:*" recent-dirs-default true && \
  zstyle ":chpwd:*" recent-dirs-pushd true && \
  zstyle ":chpwd:*" recent-dirs-file "$XDG_CACHE_HOME/zsh/chpwd-recent-dirs"

autoload -Uz kill-peco && zle -N kill-peco && \
  bindkey '^xk' kill-peco

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzy | xargs gibo'

alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | peco | cut -d" " -f1`'


autoload -Uz rg-edit && alias rge='rg-edit'

case ${OSTYPE} in
  linux*)
    alias ls='ls -F--color=auto'
    ;;
  darwin*)
    alias ls='gls -F --color=auto'
    ;;
esac

alias vi='nvim'
alias vim='nvim'

#---------------------------------------------
# Completion
#---------------------------------------------
setopt no_beep
setopt auto_pushd
setopt correct
setopt magic_equal_subst

### Complement ###
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types

### History ###
setopt bang_hist
# set execute time in history
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt magic_equal_subst
setopt extended_glob
setopt globdots
setopt extended_glob

zstyle ':completion:*default' menu select=2
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' verbose yes
# zstyle ':completion:*' \
  # completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' \
  format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' \
  format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' \
  format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

if [ -n "%LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

zstyle ':completion:*' use-cache true

zstyle ':completion:*' list-separator '-->'

#=================================
# misc source
#=================================
# Default Python Interpretor
. $HOME/.virtualenvs/default/bin/activate

# direnv
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

export NVIM_SOCKETS_DIR=$XDG_CACHE_HOME/nvimsockets
[[ ! -d $NVIM_SOCKETS_DIR ]] && mkdir -p $NVIM_SOCKETS_DIR

vimr() {
    NVIM_LISTEN_ADDRESS=$NVIM_SOCKETS_DIR/$1 vim ${@:2}
}

nvcd() {
    nvr -c "cd `pwd`"
}


# marzocchi/zsh-notify
zstyle ':notify:*' error-title
zstyle ':notify:*' success-title
zstyle ':notify:*' command-complete-timeout 15


#=================================
# pac source
#=================================
for f in $XDG_CACHE_HOME/pac/etc/zsh/src/*.zsh; do
  source $f
done

if (which zprof > /dev/null 2>&1); then
  zprof
fi

