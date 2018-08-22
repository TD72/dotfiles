#!/bin/zsh

# zmodload zsh/zprof && zprof
typeset -gx -U path
typeset -gx -U fpath
fpath=( \
  $XDG_CACHE_HOME/pac/etc/zsh/Completion/(N-/) \
  $HOME/.zsh/Completion/(N-/) \
  $HOME/.zsh/functions/(N-/) \
  $fpath \
  )

if [ -z $TMUX ]; then
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

  # node
  export NODEBREW_ROOT=$XDG_CACHE_HOME/nodebrew

  PYTHON_HOME=$XDG_CACHE_HOME/python
  export PYV_ROOT=$PYTHON_HOME/pythons
  export PYG_ROOT=$PYTHON_HOME/venvs
  export PYTHON_ROOT=$PYG_ROOT/default

  export GOV_ROOT=$XDG_CACHE_HOME/gov
  export GOROOT=$GOV_ROOT/versions/current

  path=( \
    $HOME/.bin(N-/) \
    $GOBIN(N-/) \
    $XDG_CACHE_HOME/pac/bin(N-/) \
    $NODEBREW_ROOT/current/bin(N-/) \
    $GOROOT/bin(N-/) \
    $HOME/.rbenv/bin(N-/) \
    $HOME/.virtualenvs/default/bin(N-/) \
    $CUDA_HOME/bin(N-/) \
    $HOME/.cargo/bin(N-/) \
    /usr/local/opt/llvm/bin(N-/) \
    /usr/local/opt/coreutils/libexec/gnubin(N-/) \
    /usr/local/opt/openssl/bin(N-/) \
    /Library/Tex/texbin(N-/) \
    /usr/local/bin(N-/) \
    $path \
    )


  # LANGUAGE
  export LANGUAGE="en_US.UTF-8"
  export LANG="${LANGUAGE}"
  export LC_ALL="${LANGUAGE}"
  export LC_CTYPE="${LANGUAGE}"

  # EDITOR
  export EDITOR=`which nvim`
  export GIT_EDITOR=$EDITOR

  # For OSX
  if uname | grep -q Darwin; then
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
    # for openssl
    export CPPFLAGS=-I/usr/local/opt/openssl/include
    export LDFLAGS=-L/usr/local/opt/openssl/lib
    export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH
    # for cuda
    export DYLD_LIBRARY_PATH=$CUDA_HOME/lib:$DYLD_LIBRARY_PATH
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
  export INTERACTIVE_FILTER="fzf"
  export FZF_DEFAULT_OPTS="--ansi --reverse --height 20"

  # rbenv
  eval "$(rbenv init - --no-rehash)"

  # tmuxinator
  [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && \
    source $HOME/.tmuxinator/scripts/tmuxinator

  # Git config profiles path
  export GITCFG=$XDG_CONFIG_HOME/git-cfg


  #=================================
  # Plugins
  #=================================
  # b4b4r07/emoji-cli
  export EMOJI_CLI_FILTER=$INTERACTIVE_FILTER
  export EMOJI_CLI_KEYBIND="^_"

  # b4b4r07/enhancd
  export ENHANCD_DIR=$XDG_CACHE_HOME/enhancd
  export ENHANCD_FILTER=$INTERACTIVE_FILTER
  export ENHANCD_COMMAND=cd
  export ENHANCD_DOT_SHOW_FULLPATH=1
  export ENHANCD_DISABLE_DOT=0
  export ENHANCD_DISABLE_HYPHEN=0
  export ENHANCD_DISABLE_HOME=1
  export ENHANCD_HOOK_AFTER_CD="ls"

  # b4b4r07/zsh-history
  export ZSH_HISTORY_FILE="$XDG_CACHE_HOME/zsh_history.db"
  export ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
  export ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
  export ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
  export ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
  export ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"

fi

# secrets
[[ -f ~/.secrets/secret.zsh ]] && source ~/.secrets/secret.zsh

