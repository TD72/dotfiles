#!/bin/zsh

# zmodload zsh/zprof && zprof

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir -p $XDG_CONFIG_HOME

export XDG_CACHE_HOME=$HOME/.cache
[[ ! -d $XDG_CACHE_HOME ]] && mkdir -p $XDG_CACHE_HOME

export XDG_DATA_HOME=$HOME/.local/share
[[ ! -d $XDG_DATA_HOME ]] && mkdir -p $XDG_DATA_HOME

export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR

# CUDA
export CUDA_HOME=/usr/local/cuda

# GO path
export GOPATH="$HOME"
export GOBIN="$GOPATH/bin"
export GO15VENDOREXPERIMENT=1

typeset -gx -U path
path=( \
  $HOME/.bin \
  $HOME/bin \
  $XDG_CACHE_HOME/pac/bin \
  $HOME/.virtualenvs/default/bin \
  /usr/local/go/bin:$GOBIN \
  # For osx
  /usr/local/opt/coreutils/libexec/gnubin \
  /usr/local/opt/openssl/bin \
  /Library/Tex/texbin \
  $CUDA_HOME/bin \
  # for Rust
  $HOME/.cargo/bin \
  #
  /usr/local/bin \
  "$path[@]" \
  )

typeset -gx -U fpath
fpath=( \
  $XDG_CACHE_HOME/pac/zsh/Completion/*(N-/) \
  $HOME/.zsh/Completion/(N-/) \
  $HOME/.zsh/functions/(N-/) \
  $fpath \
  )

# autoload
autoload -Uz edit-command-line
autoload -Uz colors && colors
autoload -Uz compinit && compinit -c -d $ZSH_CACHE_DIR
autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
add-zsh-hook chpwd chpwd_recent_dirs
autoload penv && penv

zmodload zsh/zpty


# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# EDITOR
export EDITOR=`which nvim`
export GIT_EDITOR=$EDITOR

# For OSX
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
  # for openssl
  export CPPFLAGS=-I/usr/local/opt/openssl/include
  export LDFLAGS=-L/usr/local/opt/openssl/lib
  export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH
  # for cuda
  export DYLD_LIBRARY_PATH=$CUDA_HOME/lib:$DYLD_LIBRARY_PATH
  # for llvm
  export PATH=/usr/local/opt/llvm/bin:$PATH

  alias ls='gls -F --color=auto'
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

# filter
export INTERACTIVE_FILTER="fzy:peco-tmux:fzf-tmux:peco"

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - --no-rehash)"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && \
  source $HOME/.tmuxinator/scripts/tmuxinator

# Git config profiles path
export GITCFG=$XDG_CONFIG_HOME/git-cfg

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH

# secrets
[[ -f ~/.secrets/secret.zsh ]] && source ~/.secrets/secret.zsh

