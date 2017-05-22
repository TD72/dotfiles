#! /bin/zsh

if [[ -f $HOME/.path ]]; then
    source $HOME/.path
else
    export DOTPATH="${0:A:t}"
fi

$DOTPATH/.bin/tmuxx

#======================================
# Setup zplug && Modules
#======================================
export ZPLUG_HOME=$XDG_CACHE_HOME/zplug
if [[ ! -d $ZPLUG_HOME ]] then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source $ZPLUG_HOME/init.zsh && zplug update
fi

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
  export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zplug"
  source $ZPLUG_HOME/init.zsh

  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      else
          echo
      fi
  fi
  zplug load
fi

if (which zprof > /dev/null 2>&1); then
  zprof
fi

