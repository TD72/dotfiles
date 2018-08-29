#! /bin/zsh

# autocompile
[[ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]] && zcompile $ZDOTDIR/.zshrc

autoload -Uz tmux-filter && \
  alias t="tmux-filter"

[[ -z $TMUX ]] && tmux-filter

# set DOTPATH
[[ -f $HOME/.path ]] && source $HOME/.path

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
# bindkey -M viins '^P'    up-line-or-history
# bindkey -M viins '^N'    down-line-or-history
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
autoload -Uz nv
autoload -Uz pyg

autoload -z do-enter && \
  zle -N do-enter && \
  bindkey '^m' do-enter

autoload -Uz replace_multiple_dots && \
  zle -N replace_multiple_dots && \
  bindkey "." replace_multiple_dots

autoload -Uz dotpath && \
  alias dot="dotpath"

# commandline edit using $EDITOR
autoload -Uz edit-command-line && \
  zle -N edit-command-line && \
  bindkey '^x^x' edit-command-line

#=============================================
# Prompt
#=============================================
export VIRTUAL_ENV_DISABLE_PROMPT=1
sep=""
PROMPT="%F{008}%K{011} %D  %* %F{011}%k${sep}
%F{008}%K{004}$ %F{004}%k${sep} "

#=============================================
# Filter
#=============================================
disable r
autoload -Uz add-zsh-hook cdr chpwd_recent_dirs && \
  add-zsh-hook chpwd chpwd_recent_dirs && \
  zstyle ":chpwd:*" recent-dirs-max 100 && \
  zstyle ":chpwd:*" recent-dirs-default true && \
  zstyle ":chpwd:*" recent-dirs-pushd true && \
  zstyle ":chpwd:*" recent-dirs-file "$XDG_CACHE_HOME/zsh/chpwd-recent-dirs"

autoload -Uz kill-peco && \
  zle -N kill-peco && \
  bindkey '^xk' kill-peco

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | ${INTERACTIVE_FILTER} | xargs gibo'

alias -g P='`docker ps | tail -n +2 | ${INTERACTIVE_FILTER} | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | ${INTERACTIVE_FILTER} | cut -d" " -f1`'

autoload -Uz rg-edit && \
  alias rge='rg-edit'

if builtin command -v exa > /dev/null; then
  alias ls='exa'
else
  case ${OSTYPE} in
    linux*)
      alias ls='ls -F --color=auto'
      ;;
    darwin*)
      alias ls='gls -F --color=auto'
      ;;
  esac
fi

alias a="ls -a"
alias l="ls -l"
alias la="ls -la"

alias vi='nvim'
alias vim='nvim'
alias tmux="tmux -2 -u"
alias b="cd ${OLDPWD}"

#=============================================
# Completion
#=============================================
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

[[ -n "%LS_COLORS" ]] && zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' use-cache true

zstyle ':completion:*' list-separator '-->'

#=================================
# misc source
#=================================
# Default Python Interpretor
[[ -d $PYTHON_ROOT ]] && source $PYTHON_ROOT/bin/activate

# direnv
type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

export NVIM_SOCKETS_DIR=$XDG_CACHE_HOME/nvim/sockets
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

type zprof > /dev/null 2>&1

