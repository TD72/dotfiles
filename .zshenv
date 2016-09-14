#!/bin/zsh


typeset -gx -U fpath
fpath=( \
    ~/.zsh/Completion(N-/) \
    ~/.zsh/functions(N-/) \
    $fpath \
    )

# autoload
autoload -Uz edit-command-line
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
add-zsh-hook chpwd chpwd_recent_dirs



# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# EDITOR
export EDITOR=nvim
export GIT_EDITOR=nvim

export PATH=~/bin:$PATH
export PATH=~/.bin:$PATH
export PATH=~/.local/bin:$PATH

# GO path
export GOPATH="$HOME"
export GOBIN="$GOPATH/bin"
export PATH=/usr/local/go/bin:$PATH

export XDG_CONFIG_HOME=~/.config
[[ ! -d ~/.config ]] && mkdir ~/.config

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
export LISTMAX=50

# if [[ $UID == 0 ]]; then
#     unset HISTFILE
#     export SAVEHIST=0
# fi

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

export INTERACTIVE_FILTER="peco-tmux:fzf-tmux:peco"


[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# Git config profiles path
export GITCFG=$XDG_CONFIG_HOME/git-cfg

[[ -f ~/.secrets/secret.zsh ]] && source ~/.secrets/secret.zsh

