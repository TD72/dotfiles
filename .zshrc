#! /bin/zsh

if [[ -f $HOME/.path ]]; then
    source $HOME/.path
else
    export DOTPATH="${0:A:t}"
fi

$DOTPATH/.bin/tmuxx

for f in $HOME/.zsh/*.zsh; do
  source $f
done

for f in $XDG_CACHE_HOME/pac/etc/zsh/src/*.zsh; do
  source $f
done

if (which zprof > /dev/null 2>&1); then
  zprof
fi

