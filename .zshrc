#! /bin/zsh

if [[ -f ~/.path ]]; then
    source ~/.path
else
    export DOTPATH="${0:A:t}"
fi

$DOTPATH/.bin/tmuxx

#======================================
# Setup zplug && Modules
#======================================

if [[ ! -d ~/.zplug ]] then
  git clone https://github.com/zplug/zplug $HOME/.zplug
  source $HOME/.zplug/init.zsh && zplug update --self
fi

if [[ -f $HOME/.zplug/init.zsh ]]; then
  export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zplug"
  source ~/.zplug/init.zsh

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

