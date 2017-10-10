#!/bin/zsh

# zmodload zsh/zprof && zprof

typeset -gx -U path
path=( \
  $HOME/.bin \
  $HOME/bin \
  $HOME/.virtualenvs/default/bin \
  /usr/local/bin \
  "$path[@]" \
  )

typeset -gx -U fpath
fpath=( \
    $HOME/.zsh/Completion(N-/) \
    $HOME/.zsh/functions(N-/) \
    $fpath \
    )

# autoload
autoload -Uz edit-command-line
autoload -Uz colors && colors
autoload -Uz compinit && compinit -d $ZSH_CACHE_DIR
autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
add-zsh-hook chpwd chpwd_recent_dirs

zmodload zsh/zpty


# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# EDITOR
export EDITOR=`which nvim`
export GIT_EDITOR=$EDITOR

# GO path
export GOROOT=/usr/local/opt/go/libexec
export GOPATH="$HOME"
export GOBIN="$GOPATH/bin"
export PATH=/usr/local/go/bin:$GOBIN:$PATH
export GO15VENDOREXPERIMENT=1

# for osx
if [ -d /usr/local/opt/coreutils/libexec/gnubin ] ; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
  # for openssl
  export PATH=/usr/local/opt/openssl/bin:$PATH
  export CPPFLAGS=-I/usr/local/opt/openssl/include
  export LDFLAGS=-L/usr/local/opt/openssl/lib
  export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH
  alias ls='gls -F --color=auto'
fi
if [ -d /Library/Tex/texbin ]; then
  export PATH=/Library/Tex/texbin:$PATH
fi
if uname | grep -q Linux; then
  alias ls='ls --color=auto -F'
fi
# ls
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# History
export HISTFILE=$ZSH_CACHE_DIR/zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export LISTMAX=50

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir -p $XDG_CONFIG_HOME

export XDG_CACHE_HOME=$HOME/.cache
[[ ! -d $XDG_CACHE_HOME ]] && mkdir -p $XDG_CACHE_HOME

export XDG_DATA_HOME=$HOME/.local/share
[[ ! -d $XDG_DATA_HOME ]] && mkdir -p $XDG_DATA_HOME

export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR



# filter
export INTERACTIVE_FILTER="fzy:peco-tmux:fzf-tmux:peco"

# CUDA
export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
# for osx
export DYLD_LIBRARY_PATH=$CUDA_HOME/lib:$DYLD_LIBRARY_PATH

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && \
  source $HOME/.tmuxinator/scripts/tmuxinator


# Git config profiles path
export GITCFG=$XDG_CONFIG_HOME/git-cfg

# for Rust
export PATH=$HOME/.cargo/bin:$PATH

# node
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
npm_dir=${NVM_PATH}_modeuls
export NODE_PATH=$npm_dir

# secrets
[[ -f ~/.secrets/secret.zsh ]] && source ~/.secrets/secret.zsh

