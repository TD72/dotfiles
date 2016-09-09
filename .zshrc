#! /bin/zsh

source ~/.zshenv

if [[ -f ~/.path ]]; then
    source ~/.path
else
    export DOTPATH="${0:A:t}"
fi

if [[ -z $DOTPATH ]]; then
    echo "$fg[red]cannot start ZSH, \$DOTPATH not set$reset_cour" 1>&2
    return 1
fi

export VITAL_PATH="$DOTPATH/lib/vital.sh"
if [[ -f $VITAL_PATH ]]; then
    source "$VITAL_PATH"
fi

# Exit if called from vim
[[ -n $VIMRUNTIME ]] && return


# Check wether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "$fg[red]cannot vitalize$reset_color" 1>&2
    return 1
fi



#======================================
# Setup zplug && Modules
#======================================

if [[ ! -e ~/.zplug ]] then
    printf "Install zplug? [y/N]"
    if read -q; then
        echo
        curl -sL zplug.sh/installer | zsh
    fi
fi

unset ZPLUG_SHALLOW
source ~/.zplug/init.zsh
export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zplug"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
zplug load --verbose
