#!/bin/zsh

# zmodload zsh/zprof && zprof
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

zmodload zsh/zpty


# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# EDITOR
export EDITOR=`which nvim`
export GIT_EDITOR=$EDITOR

export PATH=~/bin:$PATH
export PATH=~/.bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

# for osx
if [ -d /usr/local/opt/coreutils/libexec/gnubin ] ; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
  alias ls='ls --color=auto -F'
  export PATH=~/Library/python/3.5/bin:$PATH
fi
if [ -d /Library/Tex/texbin ]; then
  export PATH=/Library/Tex/texbin:$PATH
fi
if uname | grep -q Linux; then
  alias ls='ls --color=auto -F'
fi

# GO path
export GOPATH="$HOME"
export GOBIN="$GOPATH/bin"
export GO15VENDOREXPERIMENT=1
export PATH=/usr/local/go/bin:$GOBIN:$PATH

# XDG config home
[[ ! -d ~/.config ]] && mkdir ~/.config
export XDG_CONFIG_HOME=~/.config

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export LISTMAX=50


# ls
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


# filter
export INTERACTIVE_FILTER="fzy:peco-tmux:fzf-tmux:peco"

# emoji cli
export EMOJI_CLI_FILTER="fzy:peco:fzf"
export EMOJI_CLI_KEYBIND="^_"

# enhancd
export ENHANCD_FILTER="fzy:peco-tmux:fzf-tmux:peco"
export ENHANCD_COMMAND=cd
export ENHANCD_DOT_SHOW_FULLPATH=1
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HYPHEN=0
export ENHANCD_DISABLE_HOME=1
# export ENHANCD_HOOK_AFTER_CD="ls"

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
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# for Rust
export PATH=$HOME/.cargo/bin:$PATH

# Git config profiles path
export GITCFG=$XDG_CONFIG_HOME/git-cfg

# secrets
[[ -f ~/.secrets/secret.zsh ]] && source ~/.secrets/secret.zsh
